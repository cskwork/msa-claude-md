# msa-claude-md

**Generate minimal, context-optimized CLAUDE.md files for microservice architectures.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Skill-7C3AED)](https://docs.anthropic.com/en/docs/claude-code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/cskwork/msa-claude-md/pulls)

---

## The Problem

MSA projects with 10+ services create a **context explosion** for Claude Code.

A naive CLAUDE.md dumps everything into memory at startup -- architecture docs, API specs, env configs -- burning thousands of tokens before any real work begins. And a single monolithic file means backend services load frontend guides they'll never use.

```
# Typical MSA CLAUDE.md -- 500+ lines, everything inlined
# Result: 8,000+ tokens consumed at startup, every single time
```

## The Solution

This skill generates a **< 100 line root CLAUDE.md** as a pure navigation hub, plus **self-contained per-service CLAUDE.md** files that auto-load only when you `cd` into that service directory.

The key mechanism: **`See` references instead of `@` imports**.

```
@docs/api-guide.md       # Loaded at startup -- costs tokens immediately
See docs/api-guide.md    # Claude reads on-demand -- zero cost until needed
```

### Before vs After

| | Before | After |
|---|--------|-------|
| **Root CLAUDE.md** | 500+ lines, everything inlined | < 100 lines, navigation hub |
| **Startup context cost** | Full file loaded every time | Zero until accessed |
| **Service isolation** | All services in one file | Each service self-contained |
| **Reference style** | `@docs/guide.md` (eager load) | `See docs/guide.md` (lazy load) |
| **Stack support** | Manual, inconsistent | Auto-detected, templated |
| **New service setup** | Copy-paste and hope | Checklist + template |

## Install

```bash
git clone https://github.com/cskwork/msa-claude-md.git ~/.claude/skills/msa-claude-md
```

Or copy manually:

```bash
cp -r msa-claude-md ~/.claude/skills/msa-claude-md
```

## Usage

In Claude Code, invoke the skill:

```
/msa-claude-md
```

Or describe your intent:

```
Generate CLAUDE.md files for this MSA project
Set up context-optimized CLAUDE.md for our microservices
Audit and fix CLAUDE.md for this monorepo
```

## Supported Stacks

The skill auto-detects your tech stack from build files and package manifests.

### Backend

| Stack | Detection | Template |
|-------|-----------|----------|
| Java / Spring Boot | `pom.xml`, `build.gradle` + Spring deps | Gradle/Maven commands, JPA structure |
| Node.js / Express | `package.json` + express/nestjs/fastify | npm scripts, route/controller structure |
| Python / FastAPI | `pyproject.toml` / `requirements.txt` + fastapi | uvicorn, alembic, pydantic structure |
| Go | `go.mod` | go run/test/build, cmd/internal structure |
| Rust | `Cargo.toml` | cargo commands, module structure |

### Frontend

| Stack | Detection | Template |
|-------|-----------|----------|
| Vue.js | `package.json` + vue | Vite, Pinia, composables |
| React / Next.js | `package.json` + react/next | App Router, hooks, Zustand |
| Svelte / SvelteKit | `package.json` + svelte/@sveltejs | SvelteKit routes, stores |
| Angular | `package.json` + angular | ng commands, module structure |
| Nuxt.js | `package.json` + nuxt | Nuxt modules, composables |

## How It Works

```
Phase 1  Discover     Scan project, detect stacks, map services
              |
Phase 2  Generate     Root CLAUDE.md (< 100 lines) + docs/services.md
              |
Phase 3  Per-Service  CLAUDE.md for each service (< 80 lines each)
              |
Phase 4  Validate     Line counts, reference targets, command accuracy
              |
Phase 5  Gap Check    Find missing docs, create stubs
```

## What Gets Generated

```
project-root/
  CLAUDE.md                        # < 100 lines -- navigation hub
  docs/
    services.md                    # Full service catalog (10+ services)
    service-template.md            # New service bootstrap checklist
  services/
    auth/CLAUDE.md                 # Self-contained, stack-specific
    user/CLAUDE.md
    order/CLAUDE.md
    payment/CLAUDE.md
  frontends/
    admin/CLAUDE.md                # Self-contained, stack-specific
    customer/CLAUDE.md
```

## Core Principles

| # | Principle | Why |
|---|-----------|-----|
| 1 | **Root = index, not encyclopedia** | Service registry + shared conventions only |
| 2 | **Per-service = autonomous** | Each CLAUDE.md works standalone |
| 3 | **`See` not `@`** | Zero startup context cost |
| 4 | **< 100 lines root** | Every line must justify its existence |
| 5 | **Context isolation** | Backend doesn't load frontend guides |

## Examples

See the [`examples/`](examples/) directory for complete output samples:

| Example | Backend | Frontend | Services |
|---------|---------|----------|----------|
| [spring-vue](examples/spring-vue/) | Java / Spring Boot | Vue.js | 7 services |
| [node-react](examples/node-react/) | Node.js / Express | React / Next.js | 5 services |
| [python-nextjs](examples/python-nextjs/) | Python / FastAPI | Next.js | 6 services |

Each example includes root CLAUDE.md + sample backend CLAUDE.md + sample frontend CLAUDE.md.

## Anti-Patterns This Skill Prevents

| Anti-Pattern | Why It's Bad | What We Do Instead |
|-------------|-------------|-------------------|
| Inline code examples | Wastes context on rarely-needed content | `See` pointer to actual file |
| `@` imports | Eager-loads entire file at startup | `See` for lazy loading |
| Duplicated info | Root and service files diverge | Single source of truth per fact |
| Generic advice | "Use meaningful names" wastes tokens | Only project-specific content |
| Monolithic CLAUDE.md | 500+ lines, no isolation | < 100 root + < 80 per service |

## Contributing

PRs welcome. To add a new stack template:

1. Add detection logic in Phase 1 (stack detection table)
2. Create per-service template in Phase 3
3. Add example output in `examples/`
4. Update the supported stacks table in this README

## License

[MIT](LICENSE)
