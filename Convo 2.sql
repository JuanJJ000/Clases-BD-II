
Restore Filelistonly 
from disk = 'D:\Convocatoria2023.bak'

restore headeronly
from disk = 'D:\Convocatoria2023.bak'



--Examen de Convocatoria BD II.

--1. Restaure la BD Adventure Works.

use master
Restore database Adventure from disk= 'D:\Convocatoria2023.bak'

--2. Desvincular la BD y ubicarla en el disco duro C crear una carpeta llamada AdventureFiles, vincular los archivos DATA en una carpeta y en otra carpeta ubicar el archivo LOG. 10pts.



use Master
go
sp_detach_db Adventure

sp_attach_db Adventure,
'C:\AdventureFiles\Data\AdventureWorks2012_Data.mdf',
'C:\AdventureFiles\Data\Convocatoria2023.ndf',
'C:\AdventureFiles\Log\AdventureWorks2012_log.ldf'





--3. Realizar un 1 respaldo diferencial y 2 respaldos Log. 10pts.




Backup database Adventure
to disk = 'D:\AdventureWork.bak'
with
name='Respaldo diferencial',
Description = 'Copia Diferencial de archivos de BD',
differential

Backup log Adventure
to disk = 'D:\AdventureWork.bak'
with 
name='Respaldo transaccion 1'

Backup log Adventure
to disk = 'D:\AdventureWork.bak'
with 
name='Respaldo transaccion 2'

--4. Restaurar la BD con los respaldos del inciso 3 en la última posición y ubicar los archivos con la mismas carpetas pero en otra partición del disco duro. 10pts.pts.



restore database Adventure
from disk = 'D:\Convocatoria2023.bak'
with file=1,
move 'AdventureWorks2012_Data' to 'D:\AdventureFiles\Data\AdventureWorks2012_Data.mdf',
move 'Convocatoria2023' to 'D:\AdventureFiles\Data\Convocatoria2023.ndf',
move 'AdventureWorks2012_log' to 'D:\AdventureFiles\Log\AdventureWorks2012_log.ldf',norecovery

restore database Adventure
from disk = 'D:\Convocatoria2023.bak'
with file=2,
move 'AdventureWorks2012_Data' to 'D:\AdventureFiles\Data\AdventureWorks2012_Data.mdf',
move 'Convocatoria2023' to 'D:\AdventureFiles\Data\Convocatoria2023.ndf',
move 'AdventureWorks2012_log' to 'D:\AdventureFiles\Log\AdventureWorks2012_log.ldf',norecovery

restore log Adventure
from disk = 'D:\Convocatoria2023.bak'
with file=3,
move 'AdventureWorks2012_Data' to 'D:\AdventureFiles\Data\AdventureWorks2012_Data.mdf',
move 'Convocatoria2023' to 'D:\AdventureFiles\Data\Convocatoria2023.ndf',
move 'AdventureWorks2012_log' to 'D:\AdventureFiles\Log\AdventureWorks2012_log.ldf',norecovery


restore log Adventure
from disk = 'D:\Convocatoria2023.bak'
with file=4,
move 'AdventureWorks2012_Data' to 'D:\AdventureFiles\Data\AdventureWorks2012_Data.mdf',
move 'Convocatoria2023' to 'D:\AdventureFiles\Data\Convocatoria2023.ndf',
move 'AdventureWorks2012_log' to 'D:\AdventureFiles\Log\AdventureWorks2012_log.ldf',recovery



--5. Realizar una alerta en el sistema al correo electrónico que indique informe cuando un registro es eliminado de la tabla SalesOrderDetail, mostrar el ID del producto y la cantidad vendida. 20pts.

use Adventure

create procedure EliminadoAlerta
@SalesOrderDetID int
AS
BEGIN
	Declare @Usuario varchar(50)
	Declare @IDProducto int
	Declare @Cantidad int
	Declare @Subtotal varchar(50)

	SELECT	@IDProducto = Sod.ProductID,
			@Cantidad = sod.OrderQty
	FROM [Sales].[SalesOrderDetail] AS Sod
	WHERE Sod.SalesOrderDetailID = @SalesOrderDetID
	GROUP BY Sod.ProductID,sod.OrderQty

	SET @Usuario = SUSER_SNAME()

	Delete from [Sales].[SalesOrderDetail] where SalesOrderDetail.SalesOrderDetailID = @SalesOrderDetID

	DECLARE @BodyError NVARCHAR(MAX) = N''
	SET @BodyError =	'Sales ID:'+CAST(@SalesOrderDetID AS varchar(50))+', 
						IDProducto:'+CAST(@IDProducto AS varchar(50))+',
						Cantidad: '+CAST(@Cantidad AS varchar(50))+',
						registro eliminado por el usuario: '+@Usuario;
               
	Raiserror(@BodyError,1,1)
END
 execute EliminadoAlerta 69


 
exec msdb.[dbo].[sp_send_dbmail]
@profile_name = 'Admin',
@recipients = 'juanesgamesa@outlook.com',
@copy_recipients = 'juanesgamesa@outlook.com',
@subject = 'AlertaSistema',
@body = 'Eliminado_SalesOrderDetail',
@query = 'execute AlertaSistema 69',
@attach_query_result_as_file = 1



--6. En la BD Adventure Works realizar un esquema estrella orientado a los productos de la empresa únicamente para las ventas por internet(Vistas). 20pts. 


--7. A travez de las vistas del cubo presentar en POWER BI:
   -- Cantidad de productos enviados por Empresa de Envío. Filtrar por producto y Año.  10pts.
   -- Recaudaciones por mes filtradas por año. 10pts.
   -- Top 3 de los productos más vendidos, mostrar cantidad y recaudación. Filtrar por Territorios. 10pts.
   

   
   
















