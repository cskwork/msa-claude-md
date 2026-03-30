# Query Service

Serves analytics queries against ClickHouse, handles caching and result pagination.

## Commands

| Command | Description |
|---------|-------------|
| `uvicorn app.main:app --reload` | Dev server |
| `pytest` | Run all tests |
| `pytest --cov=app` | Tests with coverage |
| `alembic upgrade head` | Run DB migrations |

## Architecture

```
app/
  api/           # Route handlers
  core/          # Config, security, dependencies
  models/        # SQLAlchemy models
  schemas/       # Pydantic request/response schemas
  services/      # Business logic + ClickHouse queries
  repositories/  # Data access layer
  cache/         # Redis caching layer
```

## Key Files

- `app/main.py` -- FastAPI app entry point
- `alembic/` -- PostgreSQL migrations (metadata store)
- `app/services/clickhouse.py` -- ClickHouse query builder

## Dependencies

| Service | Protocol | Purpose |
|---------|----------|---------|
| `auth` | REST | JWT token validation |
| `transform` | RabbitMQ | Receives processed data events |

## API & DB

- API contract: See `/docs` (auto-generated Swagger)
- OLTP DB: PostgreSQL -- See `alembic/versions/`
- Analytics DB: ClickHouse -- See `docs/clickhouse-schema.md`

## Env Vars

See `.env.example` -- key vars: `DATABASE_URL`, `CLICKHOUSE_URL`, `REDIS_URL`, `PORT`

## Gotchas

- ClickHouse queries must use parameterized queries -- no f-string interpolation
- Redis cache TTL is 5 minutes for dashboards, 1 hour for exports
