# Project Service

Manages projects, boards, tasks, and team assignments.

## Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Dev server with hot reload |
| `npm test` | Run Jest tests |
| `npm run build` | TypeScript compilation |
| `npx prisma migrate dev` | Run DB migrations |

## Architecture

```
src/
  routes/        # Express route handlers
  controllers/   # Request/response logic
  services/      # Business logic
  models/        # Prisma client + types
  middleware/    # Auth, validation, error handling
  config/        # App configuration
  utils/         # Shared utilities
  events/        # Redis pub/sub publishers
```

## Key Files

- `src/index.ts` -- Express app entry point
- `prisma/schema.prisma` -- Database schema
- `src/middleware/auth.ts` -- JWT verification middleware

## Dependencies

| Service | Protocol | Purpose |
|---------|----------|---------|
| `auth` | REST | Token validation |
| `notification` | Redis pub/sub | Task assignment alerts |
| `user` | REST | Team member lookup |

## API & DB

- API contract: See `docs/api/project.yaml`
- DB: PostgreSQL -- See `prisma/schema.prisma`
- Key models: `Project`, `Board`, `Task`, `TaskAssignment`

## Env Vars

See `.env.example` -- key vars: `DATABASE_URL`, `PORT`, `REDIS_URL`, `JWT_SECRET`

## Gotchas

- Prisma client must be regenerated after schema changes: `npx prisma generate`
- Soft-delete pattern: all queries must filter `deletedAt IS NULL`
