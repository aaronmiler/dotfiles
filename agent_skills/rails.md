---
name: rails
description: Ruby on Rails conventions — REST, service objects, thin controllers, Sidekiq, strong migrations, and running rails commands via docker compose exec. Load when working in a Rails codebase.
---

# Rails Conventions

## General
- Follow Rails conventions: REST, concerns, service objects for complexity
- Prefer `rails g` generators, then modify
- Keep controllers thin; push logic to models or services
- When writing services, look at the base class ApplicationService
- Prefer Sidekiq for async processing
- Consider N+1 queries; use `includes`/`preload`

## Docker
- All rails commands must be run inside docker containers using `docker compose exec`

## Database
- Always generate migrations for schema changes
- Use strong migrations practices — avoid dangerous migrations on large tables
- Prefer `find_each` over `each` for large record sets
