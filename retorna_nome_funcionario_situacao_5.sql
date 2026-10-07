create or replace function
	retorna_nome_funcionario(func_id int)
	returns text as
		$$
		declare nome text;
		situacao text;
		begin
		select funcionario_nome,
		funcionario_situacao
		into nome, situacao
		from funcionarios
		where id = func_id;
		if situacao = 'A' then
		return nome || ' Usuário Ativo';
		else
		return nome || ' Usuário Inativo';
		end if;
		end
		$$
	language plpgsql;