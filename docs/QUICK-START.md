# Quick Start Guide

Get up and running with Git hooks in under 5 minutes!

## 🚀 Installation

### One-Command Setup

```bash
./scripts/setup-hooks.sh
```

That's it! The script will:
- ✅ Install all Node.js dependencies
- ✅ Configure Husky Git hooks
- ✅ Set up linters and formatters
- ✅ Make all scripts executable

### Manual Installation (if needed)

```bash
npm install
npm run prepare
pip install -r requirements-dev.txt  # Optional: for Python support
```

## 📝 Your First Commit

Try making a commit to see the hooks in action:

```bash
# Create an empty commit for testing
git commit --allow-empty -m "test: verify git hooks are working"
```

You'll see:
```
🔍 Running pre-commit checks...
✅ Pre-commit checks passed!
🔍 Validating commit message format...
✅ Commit message format is valid
```

## ✍️ Commit Message Format

Use this format for all commits:

```
type(scope): description

Examples:
  feat(auth): add login functionality
  fix(api): resolve timeout issue
  docs: update README
  chore(deps): update dependencies
```

### Valid Types
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Code restructuring
- `test` - Tests
- `chore` - Maintenance
- `ci` - CI/CD changes
- `infra` - Infrastructure
- `perf` - Performance
- `revert` - Revert commit

## 🧪 Running Tests

Tests run automatically before push, but you can run them manually:

```bash
npm test                # All tests
npm run test:js         # JavaScript only
npm run test:py         # Python only
```

## 🎨 Running Linters

Linters run automatically before commit, but you can run them manually:

```bash
npm run lint            # All linters
npm run lint:js         # ESLint
npm run lint:py         # Black

# Auto-fix issues
npx eslint --fix --ext .js,.jsx,.ts,.tsx .
black .
```

## 🔄 Typical Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/my-feature
   ```

2. **Make your changes**
   ```bash
   vim src/file.js
   ```

3. **Stage changes**
   ```bash
   git add src/file.js
   ```

4. **Commit** (hooks run automatically)
   ```bash
   git commit -m "feat(feature): add new functionality"
   ```
   
   - ✅ Pre-commit hook runs linters
   - ✅ Commit-msg hook validates format

5. **Push** (tests run automatically)
   ```bash
   git push origin feature/my-feature
   ```
   
   - ✅ Pre-push hook runs tests

## ⚠️ Bypass Hooks (Emergency Only)

If you absolutely must skip hooks:

```bash
git commit --no-verify -m "fix: emergency fix"
git push --no-verify
```

**Warning:** Only use in emergencies! Hooks exist to maintain code quality.

## 🐛 Troubleshooting

### Hooks not running?
```bash
npm run prepare
chmod +x .husky/*
```

### Linting errors?
```bash
npm run lint
npx eslint --fix --ext .js,.jsx,.ts,.tsx .
black .
```

### Commit message rejected?
Make sure it follows the format: `type(scope): description`

### Tests failing?
```bash
npm test -- --verbose
```

## 📚 Learn More

- **Full Documentation:** [docs/GIT-HOOKS.md](GIT-HOOKS.md)
- **Main README:** [README.md](../README.md)
- **Conventional Commits:** https://www.conventionalcommits.org/

## 🆘 Need Help?

1. Check the error message - hooks provide helpful feedback
2. Review [docs/GIT-HOOKS.md](GIT-HOOKS.md) for detailed troubleshooting
3. Run commands manually to debug: `npm run lint`, `npm test`
4. Ask the team or create an issue

---

**Remember:** Hooks are your friends! They catch issues before they reach production. 🎉
