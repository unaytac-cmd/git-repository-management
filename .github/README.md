# GitHub Configuration

This directory contains GitHub-specific configuration and automation files for the project.

## Directory Structure

```
.github/
├── workflows/              # GitHub Actions CI/CD workflows
│   ├── ci.yml             # Continuous Integration pipeline
│   ├── deploy.yml         # Deployment workflows
│   ├── quality-checks.yml # Code quality and linting
│   ├── branch-protection.yml  # Branch protection verification
│   ├── dependabot.yml     # Dependabot automation
│   └── release.yml        # Release automation
├── ISSUE_TEMPLATE/        # Issue templates
│   ├── bug_report.md      # Bug report template
│   ├── feature_request.md # Feature request template
│   └── config.yml         # Issue template configuration
├── PULL_REQUEST_TEMPLATE.md  # Pull request template
├── CODEOWNERS             # Code ownership rules
├── CONTRIBUTING.md        # Contribution guidelines
├── SECURITY.md           # Security policy
└── settings.yml          # Repository settings reference
```

## Workflows

### CI Pipeline (`ci.yml`)
- Runs on push to main/develop and pull requests
- Tests with Node.js 18.x and 20.x
- Tests with Python 3.9, 3.10, 3.11
- Runs linters and formatters
- Uploads coverage reports to Codecov
- Performs security scanning with Trivy
- Builds and pushes Docker images on main branch

**Triggers:** 
- `push` to `main`, `develop`
- `pull_request` targeting `main`, `develop`

### Deployment (`deploy.yml`)
- Deploys to staging on main branch push
- Deploys to production on version tags
- Runs smoke tests and validation
- Creates deployment notifications

**Triggers:**
- `push` to `main` (staging deployment)
- Push of version tags `v*` (production deployment)
- Manual workflow dispatch

### Quality Checks (`quality-checks.yml`)
- Runs code quality tools
- Performs static analysis
- Validates commit messages
- Checks test coverage

**Triggers:**
- `push` events
- `pull_request` events

### Branch Protection (`branch-protection.yml`)
- Verifies branch protection rules are followed
- Checks for required reviews
- Verifies commit signatures
- Ensures status checks pass

**Triggers:**
- Pull requests to `main`
- Pull request reviews

### Dependabot (`dependabot.yml`)
- Auto-approves Dependabot PRs
- Enables auto-merge for dependency updates
- Keeps dependencies up to date

**Triggers:**
- Pull requests from `dependabot[bot]`

### Release (`release.yml`)
- Creates GitHub releases
- Generates changelogs
- Publishes to npm
- Sends notifications

**Triggers:**
- Push of version tags `v*`
- Manual workflow dispatch

## Templates

### Issue Templates
- **Bug Report** - For reporting bugs with structured information
- **Feature Request** - For proposing new features with acceptance criteria

### Pull Request Template
- Structured template for all PRs
- Includes testing checklist
- References related issues
- Type of change categorization

## Configuration Files

### CODEOWNERS
Defines code ownership and automatically requests reviews from relevant teams on PRs.

Current owners:
- `@devops-team` - DevOps, infrastructure, CI/CD
- `@documentation-team` - Documentation

### CONTRIBUTING.md
Complete guide for contributors including:
- Setup instructions
- Development workflow
- Commit message conventions
- Pull request process
- Code quality requirements

### SECURITY.md
Security policy and practices:
- Vulnerability reporting
- Security practices
- Compliance standards
- Supported versions

### settings.yml
Reference configuration for repository settings including:
- Repository description and topics
- Branch protection rules
- Security settings
- Automation settings

## Branch Protection Rules

The `main` branch has the following protection rules enabled:

✅ **Require Pull Request Reviews**
- Minimum 1 approval required
- Code owner reviews required
- Stale reviews are dismissed

✅ **Require Status Checks to Pass**
- All CI/CD checks must pass
- Status checks are strict (not outdated)

✅ **Enforce Admins**
- Rules apply to administrators too

✅ **Restrict Force Pushes**
- Force pushes are disabled

✅ **Require Conversation Resolution**
- All conversations must be resolved before merge

## Secrets Required

The following secrets should be configured in repository settings:

- `NPM_TOKEN` - npm registry authentication (for publish)
- `SLACK_WEBHOOK_URL` - Slack notifications (optional)
- `DOCKER_USERNAME` - Docker registry username
- `DOCKER_PASSWORD` - Docker registry password

## Setting Up Repository

### Manual Setup Checklist

1. **Enable Branch Protection**
   - Go to Settings → Branches → main
   - Enable required status checks
   - Enable require pull request reviews
   - Enable require code owner reviews

2. **Configure Secrets**
   - Go to Settings → Secrets and variables → Actions
   - Add required secrets listed above

3. **Enable Security Features**
   - Settings → Code security and analysis
   - Enable Dependabot alerts
   - Enable Dependabot security updates
   - Enable secret scanning
   - Enable security alerts

4. **Configure Environments**
   - Create `staging` environment
   - Create `production` environment
   - Add protection rules and required reviewers

5. **Review CODEOWNERS**
   - Update team names in `.github/CODEOWNERS`
   - Ensure teams exist in organization

## Automation Features

- 🤖 **Automated Testing** - Tests run on every push and PR
- 🔐 **Security Scanning** - Vulnerability detection enabled
- 📦 **Dependency Management** - Automatic dependency updates via Dependabot
- 🐳 **Container Builds** - Automatic Docker image builds and registry pushes
- ✅ **Quality Gates** - Code quality checks required for merge
- 📋 **Code Reviews** - Automatic review requests based on CODEOWNERS
- 🏷️ **Automated Releases** - Release creation and publishing on tags

## Quick Links

- [Contributing Guide](CONTRIBUTING.md)
- [Security Policy](SECURITY.md)
- [Bug Report Template](ISSUE_TEMPLATE/bug_report.md)
- [Feature Request Template](ISSUE_TEMPLATE/feature_request.md)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Troubleshooting

### Workflow Failing
1. Check the workflow logs in Actions tab
2. Verify secrets are set correctly
3. Ensure branch protection rules aren't too restrictive
4. Check commit message format (must follow Conventional Commits)

### Status Checks Not Passing
1. Run quality checks locally: `npm run quality-checks`
2. Fix any linting or test errors
3. Verify all dependencies are installed
4. Check for environment-specific issues

### Deploy Failed
1. Check deployment logs in Actions tab
2. Verify environment secrets and variables are set
3. Ensure target environment is accessible
4. Review application logs in target environment
