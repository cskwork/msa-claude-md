# DataLens Dashboard

Real-time analytics dashboard with interactive charts and data exploration.

## Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Next.js dev server |
| `npm run build` | Production build |
| `npm test` | Jest + React Testing Library |
| `npm run lint` | ESLint |

## Architecture

```
src/
  app/          # Next.js App Router pages
  components/   # UI components + chart widgets
  hooks/        # Custom hooks (useQuery, useWebSocket)
  lib/          # API client, chart configs
  stores/       # Zustand stores (filters, dashboard state)
  styles/       # Tailwind + chart theme
```

## Key Files

- `src/app/layout.tsx` -- Root layout with auth provider
- `next.config.js` -- API rewrites to backend services
- `src/lib/charts.ts` -- Recharts/D3 configuration factory

## API Dependencies

| Backend Service | Base Path | Purpose |
|----------------|-----------|---------|
| `auth` | `/api/auth` | OAuth2 login flow |
| `query` | `/api/query` | Analytics data fetching |
| `user` | `/api/users` | Dashboard sharing, permissions |

## Env Vars

See `.env.example` -- key var: `NEXT_PUBLIC_API_URL`, `NEXT_PUBLIC_WS_URL`

## Gotchas

- Chart components are `'use client'` only -- cannot be Server Components
- WebSocket reconnection is handled by `src/hooks/useWebSocket.ts` -- do not create new connections manually
