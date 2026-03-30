# TaskHub - Project Management Platform

SaaS project management tool with Express API and React/Next.js frontend.

## Service Domains

### Core
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `auth` | `services/auth/` | Node/Express | 4001 |
| `user` | `services/user/` | Node/Express | 4002 |

### Business
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `project` | `services/project/` | Node/Express | 4003 |
| `notification` | `services/notification/` | Node/Express | 4004 |

### Frontend
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `web` | `frontends/web/` | Next.js | 3000 |

## Quick Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start all services + deps |
| `cd services/project && npm run dev` | Start single backend |
| `cd frontends/web && npm run dev` | Start frontend |
| `npm test --workspace=services/project` | Test single service |

## Shared Conventions

- API specs: See `docs/api/`
- Shared packages: See `packages/shared/`
- Env config: `.env.example` per service
- DB migrations: See `<service>/prisma/`
- New service setup: See `docs/service-template.md`

## Cross-Service Patterns

- Sync: REST with shared types from `packages/shared`
- Async: Redis pub/sub -- See `docs/events.md`
- Auth: JWT with httpOnly cookies -- See `docs/auth-flow.md`
- Observability: Pino structured logging -- See `docs/observability.md`

## Gotchas

- Monorepo uses npm workspaces -- always run `npm install` from root
- `packages/shared` must be built before services: `npm run build -w packages/shared`
- Redis 7+ required for pub/sub streams

Each service has its own `CLAUDE.md` -- auto-loaded when working in that directory.
