create view RecaudacionesSeguros_SA
as
select
	'Seguros SA' as Empresa,
	'Monto X Gastos de Hospitalizacion' as TipoServicio,
	(select(sum(dh.Costo)) from DetalleHospitalizacion dh) as Recaudacion
	union all
select
	'Seguros SA' as Empresa,
	'Monto X Consultas' as TipoServicio,
	(select(sum(cs.TotalGastosAdicionales+cs.GastoFijo)) from Consulta cs) as Recaudacion
	union all
select
	'Serviplus' as Empresa,
	'Monto X Polizas' as TipoServicio,
	(select(sum(pl.Costo)) from Poliza pl) as Recaudacion
	union all
select
	'Serviplus' as Empresa,
	'Monto X Repuestos' as TipoServicio,
	(select(sum(drp.Precio)) from Serviplus.dbo.Detalle_Repuesto drp) as Recaudacion
	union all
select
	'Serviplus' as Empresa,
	'Monto X Servicios de Mantenimiento' as TipoServicio,
	(select(sum(dm.Precio)) from Serviplus.dbo.Detalle_Mantenimiento dm) as Recaudacion

create login Gerente with password='123456'
create user persona from login Gerente
grant select to persona


db.Personas.find({peso: {$lte: 80, $lte: 100}}).pretty()