# Admin Dashboard

Internal admin panel for order management, user administration, and analytics.

## Commands

| Command | Description |
|---------|-------------|
| `npm run dev` | Dev server with HMR |
| `npm run build` | Production build |
| `npm run test:unit` | Vitest unit tests |
| `npm run lint` | ESLint + Prettier |

## Architecture

```
src/
  views/        # Page components (route-level)
  components/   # Reusable UI components
  composables/  # Vue composables (shared logic)
  stores/       # Pinia stores
  api/          # API client modules
  router/       # Vue Router config
  assets/       # Static assets, CSS
```

## Key Files

- `src/main.js` -- App entry, plugin registration
- `src/router/index.js` -- Route definitions with auth guards
- `vite.config.js` -- Dev proxy to backend APIs

## API Dependencies

| Backend Service | Base Path | Purpose |
|----------------|-----------|---------|
| `auth` | `/api/auth` | Login, token refresh |
| `order` | `/api/orders` | Order CRUD, status management |
| `user` | `/api/users` | User listing, role management |
| `inventory` | `/api/inventory` | Stock level monitoring |

## Env Vars

See `.env.example` -- key var: `VITE_API_BASE_URL`

## Gotchas

- Auth token refresh is handled by Axios interceptor in `src/api/client.js`
- Route guards redirect to `/login` on 401 -- do not remove or orders page breaks
