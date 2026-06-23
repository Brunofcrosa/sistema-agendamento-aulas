# Sistema de Agendamento de Salas

Objetivo desse projeto e resolver o problema dos professores que querem uma sala especifica e nem sempre sabem quais horarios estao disponiveis.

## O que o sistema faz

- autenticacao de usuarios com login por e-mail e senha.
- criacao de conta para novos usuarios.
- gerenciamento de docentes.
- gerenciamento de salas.
- reserva de salas de aula.

## Tecnologias

- Java com Spring MVC/Spring Boot
- JSP
- PostgreSQL

- **controller:** organiza o fluxo das telas com controllers Spring MVC.
- **service:** regras de negocio.
- **dao:** comunicacao com o PostgreSQL.
- **model:** classes do sistema.
- **src/main/webapp:** paginas JSP, includes visuais e arquivos estaticos.

O projeto usa `RedirectAttributes` para mensagens depois de redirects, seguindo o fluxo Post-Redirect-Get explicado nos slides de Spring MVC.

## Fluxo principal da aplicacao

- O usuario acessa a tela de login.
- Depois de autenticado, entra no painel principal.
- A partir dali, pode gerenciar docentes, salas e reservas.
- Ao criar uma reserva, o sistema valida horarios e impede choque de agenda.

## Banco de dados

O schema atual possui quatro entidades principais:

- usuario
- docente
- sala
- reserva

O script de criacao esta em:

`src/main/resources/db/migration/create_schema.sql`

Hoje a conexao com o banco esta configurada diretamente em codigo, em `src/main/java/dao/ConexaoDB.java`.

- **host:** localhost
- **porta:** 5432
- **banco:** sistema-agendamento-salas
- **usuario:** postgres
- **senha:** postgres

## Como rodar localmente

### Pre-requisitos

- Java 21 instalado ou configurado na IDE
- PostgreSQL em execucao

### Passos

1. Crie o banco `sistema-agendamento-salas` no PostgreSQL.
2. Execute o script `src/main/resources/db/migration/create_schema.sql`.
3. Verifique a conexao em `src/main/java/dao/ConexaoDB.java`.
4. Rode a aplicacao com Spring Boot:

```bash
./mvnw spring-boot:run
```

No Windows:

```bash
mvnw.cmd spring-boot:run
```

5. Acesse `http://localhost:9090`.

O projeto nao depende mais do WildFly para rodar em desenvolvimento; o Spring Boot sobe a aplicacao com Tomcat.
