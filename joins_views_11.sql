--joins

select funcionario_nome from funcionarios where id in (select funcionario_id
from vendas where date_part('year', data_criacao) = '2016');

select funcionario_nome from funcionarios where id in (select funcionario_id
from vendas) order by funcionario_nome;

select distinct funcionario_nome from funcionarios, vendas where funcionarios.id = vendas.funcionario_id order by funcionario_nome;

select distinct funcionario_nome from funcionarios inner join vendas on (funcionarios.id = vendas.funcionario_id) order by funcionario_nome;

select funcionario_nome, v.id from funcionarios f left join vendas v on f.id = v.funcionario_id
order by funcionario_nome desc;

select v.id, v.venda_total, funcionario_nome from vendas v right join funcionarios f
on v.funcionario_id = f.id order by v.venda_total;

--views e execução de views

create or replace view vendas_do_dia as
select distinct produto_nome
, sum(vendas.venda_total)
from produtos, itens_vendas, vendas
where produtos.id = itens_vendas.produto_id
and vendas.id
= itens_vendas.vendas_id
and vendas.data_criacao = '2016-01-01'
group by produto_nome;



select * from vendas_do_dia;

select * from vendas_do_dia where produto_nome = 'PASTEL';


create or replace view produtos_vendas as
select produtos.id PRODUTO_ID
, produtos.produto_nome PRODUTO_NOME
, vendas.id VENDA_ID
, itens_vendas.id ITEM_ID
, itens_vendas.item_valor ITEM_VALOR
, vendas.data_criacao DATA_CRIACAO
from produtos, vendas, itens_vendas
where vendas.id
= itens_vendas.vendas_id
and produtos.id = itens_vendas.produto_id
order by data_criacao desc;


select * from produtos_vendas;

select produto_nome from produtos_vendas where data_criacao = '2016-01-01';



create or replace view produtos_estoque as
select *
from produtos;


select produto_nome from produtos_estoque;











