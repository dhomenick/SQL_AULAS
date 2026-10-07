--tipos de dados especiais array

alter table produtos add column produto_categoria text[];

insert into produtos (produto_codigo,
produto_nome,
produto_valor,
produto_situacao,
data_criacao,
data_atualizacao,
produto_categoria)
values ('03251',
'ESFIRRA',
5,
'A',
'01/01/2016',
'01/01/2016',
'{"CARNE", "SALGADO", "ASSADO" , "QUEIJO"}');

select produto_categoria from produtos where produto_nome like 'ESFIRRA';

select produto_categoria[2] from produtos where produto_nome like 'ESFIRRA';

select produto_categoria[2:4] from produtos where produto_nome like 'ESFIRRA';

--tipos de dados especiais json

alter table produtos add column produto_estoque json;

insert into produtos(produto_codigo,
produto_nome,
produto_valor,
produto_situacao,
data_criacao,
data_atualizacao,
produto_categoria,
produto_estoque)
values('6234',
'COCA-COLA',
6,
'A',
'01/01/2016',
'01/01/2016',
'{"REFRIGERANTE",
"LATA",
"BEBIDA" ,
"COLA"}',
'{ "info_estoque":
{ "tem_estoque": "SIM",
"quantidade": 17,
"ultima_compra": "01/01/16" }
}'
);

select produto_estoque->'info_estoque'->>'quantidade'
as quantidade
from produtos
where produto_nome like 'COCA-COLA';


select produto_estoque->'info_estoque'->>'ultima_compra'
as ultima_compra
from produtos
where produto_nome like 'COCA-COLA';

insert into produtos(produto_codigo,
produto_nome,
produto_valor,
produto_situacao,
data_criacao,
data_atualizacao,
produto_categoria,
produto_estoque)
values('77978',
'GATORADE',
6,
'A',
'01/01/2016',
'01/01/2016',
'{"ISOTONICO",
"GARRAFA",
"BEBIDA" }',
'{ "info_estoque":
{ "tem_estoque": "SIM",
"quantidade": 17,
"ultima_compra": "01/01/16" },
"ultima_venda": "02/01/2016"
}'
);




select produto_estoque
from produtos
where produto_estoque->>'ultima_venda' = '02/01/2016';