# Sistema de Agendamento de Salas

Objetivo desse projeto é resolver o problema dos professores, querer uma sala específica e nunca estar disponível ou não saber que horários ele poderia usufruir dessa sala.

## O que o sistema faz:
- autenticação de usuários com login por e-mail e senha.
- criação de conta para novos usuários.
- gerenciamento de docentes.
- gerenciamento de salas.
- reserva de salas de aula.

## Tecnologias:
- Java com JSP
- PostgreSQL

- **controller:** organizar o fluxo das telas.
- **service:** regras de negócio.
- **dao:** comunicação com o PostgreSQL.
- **model:** classes do sistema.
- **src/main/webapp:** páginas JSP, includes visuais e arquivos estáticos.

## Fluxo principal da aplicação:
- O usuário acessa a tela de login.
- Depois de autenticado, entra no painel principal.
- A partir dali, pode gerenciar docentes, salas e reservas.
- Ao criar uma reserva, o sistema valida horários e impede choque de agenda.

## Banco de dados

O schema atual possui quatro entidades principais:
- usuario
- docente
- sala
- reserva

O script de criação está em:
`src/main/resources/db/migration/create_schema.sql`

Hoje a conexão com o banco está configurada diretamente em código, em `src/main/java/dao/ConexaoDB.java`
- **host:** localhost
- **porta:** 5434 (porta do seu postgresql)
- **banco:** sistema-agendamento-salas
- **usuário:** postgres
- **senha:** postgres

## Como rodar localmente

### Pré-requisitos
- Java instalado
- Maven instalado
- PostgreSQL em execução
- um servidor compatível com aplicações WAR(usei wildfly)

### Passos
1. Crie o banco `sistema-agendamento-salas` no PostgreSQL.
2. Execute o script `src/main/resources/db/migration/create_schema.sql`.
3. Verifique a conexão em `src/main/java/dao/ConexaoDB.java`.
