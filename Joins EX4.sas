/*
Programa:Joins EX4.sas
Autor: Juan Ormelli de Medeiros
Data:09/03/2021
Versao:1.00

Descrição: Resolução Exercicio 4 (Joins Proc SQL) 


*/

proc sql;
	create table Vendas_Join as
	select v.*,
	p.descricao as NomeProduto,
	c.descricao as Cor,
	t.descricao as Tamanho,
	e.Nome as Estado
	from cgdexcel.vendas as v
	inner join cgdexcel.produtos as p on v.CodProduto=p.CodProduto  
	inner join cgdexcel.cores as c on v.CodCor=c.CodCor
	inner join cgdexcel.tamanhos as t on v.CodTamanho=t.CodTamanho
	inner join cgdexcel.estados as e on v.CodEstado = e.CodEstado;
run;

proc sql;
	alter table work.vendas_join
	drop CodProduto, CodCor, CodTamanho, CodEstado;
run;

proc sql;
	create table produtos_join as
	SELECT p.*,g.Descricao as NomeGrupo,d.descricao as NomeDepto 
	from cgdexcel.produtos as p
	inner join cgdexcel.grupos as g on p.CodGrupo = g.CodGrupo
	inner join cgdexcel.deptos as d on p.CodDepto = d.CodDepto;

run;

proc sql;
	alter table produtos_join
	drop CodGrupo, CodDepto;
run;


proc sql;
	create table estados_join as
	SELECT e.*,r.Nome as Regiao 
	from cgdexcel.estados as e
	inner join cgdexcel.regioes as r on e.CodRegiao =r.CodRegiao;
run;
proc sql;
	alter table estados_join
	drop CodRegiao ;
run;
