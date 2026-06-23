# Infra local

Sobe um PostgreSQL compativel com a configuracao atual de `ConexaoDB.java`:

- host: `localhost`
- porta: `5432`
- banco: `sistema-agendamento-salas`
- usuario: `postgres`
- senha: `postgres`

```bash
docker compose up -d
```

Para parar:

```bash
docker compose down
```

O schema inicial e carregado a partir de `../src/main/resources/db/migration/create_schema.sql` quando o volume do banco ainda esta vazio.
