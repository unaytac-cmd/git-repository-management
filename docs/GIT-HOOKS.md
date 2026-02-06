# Git Hooks Configuration

This document describes the Git hooks configuration for code quality enforcement in this repository.

## Overview

This repository uses [Husky](https://typicode.github.io/husky/) to manage Git hooks that automatically enforce code quality standards. The hooks run automatically during git operations to ensure code consistency and quality.

## Prerequisites

- **Node.js**: 16+ (required for Husky and ESLint)
- **npm**: 8+ (comes with Node.js)
- **Python**: 3.8+ (optional, for Python linting)
- **Git**: 2.0+

## Installation

### Quick Setup

Run the setup script to install all dependencies and configure hooks:

```bash
./scripts/setup-hooks.sh
```

### Manual Setup

If you prefer to set up manually:

1. **Install Node.js dependencies:**
   ```bash
   npm install
   ```

2. **Install Husky hooks:**
   ```bash
   npm run prepare
   ```

3. **Make hook scripts executable:**
   ```bash
   chmod +x .husky/pre-commit
   chmod +x .husky/commit-msg
   chmod +x .husky/pre-push
   ```

4. **Install Python dependencies (optional):**
   ```bash
   pip install -r requirements-dev.txt
   ```

## Configured Hooks

### 1. Pre-Commit Hook

**Purpose**: Ensures code quality before committing changes.

**What it does:**
- Runs ESLint on staged JavaScript/TypeScript files
- Runs Black formatter check on staged Python files
- Automatically fixes auto-fixable issues
- Prevents commit if linting fails

**Triggered by**: `git commit`

**Files affected**: Only staged files (`.js`, `.jsx`, `.ts`, `.tsx`, `.py`)

**Example output:**
```
🔍 Running pre-commit checks...
📝 Running linters on staged files...
🐍 Checking Python files with Black...
✅ Pre-commit checks passed!
```

**Configuration files:**
- `.eslintrc.js` - ESLint configuration
- `pyproject.toml` - Black configuration
- `package.json` - lint-staged configuration

### 2. Commit Message Hook

**Purpose**: Validates commit messages follow conventional commit format.

**What it does:**
- Validates commit message structure
- Ensures proper type and format
- Provides helpful error messages
- Enforces conventional commits standard

**Triggered by**: `git commit`

**Required format:**
```
type(scope): subject

body (optional)

footer (optional)
```

**Valid types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting, etc.)
- `refactor` - Code refactoring
- `perf` - Performance improvements
- `test` - Adding or updating tests
- `chore` - Build/tooling changes
- `ci` - CI/CD configuration changes
- `infra` - Infrastructure changes
- `revert` - Revert a previous commit

**Examples:**

✅ Valid commit messages:
```
feat(auth): add JWT token validation
fix(api): resolve timeout issue in user endpoint
docs: update README with installation instructions
chore(deps): update dependencies to latest versions
```

❌ Invalid commit messages:
```
Add new feature                    # Missing type
feat: Add new feature             # Missing subject after type
FEAT(auth): add feature           # Type must be lowercase
feat(auth) add feature            # Missing colon after type
```

**Example output:**
```
🔍 Validating commit message format...
✅ Commit message format is valid
```

**Configuration file:**
- `commitlint.config.js` - Commitlint configuration

### 3. Pre-Push Hook

**Purpose**: Ensures all tests pass before pushing code.

**What it does:**
- Runs Jest test suite for JavaScript/TypeScript
- Runs pytest test suite for Python (if available)
- Prevents push if tests fail
- Provides detailed test results

**Triggered by**: `git push`

**Example output:**
```
🧪 Running test suite before push...
📦 Running JavaScript tests...
✅ JavaScript tests passed
🐍 Running Python tests...
✅ Python tests passed
✅ All tests passed! Pushing to remote...
```

**Configuration files:**
- `jest.config.js` - Jest configuration
- `pyproject.toml` - pytest configuration

## Bypassing Hooks

⚠️ **Use sparingly and only when necessary!**

### Skip all hooks:
```bash
git commit --no-verify -m "feat: emergency fix"
git push --no-verify
```

### Skip specific hooks:
```bash
# Skip hooks for one commit
HUSKY=0 git commit -m "feat: bypass hooks"

# Disable hooks temporarily
export HUSKY=0
git commit -m "feat: first commit"
git commit -m "fix: second commit"
unset HUSKY
```

## Troubleshooting

### Hook not running?

1. **Check if hooks are installed:**
   ```bash
   ls -la .husky/
   ```

2. **Reinstall hooks:**
   ```bash
   npm run prepare
   ```

3. **Check hook permissions:**
   ```bash
   chmod +x .husky/*
   ```

### ESLint errors?

1. **Check ESLint configuration:**
   ```bash
   npx eslint --print-config .eslintrc.js
   ```

2. **Run linter manually:**
   ```bash
   npm run lint:js
   ```

3. **Auto-fix issues:**
   ```bash
   npx eslint --fix --ext .js,.jsx,.ts,.tsx .
   ```

### Black formatting errors?

1. **Check if Black is installed:**
   ```bash
   black --version
   ```

2. **Run Black manually:**
   ```bash
   npm run lint:py
   ```

3. **Auto-format Python files:**
   ```bash
   black .
   ```

### Commit message validation fails?

1. **Test commit message format:**
   ```bash
   echo "feat(test): test message" | npx commitlint
   ```

2. **Use the validation script:**
   ```bash
   echo "feat: test" > /tmp/test-msg
   ./scripts/validate-commit-msg.sh /tmp/test-msg
   ```

### Tests failing on pre-push?

1. **Run tests manually:**
   ```bash
   npm run test
   ```

2. **Check test configuration:**
   ```bash
   cat jest.config.js
   cat pyproject.toml
   ```

3. **Debug specific test:**
   ```bash
   npm run test:js -- --verbose
   pytest -v
   ```

## Customization

### Modify Pre-Commit Behavior

Edit `.husky/pre-commit`:
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Add your custom checks here
```

### Modify Commit Message Rules

Edit `commitlint.config.js`:
```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Add or modify rules here
    'header-max-length': [2, 'always', 100],
  },
};
```

### Modify Test Behavior

Edit `.husky/pre-push`:
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Customize test execution
```

### Add Additional Linters

Edit `package.json`:
```json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix"],
    "*.py": ["black"],
    "*.css": ["prettier --write"]
  }
}
```

## CI/CD Integration

These hooks run locally, but you should also run the same checks in CI/CD:

```yaml
# Example GitHub Actions workflow
- name: Lint code
  run: npm run lint

- name: Run tests
  run: npm test

- name: Validate commit messages
  run: npx commitlint --from=origin/main
```

## Best Practices

1. **Never commit with --no-verify** unless absolutely necessary
2. **Keep hooks fast** - they run on every commit/push
3. **Run hooks locally** before pushing to catch issues early
4. **Update dependencies regularly** to get latest fixes
5. **Document custom rules** in this file when adding new checks
6. **Test hooks** after making changes

## Performance Tips

- **Use lint-staged**: Only lint changed files (already configured)
- **Cache dependencies**: Leverage npm/pip caching
- **Parallel execution**: Run independent checks in parallel
- **Skip unnecessary checks**: Use `.eslintignore` and Black excludes

## Resources

- [Husky Documentation](https://typicode.github.io/husky/)
- [Commitlint Documentation](https://commitlint.js.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [ESLint Documentation](https://eslint.org/)
- [Black Documentation](https://black.readthedocs.io/)
- [Jest Documentation](https://jestjs.io/)
- [pytest Documentation](https://pytest.org/)

## Support

For issues or questions:
1. Check this documentation
2. Review hook output messages
3. Check individual tool documentation
4. Create an issue in the repository

---

**Last Updated**: 2024
**Maintained by**: DevOps Team
