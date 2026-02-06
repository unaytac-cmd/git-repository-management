# Git Repository Management

A structured Git repository with proper configuration for multi-language development and deployment pipelines.

## Project Structure

```
.
├── .editorconfig          # Editor configuration for consistent code formatting
├── .gitignore            # Git ignore file for Node.js, Python, and environment files
├── README.md             # This file - project documentation
└── docs/                 # Documentation directory (to be created)
    └── SETUP.md          # Setup and installation instructions
```

## Overview

This repository provides a solid foundation for multi-language development projects, including:

- **Node.js** projects (npm, yarn, Next.js, etc.)
- **Python** projects (pip, virtualenv, pytest, etc.)
- **Docker** and containerization support
- **CI/CD** pipeline ready structure
- **Environment management** for dev, staging, and production

## Getting Started

### Prerequisites

- Git 2.0 or higher
- Node.js 16+ (for Node.js projects)
- Python 3.8+ (for Python projects)
- Docker & Docker Compose (for containerized development)

### Initial Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Configure Git**
   ```bash
   git config user.name "Your Name"
   git config user.email "your.email@example.com"
   ```

3. **Verify EditorConfig Support**
   - Install EditorConfig plugin for your IDE:
     - VS Code: EditorConfig for VS Code
     - JetBrains: Built-in support
     - Sublime Text: EditorConfig plugin
     - Vim: editorconfig-vim

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

We follow Conventional Commits:

```
type(scope): subject

body

footer
```

Types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, semicolons, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Build process, dependencies, or tooling changes
- `ci`: CI/CD configuration changes
- `infra`: Infrastructure changes

Example:
```
feat(auth): add JWT token validation

- Implement JWT token validation middleware
- Add token refresh mechanism
- Update authentication guard

Closes #123
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

## Editor Configuration (.editorconfig)

The `.editorconfig` file ensures consistent code formatting across different editors:

- **Line endings:** Unix-style (LF)
- **Character set:** UTF-8
- **Indentation:**
  - JavaScript/TypeScript: 2 spaces
  - Python: 4 spaces
  - Makefiles: Tabs
  - Shell scripts: 2 spaces
- **Trailing whitespace:** Removed (except Markdown)

## Contributing

1. Create a feature branch from `develop`
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit with conventional messages
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

3. Push your branch
   ```bash
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request with a detailed description

## Best Practices

### Git Hygiene
- Commit frequently with meaningful messages
- Keep commits atomic (one logical change per commit)
- Use `.gitignore` to avoid committing sensitive files
- Review changes before committing (`git diff`)

### Code Quality
- Follow the conventions in `.editorconfig`
- Use consistent code formatting
- Run linters and formatters before committing
- Write meaningful commit messages

### Environment Management
- Never commit `.env` files with secrets
- Use `.env.example` templates for required variables
- Store sensitive data in secure vaults (GitHub Secrets, AWS Secrets Manager, etc.)

## Documentation

For detailed setup instructions and project-specific documentation, see:
- `docs/SETUP.md` - Detailed setup guide

## Troubleshooting

### EditorConfig not working?
- Ensure your IDE has EditorConfig support/plugin installed
- Verify `.editorconfig` is in the repository root
- Some IDEs require a reload after plugin installation

### Git ignoring too much?
- Check if files match patterns in `.gitignore`
- Use `git status --ignored` to see ignored files
- Use `git add -f <file>` to force add ignored files

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [EditorConfig](https://editorconfig.org/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

## License

[Add your license information here]

## Support

For issues or questions:
1. Check existing documentation
2. Create an issue in the repository
3. Contact the development team

---

**Last Updated:** 2024
**Repository Version:** 1.0.0
