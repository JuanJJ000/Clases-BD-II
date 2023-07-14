
--Primer SQLstatement de la "tarea ejecutar" °

EXEC SP_MSFOREACHTABLE 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

GO

EXEC SP_MSFOREACHTABLE 'ALTER TABLE ? DISABLE TRIGGER ALL'

GO

--del sqlcomand °

UPDATE [DBO].[DIMSUPPLIERS] SET [FECHAFINAL] = ? WHERE [SUPPLIERID] = ? AND [FECHAFINAL] ='9999 - 12 - 31'

--Cambiar [DIMSUPPLIERS] y [SUPPLIERID] por la tabla y el id correspondiente a la tabla que escogio


--Segundo SQLstatement de la "tarea ejecutar" para la "Dimension Fecha" que tengas °

EXEC sp_msforeachtable 

'BEGIN TRY

TRUNCATE TABLE DimFechas

END TRY

BEGIN CATCH

DELETE FROM DimFechas

END CATCH '

GO

DBCC CHECKIDENT (DimFechas, RESEED,0)


--En el origen OLE DB de la "Dimension Fecha" que tengas se debe crear una consulta que sea parecida a esta °

select distinct Orderdate as IdFecha,
year(Orderdate) as Año,
month(Orderdate) as NoMes,
day(Orderdate) as Dia,
datename(Week,Orderdate) as NombreDia,
datename(month,Orderdate) as NombreMes,
datepart(QQ,Orderdate) as Trimestre
from Northwind.dbo.Orders

--con la fecha principal que vayas a trabajar remplazaras a "Orderdate"

--Carga de la tabla de hechos °


Delete from DimCliente
Delete from DimEmpleado
Delete from DimEmpresaEnvio
Delete from DimFecha
Delete from FactOrdenes
---------------------------------------------
DBCC CHECKIDENT (DimFecha, RESEED,0)
DBCC CHECKIDENT (DimCliente, RESEED,0)
DBCC CHECKIDENT (DimEmpleado, RESEED,0)
DBCC CHECKIDENT (DimEmpresaEnvio, RESEED,0)
DBCC CHECKIDENT (Factordenes, RESEED,0)
------------------------------------------------------
Select * from DimCliente
Select * from DimEmpleado
Select * from DimEmpresaEnvio
Select * from DimFecha 
Select * from FactOrdenes 
--------------------------------------------------------
-- Carga de Tabla de Hechos
-------------------------------------------------------------
Merge dbo.FactOrdenes Destino
Using
(Select 
df.DimfechaID as DimFechaID,
de.DimEmployeeID as DimEmployeeID,
dc.DimCustomerID as DimCustomerID,
ee.DimShipperID as DimShipperID,
count(Distinct o.OrderID) as Cantidad,
round (sum(od.Quantity * od.UnitPrice),2) as SinDescuento,
round (sum((od.Quantity * od.UnitPrice)- (od.Quantity * od.UnitPrice * od.Discount)),2) as Recaudacion
from Northwind.dbo.Orders o
inner join Northwind.dbo.[Order Details] od
on od.OrderID = o.OrderID
inner join DimFecha df
on df.IdFecha = o.OrderDate
inner join DimEmpleado de
on de.EmployeeID = o.EmployeeID
inner join DimCliente dc
on dc.CustomerID = o.CustomerID
inner join DimEmpresaEnvio ee
on ee.ShipperID = o.ShipVia
WHERE de.FechaFinal='9999/12/31' AND 
	  dc.FechaFinal='9999/12/31' AND 
	  ee.FechaFinal='9999/12/31' 
Group by
df.DimFechaID,
de.DimEmployeeID,
dc.DimCustomerID ,
ee.DimShipperID) Origen
on
Destino.DimCustomerID = Origen.DimCustomerID and
Destino.DimEmployeeID = Origen.DimEmployeeID and
Destino.DimShipperID = Origen.DimShipperID and
Destino.DimFechaID = Origen.DimFechaID
WHEN MATCHED AND (Destino.Cantidad <> Origen.Cantidad or
                  Destino.Sindescuento <> Origen.SinDescuento or
				  Destino.Recaudacion <> Origen.Recaudacion)
				  Then
				  Update set
				  Destino.Cantidad = Origen.Cantidad,
                  Destino.Sindescuento = Origen.SinDescuento,
				  Destino.Recaudacion = Origen.Recaudacion
WHEN NOT MATCHED THEN 
            INSERT
			(DimFechaID, DimEmployeeID, DimCustomerID, DimShipperID,
			 Cantidad, SinDescuento, Recaudacion)
			 Values
			 (Origen.DimFechaID,Origen.DimEmployeeID, Origen.DimCustomerID,



--codigo del SQL Statement final del proceso final, despues de la tabla de hechos °

EXEC sp_msforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'

GO

EXEC sp_msforeachtable 'ALTER TABLE ? ENABLE TRIGGER ALL'

--para habilitar las llaves foraneas
