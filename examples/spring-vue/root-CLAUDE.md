# ShopFlow - E-Commerce Platform

Multi-service e-commerce platform with Spring Boot backend and Vue.js admin/storefront.

## Service Domains

### Core
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `auth` | `services/auth/` | Java/Spring | 8081 |
| `user` | `services/user/` | Java/Spring | 8082 |

### Business
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `order` | `services/order/` | Java/Spring | 8083 |
| `payment` | `services/payment/` | Java/Spring | 8084 |
| `inventory` | `services/inventory/` | Java/Spring | 8085 |

### Frontend
| Service | Path | Stack | Port |
|---------|------|-------|------|
| `admin` | `frontends/admin/` | Vue.js | 3000 |
| `storefront` | `frontends/storefront/` | Vue.js | 3001 |

Full service catalog: See `docs/services.md`

## Quick Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start all services |
| `./gradlew :services:order:bootRun` | Start single backend |
| `cd frontends/admin && npm run dev` | Start admin frontend |
| `./gradlew test` | Run all backend tests |

## Shared Conventions

- API specs: See `docs/api/`
- Shared libs: See `libs/common/`
- Env config: `.env.example` per service
- DB migrations: See `<service>/src/main/resources/db/migration/`
- New service setup: See `docs/service-template.md`

## Cross-Service Patterns

- Sync: REST between services -- See `docs/api-contracts.md`
- Async: Kafka events -- See `docs/events.md`
- Auth: JWT with refresh tokens -- See `docs/auth-flow.md`
- Observability: Prometheus + Grafana -- See `docs/observability.md`

## Gotchas

- `auth` must start before all other services (JWT key initialization)
- `KAFKA_BOOTSTRAP_SERVERS` must be identical across all services
- MySQL 8.0+ required -- older versions cause migration failures

Each service has its own `CLAUDE.md` -- auto-loaded when working in that directory.
