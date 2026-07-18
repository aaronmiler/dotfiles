---
name: frontend
description: TypeScript + React conventions — functional components/hooks, frontend/ layout, in-component code order, prop interfaces, export style. Load when working in React/TypeScript frontend code.
---

# TypeScript + React Conventions

## Structure
- Functional components + hooks only
- Front end lives in frontend/
  - Shared components in frontend/components
  - Views in frontend/views
  - Prefer views/.../ViewName/ViewName.tsx to index.tsx
- Colocate tests with components

## Component Organization
Order code within components:
1. Static/const data (or extract outside component if pure)
2. State (`useState`, `useReducer`)
3. Derived state / memos
4. Custom hook calls
5. Effects (group by concern; comment groups if >2 effects)
6. Handler functions (named, not inline lambdas for >1 line)
7. Return/JSX

## State & Hooks
- Extract custom hooks when a component exceeds ~5 `useState` calls
- Group related state into a single hook (e.g., `useDateFilter`, `useTeamMembers`)

## Exports
- Use `export default ComponentName` at bottom of file
- Named exports only for co-located types/utilities

## TypeScript
- Prefer interfaces for component props, named IComponentName
- Declare components as: `const ComponentName = ({prop, prop2}: IComponentName) => ...`
