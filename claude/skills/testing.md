# Testing Conventions

## General
- Write tests for new functionality
- Test behavior, not implementation
- Prefer integration tests for critical paths

## Execution
- Assume tests are auto-run by user in another process
- Verify test success via logs/output; don't try to run them yourself

## Rails
- RSpec + FactoryBot preferred
- Follow existing spec patterns in the project

## Frontend
- Colocate test files with components
- Test user-facing behavior, not internal state
