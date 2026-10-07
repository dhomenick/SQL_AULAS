--triggers

--criando a tabela de log de produtos

create table logs_produtos(
     id int not null primary key,
     data_alteracao timestamp,
     alteracao varchar(10),
     id_old int,
     produto_codigo_old varchar(20),
     produto_nome_old varchar(60),
     produto_valor_old real,
     produto_situacao_old varchar(1) default 'A',
     data_criacao_old timestamp,
     data_atualizacao_old timestamp,
     id_new int,
     produto_codigo_new varchar(20),
     produto_nome_new varchar(60),
     produto_valor_new real,
     produto_situacao_new varchar(1) default 'A',
     data_criacao_new timestamp,
     data_atualizacao_new timestamp
);

--criando uma sequence

create sequence logs_produto_id_seq;

--vinculando a sequence a tabela

alter table
     logs_produtos
alter column
     id
set
     default nextval('logs_produto_id_seq');

--criando uma função

create
or replace function gera_log_produtos() returns trigger as 
$$ Begin if TG_OP = 'INSERT' then
insert into
     logs_produtos (
          alteracao,
          data_alteracao,
          id_new,
          produto_codigo_new,
          produto_nome_new,
          produto_valor_new,
          produto_situacao_new,
          data_criacao_new,
          data_atualizacao_new
     )
values
     (
          TG_OP,
          now(),
          new.id,
          new.produto_codigo,
          new.produto_nome,
          new.produto_valor,
          new.produto_situacao,
          new.data_criacao,
          new.data_atualizacao
     );

return new;

elsif TG_OP = 'UPDATE' then
insert into
     logs_produtos (
          alteracao,
          data_alteracao,
          id_old,
          produto_codigo_old,
          produto_nome_old,
          produto_valor_old,
          produto_situacao_old,
          data_criacao_old,
          data_atualizacao_old,
          id_new,
          produto_codigo_new,
          produto_nome_new,
          produto_valor_new,
          produto_situacao_new,
          data_criacao_new,
          data_atualizacao_new
     )
values
     (
          TG_OP,
          now(),
          old.id,
          old.produto_codigo,
          old.produto_nome,
          old.produto_valor,
          old.produto_situacao,
          old.data_criacao,
          old.data_atualizacao,
          new.id,
          new.produto_codigo,
          new.produto_nome,
          new.produto_valor,
          new.produto_situacao,
          new.data_criacao,
          new.data_atualizacao
     );

return new;

elsif TG_OP = 'DELETE' then
insert into
     logs_produtos (
          alteracao,
          data_alteracao,
          id_old,
          produto_codigo_old,
          produto_nome_old,
          produto_valor_old,
          produto_situacao_old,
          data_criacao_old,
          data_atualizacao_old
     )
values
     (
          TG_OP,
          now(),
          old.id,
          old.produto_codigo,
          old.produto_nome,
          old.produto_valor,
          old.produto_situacao,
          old.data_criacao,
          old.data_atualizacao
     );

return new;

end if;

end;

$$ language 'plpgsql';

--criando o trigger
create trigger tri_log_produtos
after
insert
     or
update
     or delete on produtos for each row execute procedure gera_log_produtos();

--informações da tabela com o novo trigger
\d produtos;

--inserção de dados
insert into
     produtos (
          produto_nome,
          produto_valor,
          produto_situacao,
          data_criacao,
          data_atualizacao
     )
values
     (
          'LAZANHA',
          46,
          'A',
          '2016-01-01',
          '2016-01-01'
     );

insert into
     produtos (
          produto_nome,
          produto_valor,
          produto_situacao,
          data_criacao,
          data_atualizacao
     )
values
     (
          'PANQUECA',
          38,
          'A',
          '2016-01-01',
          '2016-01-01'
     );

insert into
     produtos (
          produto_nome,
          produto_valor,
          produto_situacao,
          data_criacao,
          data_atualizacao
     )
values
     (
          'CHURRASCO',
          72,
          'A',
          '2016-01-01',
          '2016-01-01'
     );

--consulta

select
     alteracao,
     data_alteracao,
     id_new,
     produto_codigo_new,
     produto_nome_new,
     produto_valor_new,
     produto_situacao_new,
     data_criacao_new,
     data_atualizacao_new
from
     logs_produtos;

--atualização
update
     produtos
set
     produto_valor = 99
where
     produto_nome = 'CHURRASCO';

--consulta

select
     *
from
     logs_produtos;

--remoção

delete from
     produtos
where
     produto_nome = 'PANQUECA';

--consulta

select
     *
from
     logs_produtos;

--desabilitar o trigger

alter table produtos disable trigger tri_log_produtos;

--verificar se está desabilitado
\d produtos;

--remover o trigger

drop trigger tri_log_produtos on produtos;

--informações da tabela, verificar remoção

\d produtos;

