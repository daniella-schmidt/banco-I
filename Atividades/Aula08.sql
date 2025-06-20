use nota_fiscal_normalizada;

create or replace view DaysOfWeek as -- replace pode ser considerada um update de um view
select 'segunda'
union select 'terça'
union select 'quarta'
union select 'quinta'
union select 'sexta'
union select 'sabado' 
union select 'domingo';
-- union select 'jeno';

select * from DaysOfWeek;
drop view DaysOfWeek;

create or replace view SalesResume as
--
select nf.nm_cliente as nome_cliente, 
	   count(nf.nro_nota) as total_notas,
	   count(inf.cod_produto) as total_itens,
       sum(inf.cod_produto) as qtd_total,
       sum(inf.vl_total) as vl_total,
       max(p.vl_produto) as max_vl_produto,
       min(p.vl_produto) as min_vl_produto
from nota_fiscal as nf
	inner join item_nota_fiscal as inf
		on nf.nro_nota = inf.nro_nota
	inner join produto as p
		on inf.cod_produto = p.cod_produto
group by nf.nm_cliente;

select
	nome_cliente, total_notas, vl_total
from SalesResume
where vl_total > 100;