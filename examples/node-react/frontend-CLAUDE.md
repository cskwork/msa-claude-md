# TaskHub Web

Main web application for project and task management.

## Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Next.js dev server |
| `npm run build` | Production build |
| `npm test` | Jest + React Testing Library |
| `npm run lint` | ESLint + Prettier |

## Architecture

```
src/
  app/          # Next.js App Router pages
  components/   # Reusable UI components
  hooks/        # Custom React hooks
  lib/          # API client, auth helpers
  stores/       # Zustand state stores
  styles/       # Tailwind global styles
```

## Key Files

- `src/app/layout.tsx` -- Root layout with providers
- `next.config.js` -- API rewrites to backend services
- `src/lib/api.ts` -- Fetch wrapper with auth headers

## API Dependencies

| Backend Service | Base Path | Purpose |
|----------------|-----------|---------|
| `auth` | `/api/auth` | Login, register, token refresh |
| `project` | `/api/projects` | Project and task CRUD |
| `user` | `/api/users` | Profile, team members |
| `notification` | `/api/notifications` | Real-time alerts (SSE) |

## Env Vars

See `.env.example` -- key var: `NEXT_PUBLIC_API_URL`

## Gotchas

- Server Components cannot use Zustand stores -- client state must be in `'use client'` components
- API rewrites in `next.config.js` handle CORS -- do not add CORS headers manually
