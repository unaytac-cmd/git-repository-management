# Contributing to this Project

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, inclusive, and professional in all interactions.

## Getting Started

### Prerequisites
- Node.js 18.x or higher
- Python 3.9 or higher
- Git
- Docker (for containerized development)

### Setup Development Environment

```bash
# Clone the repository
git clone <repository-url>
cd <repository-name>

# Install dependencies
npm install
pip install -r requirements-dev.txt

# Install git hooks
npm run setup-hooks

# Verify setup
npm run verify-hooks
```

## Development Workflow

### Creating a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-number
```

Use these prefixes:
- `feature/` - New features
- `fix/` - Bug fixes
- `refactor/` - Code refactoring
- `docs/` - Documentation updates
- `test/` - Test additions or modifications
- `chore/` - Maintenance and dependency updates

### Making Changes

1. Make your changes in logical commits
2. Follow the project's code style (enforced by linters)
3. Write clear, descriptive commit messages following Conventional Commits
4. Add tests for new functionality
5. Update documentation as needed

### Commit Message Convention

This project uses Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat:` A new feature
- `fix:` A bug fix
- `docs:` Documentation only changes
- `style:` Changes that don't affect code meaning
- `refactor:` Code changes that don't add features or fix bugs
- `perf:` Code changes that improve performance
- `test:` Adding missing tests or correcting existing tests
- `chore:` Changes to build process, dependencies, or tools

Example:
```
feat(auth): add OAuth2 support

Add OAuth2 authentication provider to the authorization system.
Implements RFC 6749 standard.

Fixes #123
```

### Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run tests with coverage
npm test -- --coverage
```

### Code Quality Checks

```bash
# Run linter
npm run lint

# Fix linter issues automatically
npm run lint:fix

# Run type checking
npm run type-check

# Run security audit
npm audit

# Run all quality checks
npm run quality-checks
```

## Submitting a Pull Request

1. Push your branch to your fork
2. Create a Pull Request with a clear title and description
3. Reference any related issues (e.g., "Fixes #123")
4. Fill out the PR template completely
5. Ensure all CI checks pass
6. Wait for review and address any feedback

### PR Requirements

- ✅ All CI checks pass
- ✅ At least one approval from code owners
- ✅ No merge conflicts
- ✅ Updated documentation
- ✅ Tests added/updated for changes
- ✅ Commit messages follow conventions

## Review Process

- Maintainers aim to review PRs within 24-48 hours
- Reviews may request changes, which should be addressed promptly
- Once approved, your PR will be merged by a maintainer

## Reporting Issues

### Bug Reports

Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Screenshots if applicable

### Feature Requests

Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md) and include:
- Clear description of the feature
- Use case and benefit
- Acceptance criteria
- Priority level

## Documentation

- Update README.md if adding new features
- Add comments to complex code
- Update API documentation if applicable
- Keep CHANGELOG.md updated with significant changes

## Release Process

1. Update version in package.json and pyproject.toml
2. Update CHANGELOG.md
3. Create a git tag: `git tag -a v1.0.0 -m "Release 1.0.0"`
4. Push the tag: `git push origin v1.0.0`
5. Create a GitHub release from the tag

## Questions?

- Check the [README](../README.md) and documentation
- Look through existing issues and PRs
- Open a discussion or issue with your question

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
