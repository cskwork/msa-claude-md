# DataLens - Analytics Platform

Real-time analytics platform with FastAPI data pipeline and Next.js dashboard.

## Service Domains

### Core
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `auth` | `services/auth/` | Python/FastAPI | 8001 |
| `user` | `services/user/` | Python/FastAPI | 8002 |

### Data Pipeline
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `ingest` | `services/ingest/` | Python/FastAPI | 8003 |
| `transform` | `services/transform/` | Python/FastAPI | 8004 |
| `query` | `services/query/` | Python/FastAPI | 8005 |

### Frontend
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `dashboard` | `frontends/dashboard/` | Next.js | 3000 |

## Quick Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start all services |
| `cd services/query && uvicorn app.main:app --reload` | Start single backend |
| `cd frontends/dashboard && npm run dev` | Start frontend |
| `cd services/query && pytest` | Test single service |

## Shared Conventions

- API specs: See `docs/api/` (auto-generated from FastAPI)
- Shared libs: See `libs/common/`
- Env config: `.env.example` per service
- DB migrations: See `<service>/alembic/`
- New service setup: See `docs/service-template.md`

## Cross-Service Patterns

- Sync: REST with shared Pydantic models from `libs/common`
- Async: RabbitMQ -- See `docs/events.md`
- Auth: OAuth2 + JWT -- See `docs/auth-flow.md`
- Observability: OpenTelemetry -- See `docs/observability.md`

## Gotchas

- Python 3.11+ required -- uses `asyncio.TaskGroup`
- `ingest` service must start before `transform` (queue initialization)
- ClickHouse is used for analytics queries, PostgreSQL for OLTP

Each service has its own `CLAUDE.md` -- auto-loaded when working in that directory.
