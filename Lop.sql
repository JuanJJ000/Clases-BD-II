--Realizar un procedimiento de almacenado que al ejecutarse tome la referencia del monto de ventas del mes, en el a�o anterior vs el mes en el a�o actual,
--establecer que la meta de recaudacion es un 15% arriba de esa recaudacion del mes de junio.



use Northwind
go
select
DATENAME(MONTH, OrderDate) as MesActual,
DateName(Month,(DateAdd (year,-1,OrderDate))) as MesAnterior,
(year(getdate())-1 ) as A�o
from Orders
where OrderID =10248


Create procedure ventas_Junio
as
select sum(od.quantity * od.UnitPrice * (1-od.Discount))as [Ventas A�o Anterior],
       DateName(Month,(DateAdd (year,-1,OrderDate))) as MesAnterior,
  --as [Meta a�o Anterior],
  sum(od.quantity * od.UnitPrice * (1-od.Discount)) as[Ventas A�o Actual],
  DATENAME(MONTH, OrderDate) as MesActual,
  --as[Meta a�o Actual
  (year(getdate())-1 ) as A�o
from Orders o
inner Join [Order Details] od on od.OrderID = o.OrderID 
where MONTH(o.OrderDate) = MONTH(DATEADD(Month, -1, o.OrderDate))   /*   cambiarle los orderdate por una fecha especifica*/
group by
o.OrderDate



