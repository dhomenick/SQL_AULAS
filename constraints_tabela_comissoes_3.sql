alter table comissoes
add constraint comissoes_pkey primary key(id);

alter table comissoes
add foreign key (funcionario_id) references funcionarios(id);