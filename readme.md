# EcoturPostgre
Este repositório contém a estrutura de schemas, tabelas, regras de validação, chaves estrangeiras e views do projeto Ecotrail Aventuras.

A ordem de execução obrigatoriamente deve ser:

01) admin.sql
Criação do schema admin.
Tabela admin.usuarios + validação de CPF (CHECK).

3) site.sql

Criação do schema site.
Tabelas site.pacotes e site.reservas.
Vinculação da FK de site.reservas apontando para admin.usuarios.
Views do catálogo e detalhes da reserva.

03)contabil.sql
Criação do schema contabil.
Tipo customizado contabil.forma (ENUM).
Tabela contabil.pagamentos.
Vinculação da FK de contabil.pagamentos apontando para site.reservas.
View do relatório financeiro.

Abra o pgAdmin 4 e conecte-se ao seu servidor.
Crie a base de dados (ex: ecoturismotrabalho)
Clique com o botão direito na base de dados e abra a Query Tool.
Abra e execute os arquivos do diretório scripts/ um a um, na ordem indicada acima