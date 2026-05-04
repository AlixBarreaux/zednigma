# Contributing

## File naming

- Files: `snake_case.gd`
- Classes: `PascalCase`
- Directories: `kebab-case`

## Commit prefixes

- `build:` Build system, export config
- `ci:` CI/CD related
- `docs:` Documentation
- `feat:` New gameplay feature
- `fix:` Bug fix
- `perf:` Performance improvement
- `refactor:` Code restructure, no behavior change
- `revert:` Reverts a previous commit
- `style:` Formatting, no logic change
- `test:` Adding or fixing tests
- `tweak:` Value adjustments, minor balance changes

## Branch strategy

- `main` → stable only, merge via PR
- One feature = one branch = one PR
- Branch naming: `feat/player-movement`, `fix/zombie-pathfinding`

## Pull requests

- Describe what changed and why
- All tests must pass before merge
