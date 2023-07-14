use AdventureWorks2014

select*from Production.ProductCategory 

Create view DimProducto
as
select p.ProductID,
p.Name,
Size,
ListPrice,
Color
from Production.Product p


Create view DimCategoria
as
select
Psc.ProductSubcategoryID,
Psc.Name as [Nombre Subcategoria],
Pc.Name as [Nombre Categoria]
from Production.ProductSubCategory Psc 
inner join Production.ProductCategory Pc
on Pc.ProductCategoryID =Psc.ProductCategoryID

Create view DimFecha
as
select distinct Orderdate as IDFecha,
YEAR(OrderDate) as Año,
MONTH(OrderDate) as Mes,
DAY(Orderdate) as Día,
DATEPART(QQ,OrderDate) as Trimestre,
DATEPART(ISOWK, OrderDate) as IsoSemana
from Sales.SalesOrderHeader

select*from Sales.SalesOrderHeader

Create view DimOrder
as
select
sod.ProductID as ProductID,
soh.OrderDate as IDFecha,
--Count(sod.SalesOrderID) as Cantidad,
sod.OrderQty as [Cantidad de Producto],
sod.UnitPrice as Precio,
(sod.OrderQty * sod.UnitPrice) as Subtotal,
sod.UnitPriceDiscount as Descuento,
(sod.OrderQty * sod.UnitPrice * (1-sod.UnitPriceDiscount)) as total
from Sales.SalesOrderDetail sod
inner join Sales.SalesOrderHeader soh
on soh.SalesOrderID = sod.SalesOrderID
--group by
--sod.ProductID,
--soh.OrderDate,
--sod.OrderQty ,
--sod.UnitPrice,
--sod.UnitPriceDiscount


--945 recaudacion 
create view Dim945Order
as
select sum(sod.OrderQty) as [Cantidad de productos],
sod.OrderQty,
sod.UnitPrice,
sod.UnitPriceDiscount,
(sod.OrderQty * sod.UnitPrice) as Subtotal,
(sod.OrderQty * sod.UnitPrice * (1-sod.UnitPriceDiscount)) as total
from Sales.SalesOrderDetail sod
group by 
sod.OrderQty ,
sod.UnitPrice,
sod.UnitPriceDiscount


