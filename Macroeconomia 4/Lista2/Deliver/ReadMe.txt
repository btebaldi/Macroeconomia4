Grupo:
BRUNA MIRELLE DE JESUS DA SILVA
BRUNO TEBALDI DE QUEIROZ BARBOSA 
MATHEUS ANTHONY DE MELO

FILE DESCRIPTION
Name                Desccription
----                -------------         ------ ----
Q3_Itens_efg.mod    dynare file, answers to question 3b, 3c, 3d
Q3_Itens_bcd.mod    dynare file, answers to question 3e, 3f, 3g
ReadMe.txt          Read me file
Macro_4_Lista_2.pdf PDF file, report

EXECUCAO DOS CODIGOS DA QUESTAO 3

ITENS 3b, 3c, 3d
	1) Abrir o MatLab
	2) Abrir o arquivo Q3_Itens_bcd.mod

	Para executar sob a regra de taylor
	3.1) Alterar a linha 8 para:
	@#define money_grow_rule = 0

	4.1) Salvar o arquivo Q3_Itens_bcd.mod
	
	5.1) Executar no "command" o comando:
	dynare Q3_Itens_bcd

	Para executar sob a regra monetária
	3.2) Alterar a linha 8 para:
	@#define money_grow_rule = 1

	4.2) Salvar o arquivo Q3_Itens_bcd.mod
	
	5.2) Executar no "command" o comando:
	dynare Q3_Itens_bcd

ITENS 3e, 3f, 3g
	1) Abrir o MatLab
	2) Abrir o arquivo Q3_Itens_efg.mod

	Para executar sob a regra de taylor
	3.1) Alterar a linha 8 para:
	@#define money_grow_rule = 0

	4.1) Salvar o arquivo Q3_Itens_efg.mod
	
	5.1) Executar no "command" o comando:
	dynare Q3_Itens_efg

	Para executar sob a regra monetária
	3.2) Alterar a linha 8 para:
	@#define money_grow_rule = 1

	4.2) Salvar o arquivo Q3_Itens_efg.mod
	
	5.2) Executar no "command" o comando:
	dynare Q3_Itens_efg