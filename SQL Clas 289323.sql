use Northwind

go

select e.EmployeeID, e.FirstName, et.TerritoryID, t.TerritoryDescription, r.RegionDescription
from EmployeeTerritories et
inner join Employees e on e.EmployeeID = et.EmployeeID
inner join Territories t on t.TerritoryID = et.TerritoryID
inner join Region r on r.RegionID= t.RegionID


select distinct  r.RegionDescription,round(SUM((od.Quantity * od.UnitPrice) * (1-od.Discount)),2) as Total
from EmployeeTerritories et
inner join Employees e on e.EmployeeID = et.EmployeeID
inner join Territories t on t.TerritoryID = et.TerritoryID
inner join Region r on r.RegionID= t.RegionID
inner join Orders o on e.EmployeeID= o.EmployeeID
inner Join [Order Details] od on o.OrderID= od.OrderID
group by r.RegionDescription 
order by r.RegionDescription

select
round(sum((od.Quantity * od.UnitPrice) * (1-od.Discount)),2)
from [Order Details] od


select A.RegionDescription,SUM(Recaudación) as Recaudación from
(select distinct e.EmployeeID, r.RegionDescription
from EmployeeTerritories et
inner join Employees e on e.EmployeeID = et.EmployeeID
inner join Territories t on t.TerritoryID = et.TerritoryID
inner join Region r on r.RegionID= t.RegionID) A

inner join

(select o.EmployeeID, round(sum((od.Quantity * od.UnitPrice) * (1-od.Discount)),2) as  Recaudación
from [Order Details] od
inner join orders o on o.OrderID= od.OrderID
inner join Employees e on  e.EmployeeID =o.EmployeeID
group by o.EmployeeID
)B
 
 on B.EmployeeID = A.EmployeeID
 group by A.RegionDescription




