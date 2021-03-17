/*
Programa:Merge Vendas.sas
Autor: Juan Ormelli de Medeiros
Data:09/03/2021 
Versao:1.00

Descrição:Resolução Exercicio 5 ( DataStep Merge) 


*/




*Organizndo os dados para o Primeiro Merge;
proc sort data=work.produtos_merge_final;
  by CodProduto;
run;

proc sort data=cgdexcel.vendas out=work.vendassort;
  by CodProduto;
run;
*DataStep para realizar prmeiro Merge;
data vendas_merge;
  merge work.vendassort (in=a)/*Criando Variaveis para realizar o InnerJoin*/
  	    work.produtos_merge_final(in=b);
  by CodProduto;
  if a=b;/*Verificando se as variaveis recebiam o valor igual para realizar o InnerJoin*/
  drop CodProduto;
run;
/*Organizamdo dados para Segundo Merge*/
proc sort data=work.vendas_merge;
  by CodCor;
run;
proc sort data=cgdexcel.cores out=work.coressort;
  by CodCor;
run;
/*Data Step Para segundo Merge*/
data vendas_merge;
  merge work.vendas_merge (in=a)
  	    work.coressort (in=b rename=descricao=Cor)/*Renomeando nome da Coluna para merge Funcionar*/;
  by CodCor;
  if a=b;
  drop CodCor;
run;
/*Organizando dados para Continuação Do Merge*/
proc sort data=cgdexcel.tamanhos out=work.tamanhossort;
  by CodTamanho;
run;
proc sort data=work.vendas_merge;
  by CodTamanho;
run;
/*Terceiro Merge */
data vendas_merge;
  merge work.vendas_merge (in=a)
  	    work.tamanhossort (in=b rename=descricao=tamanho);
  by CodTamanho;
  if a=b;
  drop CodTamanho;
run;
/*Organizando dados para Continuação Do Merge*/
proc sort data=work.estado_merge;
  by CodEstado;
run;

proc sort data=work.vendas_merge;
  by CodEstado;
run;
 /*Realizando Merge Final*/
data Vendas_Merge_Final;
  merge work.vendas_merge (in=a)
  	    work.estado_merge (in=b rename=nome=Estado);
  by CodEstado;
  if a=b;
  drop CodEstado;
run;

proc print data=work.vendas_merge_final;
run;


