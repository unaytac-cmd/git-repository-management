# Git Repository Management

A structured Git repository with proper configuration for multi-language development and deployment pipelines.

## Project Structure

```
.
├── .editorconfig          # Editor configuration for consistent code formatting
├── .eslintrc.js          # ESLint configuration for JavaScript/TypeScript
├── .gitignore            # Git ignore file for Node.js, Python, and environment files
├── .husky/               # Git hooks managed by Husky
│   ├── pre-commit        # Runs linters before commit
│   ├── commit-msg        # Validates commit message format
│   └── pre-push          # Runs tests before push
├── commitlint.config.js  # Commit message validation rules
├── jest.config.js        # Jest test configuration
├── package.json          # Node.js dependencies and scripts
├── pyproject.toml        # Python tooling configuration (Black, pytest)
├── requirements-dev.txt  # Python development dependencies
├── scripts/              # Utility scripts
│   ├── setup-hooks.sh    # Automated Git hooks setup
│   └── validate-commit-msg.sh  # Standalone commit message validator
├── docs/                 # Documentation directory
│   └── GIT-HOOKS.md      # Comprehensive Git hooks documentation
└── README.md             # This file - project documentation
```

## Overview

This repository provides a solid foundation for multi-language development projects, including:

- **Automated code quality enforcement** via Git hooks (Husky)
- **Conventional commits** validation for consistent commit messages
- **Node.js** projects (npm, ESLint, Jest)
- **Python** projects (Black, pytest, flake8)
- **Docker** and containerization support
- **CI/CD** pipeline ready structure
- **Environment management** for dev, staging, and production

## Getting Started

### Prerequisites

- **Git** 2.0 or higher
- **Node.js** 16+ (required for Git hooks and linting)
- **npm** 8+ (comes with Node.js)
- **Python** 3.8+ (optional, for Python projects)
- **Docker & Docker Compose** (optional, for containerized development)

### Quick Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Run the setup script**
   ```bash
   chmod +x scripts/setup-hooks.sh
   ./scripts/setup-hooks.sh
   ```

   This will:
   - Install Node.js dependencies
   - Configure Husky Git hooks
   - Set up linters and formatters
   - Make all scripts executable

3. **Optional: Install Python dependencies**
   ```bash
   pip install -r requirements-dev.txt
   ```

### Manual Setup

If you prefer manual setup:

1. **Install Node.js dependencies**
   ```bash
   npm install
   ```

2. **Install Git hooks**
   ```bash
   npm run prepare
   ```

3. **Make hook scripts executable**
   ```bash
   chmod +x .husky/pre-commit .husky/commit-msg .husky/pre-push
   ```

4. **Configure Git**
   ```bash
   git config user.name "Your Name"
   git config user.email "your.email@example.com"
   ```

## Git Hooks Configuration

This repository uses **Husky** to enforce code quality through automated Git hooks:

### 🪝 Pre-Commit Hook
- Runs **ESLint** on staged JavaScript/TypeScript files
- Runs **Black** formatter check on staged Python files
- Automatically fixes auto-fixable issues
- Prevents commit if linting fails

### 📝 Commit Message Hook
- Validates commit messages follow **Conventional Commits** format
- Ensures proper type, scope, and subject format
- Provides helpful error messages on validation failure

### 🧪 Pre-Push Hook
- Runs **Jest** test suite for JavaScript/TypeScript
- Runs **pytest** test suite for Python (if available)
- Prevents push if tests fail

### Example Workflow

```bash
# Make changes to your code
vim src/app.js

# Stage changes
git add src/app.js

# Commit (hooks run automatically)
git commit -m "feat(api): add user authentication endpoint"

# Output:
# 🔍 Running pre-commit checks...
# 📝 Running linters on staged files...
# ✅ Pre-commit checks passed!
# 🔍 Validating commit message format...
# ✅ Commit message format is valid

# Push changes (tests run automatically)
git push origin feature/auth

# Output:
# 🧪 Running test suite before push...
# 📦 Running JavaScript tests...
# ✅ JavaScript tests passed
# ✅ All tests passed! Pushing to remote...
```

For detailed information about Git hooks, see **[docs/GIT-HOOKS.md](docs/GIT-HOOKS.md)**.

## Development Workflow

### Branch Strategy

We follow a Git Flow strategy:
- `main` - Production-ready code
- `develop` - Development branch
- `feature/*` - Feature branches
- `bugfix/*` - Bug fix branches
- `release/*` - Release branches
- `hotfix/*` - Hot fix branches

### Commit Message Convention

We follow **[Conventional Commits](https://www.conventionalcommits.org/)** standard:

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
- `chore` - Build process, dependencies, or tooling changes
- `ci` - CI/CD configuration changes
- `infra` - Infrastructure changes
- `revert` - Revert a previous commit

**Examples:**

✅ Valid:
```
feat(auth): add JWT token validation
fix(api): resolve timeout issue in user endpoint
docs: update README with installation instructions
chore(deps): update dependencies to latest versions
```

❌ Invalid:
```
Add new feature                    # Missing type
feat: Add new feature             # Capital letter in subject
FEAT(auth): add feature           # Type must be lowercase
feat(auth) add feature            # Missing colon
```

## Available Scripts

### Node.js Scripts

```bash
# Install dependencies and setup hooks
npm install
npm run prepare

# Linting
npm run lint          # Run all linters
npm run lint:js       # Run ESLint only
npm run lint:py       # Run Black check only

# Testing
npm test              # Run all tests
npm run test:js       # Run Jest tests
npm run test:py       # Run pytest tests
```

### Utility Scripts

```bash
# Setup Git hooks (automated)
./scripts/setup-hooks.sh

# Validate commit message format
./scripts/validate-commit-msg.sh <message-file>
```

## File Ignoring Rules

### .gitignore Coverage

**Node.js:**
- `node_modules/`, `package-lock.json`, `yarn.lock`
- Build outputs: `dist/`, `build/`, `.next/`
- Logs and caches: `npm-debug.log`, `.eslintcache`

**Python:**
- Virtual environments: `venv/`, `env/`, `.venv`
- Cache: `__pycache__/`, `*.pyc`, `.pytest_cache/`
- Distribution: `*.egg-info/`, `dist/`, `build/`

**Environment:**
- `.env`, `.env.local`, `.env.*.local`
- `.env.production`, `.env.development`, `.env.test`

**IDE/Editor:**
- `.vscode/`, `.idea/`, `*.swp`, `*.swo`, `*.iml`

**OS:**
- `.DS_Store`, `Thumbs.db`, system files

**Docker:**
- `.docker/`, `docker-compose.override.yml`

## Editor Configuration

The `.editorconfig` file ensures consistent code formatting across different editors:

- **Line endings:** Unix-style (LF)
- **Character set:** UTF-8
- **Indentation:**
  - JavaScript/TypeScript: 2 spaces
  - Python: 4 spaces
  - Makefiles: Tabs
  - Shell scripts: 2 spaces
- **Trailing whitespace:** Removed (except Markdown)

### IDE Setup

Install EditorConfig plugin for your IDE:
- **VS Code:** EditorConfig for VS Code
- **JetBrains:** Built-in support
- **Sublime Text:** EditorConfig plugin
- **Vim:** editorconfig-vim

## Contributing

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes and commit** (hooks will run automatically)
   ```bash
   git add .
   git commit -m "feat(scope): add your feature description"
   ```

3. **Push your branch** (tests will run automatically)
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request** with a detailed description

## Best Practices

### Git Hygiene
- ✅ Commit frequently with meaningful messages
- ✅ Keep commits atomic (one logical change per commit)
- ✅ Use `.gitignore` to avoid committing sensitive files
- ✅ Review changes before committing (`git diff`)
- ✅ Let hooks run - they catch issues early
- ⚠️ Avoid `--no-verify` unless absolutely necessary

### Code Quality
- ✅ Follow conventions in `.editorconfig`
- ✅ Use consistent code formatting
- ✅ Fix linting issues before committing
- ✅ Write meaningful commit messages
- ✅ Run tests locally before pushing
- ✅ Keep test coverage high

### Environment Management
- ❌ Never commit `.env` files with secrets
- ✅ Use `.env.example` templates for required variables
- ✅ Store sensitive data in secure vaults
- ✅ Document required environment variables

## Bypassing Hooks

⚠️ **Use sparingly and only when necessary!**

```bash
# Skip all hooks for one commit
git commit --no-verify -m "feat: emergency fix"

# Skip pre-push hook
git push --no-verify

# Disable hooks temporarily
export HUSKY=0
git commit -m "feat: bypass hooks"
unset HUSKY
```

## Troubleshooting

### Hooks not running?
```bash
# Reinstall hooks
npm run prepare

# Check hook permissions
chmod +x .husky/*
```

### Linting errors?
```bash
# Run linters manually
npm run lint

# Auto-fix issues
npx eslint --fix --ext .js,.jsx,.ts,.tsx .
black .
```

### Commit message validation fails?
```bash
# Test your message format
echo "feat(test): test message" | npx commitlint
```

### Tests failing?
```bash
# Run tests manually
npm test

# Run with verbose output
npm run test:js -- --verbose
pytest -v
```

For more troubleshooting help, see **[docs/GIT-HOOKS.md](docs/GIT-HOOKS.md)**.

## Documentation

- **[docs/GIT-HOOKS.md](docs/GIT-HOOKS.md)** - Comprehensive Git hooks documentation
- **[Conventional Commits](https://www.conventionalcommits.org/)** - Commit message standard
- **[Husky](https://typicode.github.io/husky/)** - Git hooks manager
- **[ESLint](https://eslint.org/)** - JavaScript linter
- **[Black](https://black.readthedocs.io/)** - Python formatter
- **[Jest](https://jestjs.io/)** - JavaScript testing framework
- **[pytest](https://pytest.org/)** - Python testing framework

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [EditorConfig](https://editorconfig.org/)

## License

[Add your license information here]

## Support

For issues or questions:
1. Check existing documentation (especially **docs/GIT-HOOKS.md**)
2. Review hook output messages
3. Create an issue in the repository
4. Contact the development team

---

**Last Updated:** 2024  
**Repository Version:** 2.0.0  
**Maintainer:** DevOps Team
