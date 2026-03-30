# Order Service

Manages order lifecycle: creation, status transitions, fulfillment tracking.

## Commands

| Command | Description |
|---------|-------------|
| `./gradlew :services:order:bootRun` | Run locally |
| `./gradlew :services:order:test` | Unit + integration tests |
| `./gradlew :services:order:build` | Build JAR |

## Architecture

```
src/main/java/com/shopflow/order/
  controller/    # REST endpoints
  service/       # Business logic
  repository/    # JPA repositories
  domain/        # Entities & value objects
  dto/           # Request/Response DTOs
  config/        # Spring config & beans
  event/         # Kafka producers/consumers
src/main/resources/
  application.yml
  db/migration/  # Flyway migrations
```

## Key Files

- `OrderApplication.java` -- Spring Boot entry point
- `application.yml` -- profiles, datasource, Kafka config
- `OrderStateMachine.java` -- Order status transition logic

## Dependencies

| Service | Protocol | Purpose |
|---------|----------|---------|
| `auth` | REST | JWT token validation |
| `payment` | REST | Payment initiation |
| `inventory` | Kafka | Stock reservation events |

## API & DB

- API contract: See `docs/api/order.yaml`
- DB: MySQL (`order_db`) -- See `db/migration/`
- Key tables: `orders`, `order_items`, `order_status_history`

## Env Vars

See `.env.example` -- key vars: `SPRING_DATASOURCE_URL`, `SERVER_PORT`, `KAFKA_BOOTSTRAP_SERVERS`

## Gotchas

- Order status transitions are enforced by `OrderStateMachine` -- bypassing causes data inconsistency
- Kafka consumer group ID must be unique per environment
