# mbox_floor_app

Novamente o aplicativo de lista de compras mas com o uso de outros recursos

## Resumo

Nesse app fpi utilizado o recurso de SQlite SQLite que é uma biblioteca em linguagem C que implementa um banco de dados SQL embutido.
Programas que usam a biblioteca SQLite podem ter acesso a banco de dados SQL sem executar um processo SGBD separado.

No caso desse app o banco de dados e interno ele esta localizado no pacote Repositories. Comandos como "@Query('SELECT * FROM Produto order by concluido, nome')"
localizados no arquivo "produto.dao.dart"são comandos em SQL que selecionam tabelas de banco de dados.

O arquivo database.dart possui um comando que ao executar no terminal "flutter packages pub run build_runner build" a IDE gera o banco com as tabelas internas
 resultando no arquivo database.g.dart

Entao pode se dizer que esse programa e uma lista de compras com um banco de dados interno
