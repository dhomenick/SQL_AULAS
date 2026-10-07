create table comissoes(
id int not null,
funcionario_id int,
comissao_valor real,
comissao_situacao varchar(1) default 'A',
data_criacao
timestamp,
data_atualizacao timestamp);