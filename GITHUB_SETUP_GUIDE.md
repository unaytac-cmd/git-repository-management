# GitHub Repository Setup Guide

This guide documents the complete GitHub repository configuration for professional DevOps and development practices.

## Table of Contents

1. [Repository Overview](#repository-overview)
2. [Initial Setup](#initial-setup)
3. [Branch Protection Configuration](#branch-protection-configuration)
4. [GitHub Actions Workflows](#github-actions-workflows)
5. [Templates and Automation](#templates-and-automation)
6. [Security Configuration](#security-configuration)
7. [Team and Permissions](#team-and-permissions)
8. [Monitoring and Notifications](#monitoring-and-notifications)

## Repository Overview

### Repository Settings

This repository should be configured with:

- **Visibility:** Public (or private based on requirements)
- **Description:** Professional Git repository with CI/CD, issue templates, and branch protection
- **Topics:** `devops`, `git`, `github`, `ci-cd`, `automation`, `infrastructure`
- **Features:** Issues ✓, Projects ✓, Wiki ✓, Downloads ✓

### Repository Information

```
Owner: [Your Organization/User]
Repository: Git Repository Management
Branch: main
Merge Strategy: Squash and merge
Auto Delete Head Branches: ✓ Enabled
```

## Initial Setup

### 1. Create Repository on GitHub

```bash
# If using GitHub CLI
gh repo create [repo-name] \
  --public \
  --description "Professional Git repository with CI/CD and automation" \
  --add-default-branch main
```

### 2. Clone and Configure

```bash
git clone https://github.com/[owner]/[repo-name].git
cd [repo-name]
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### 3. Push Initial Configuration

The repository should already contain:

```
.github/
├── workflows/
│   ├── ci.yml
│   ├── deploy.yml
│   ├── quality-checks.yml
│   ├── branch-protection.yml
│   ├── dependabot.yml
│   └── release.yml
├── ISSUE_TEMPLATE/
│   ├── bug_report.md
│   ├── feature_request.md
│   └── config.yml
├── CODEOWNERS
├── CONTRIBUTING.md
├── SECURITY.md
└── settings.yml
```

## Branch Protection Configuration

### Step-by-Step Setup

1. **Navigate to Settings → Branches**
   - Click "Add rule"
   - Branch name pattern: `main`

2. **Require Pull Request Reviews**
   - ☑ Require a pull request before merging
   - ☑ Require approvals
   - Minimum required approvals: `1`
   - ☑ Require review from code owners
   - ☑ Dismiss stale pull request approvals when new commits are pushed
   - ☑ Require approval of the most recent reviewable push

3. **Require Status Checks to Pass Before Merging**
   - ☑ Require status checks to pass before merging
   - ☑ Require branches to be up to date before merging
   
   Status checks required:
   - `Test and Lint`
   - `Security Checks`

4. **Enforce Administrators**
   - ☑ Include administrators
   - ☑ Enforce all configured restrictions above for administrators

5. **Restrict Direct Pushes**
   - ☑ Restrict who can push to matching branches
   - Select your automation user/bot accounts

6. **Additional Rules**
   - ☑ Require conversation resolution before merging
   - ☑ Require signed commits
   - ☑ Require linear history
   - ☑ Allow force pushes: None
   - ☑ Allow deletions: No

### Verification

```bash
# Test branch protection
# Attempt to push directly to main (should fail)
git push origin main

# Only PRs with approvals can merge
gh pr merge --squash
```

## GitHub Actions Workflows

### Continuous Integration (ci.yml)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests targeting `main` or `develop`

**Steps:**
1. Checkout code
2. Setup Node.js 18.x and 20.x
3. Setup Python 3.9, 3.10, 3.11
4. Install dependencies
5. Run linters and formatters
6. Run test suite
7. Upload coverage to Codecov
8. Run security scans (Trivy)
9. Build and push Docker image (main only)

**Secrets Required:**
- `CODECOV_TOKEN` (optional)
- Docker registry credentials in environment

### Deployment (deploy.yml)

**Triggers:**
- Push to `main` (staging)
- Version tags `v*` (production)
- Manual workflow dispatch

**Environments:**
- `staging` - Requires manual approval
- `production` - Requires manual approval + security checks

**Secrets per Environment:**
- Deployment credentials
- API endpoints
- Configuration secrets

### Quality Checks (quality-checks.yml)

**Triggers:**
- All push events
- All pull requests

**Checks:**
- ESLint
- Prettier
- Python linting (pylint, flake8)
- Type checking (TypeScript)
- Security scanning

### Branch Protection Verification (branch-protection.yml)

**Triggers:**
- Pull requests to `main`
- Review submissions

**Verifications:**
- Required reviews present
- Commit signatures valid
- Status checks passing

### Dependabot (dependabot.yml)

**Triggers:**
- Dependabot pull requests
- Dependency updates available

**Actions:**
- Auto-approves patch/minor updates
- Enables auto-merge
- Adds review comments

### Release (release.yml)

**Triggers:**
- Version tag push `v*`
- Manual workflow dispatch

**Actions:**
- Generates changelog
- Creates GitHub release
- Publishes to npm registry
- Sends Slack notification

## Templates and Automation

### Issue Templates

Located in `.github/ISSUE_TEMPLATE/`

#### Bug Report Template
- Title prefix: `[BUG]`
- Includes sections for reproduction steps
- Asks for environment details
- Requests screenshots

#### Feature Request Template
- Title prefix: `[FEATURE]`
- Includes use case and benefits
- Asks for acceptance criteria
- Allows priority selection

### Pull Request Template

Located at `.github/PULL_REQUEST_TEMPLATE.md`

Required sections:
- Description
- Type of change (bug fix, feature, etc.)
- Related issues
- Testing details
- Comprehensive checklist

### Code Owners (CODEOWNERS)

Teams/users automatically requested for review:

```
* @devops-team                      # Default
.github/ @devops-team               # DevOps files
docker* @devops-team               # Docker configs
.husky/ @devops-team               # Git hooks
pyproject.toml @devops-team        # Python config
package.json @devops-team          # Node config
```

**Setup:**
1. Create teams in your GitHub organization
2. Update `.github/CODEOWNERS` with team names
3. Enable "Require code owner reviews" in branch protection

## Security Configuration

### 1. Enable Security Features

**Settings → Code security and analysis**

- ☑ Dependabot alerts
- ☑ Dependabot security updates  
- ☑ Secret scanning
- ☑ Security alerts

### 2. Secret Management

**Settings → Secrets and variables → Actions**

Required secrets:
```
NPM_TOKEN              # npm package publishing
CODECOV_TOKEN          # Code coverage uploads
SLACK_WEBHOOK_URL      # Slack notifications
DOCKER_USERNAME        # Docker registry
DOCKER_PASSWORD        # Docker registry
```

### 3. Environment Secrets

**Settings → Environments**

Create environments:
- `staging` - Testing/preview
- `production` - Live environment

Per-environment secrets:
```
DEPLOY_KEY             # Deployment SSH key
DEPLOY_HOST            # Target server
DEPLOY_PATH            # Installation path
API_ENDPOINT           # Service URL
```

### 4. Security Policy

Document in `SECURITY.md`:
- Vulnerability reporting process
- Responsible disclosure guidelines
- Security practices followed
- Supported versions
- Security update schedule

## Team and Permissions

### Organization Structure

```
[Organization]
├── Maintainers Team
│   ├── Full repository access
│   ├── Can merge PRs
│   └── Can create releases
├── Developers Team
│   ├── Read + Write access
│   └── Cannot merge protected branches
├── DevOps Team
│   ├── Admin for CI/CD configuration
│   └── Secret management access
└── Documentation Team
    ├── Write access
    └── Documentation review duties
```

### Repository Permissions

```
Team              | Role       | Permissions
-----------------|------------|------------------
Maintainers      | Admin      | All permissions
DevOps Team      | Maintain   | CI/CD, secrets, settings
Developers       | Write      | Code, issues, PRs
Documentation    | Write      | Docs, wiki
```

### Invite Team Members

```bash
# Using GitHub CLI
gh repo add-collaborator [username] --permission [role]

# Roles: pull, push, admin, maintain, triage
```

## Monitoring and Notifications

### Configure Notifications

**Settings → Notifications**

- ☑ Email notifications for PR reviews
- ☑ Email for workflow failures
- ☑ Slack integration enabled

### Slack Integration

1. Install GitHub app in Slack
2. Add webhook URL to repository secrets
3. Configure notification rules

### GitHub Discussions (Optional)

Enable for community engagement:
- **Settings → Features → Discussions**
- Categories: Questions, Announcements, Ideas

### GitHub Projects (Optional)

For organization and tracking:
- Create board view
- Automate status transitions
- Link to issues and PRs

## Workflow Configuration

### Local Development

```bash
# Install dependencies
npm install
pip install -r requirements-dev.txt

# Setup git hooks
npm run setup-hooks

# Run quality checks locally
npm run quality-checks

# Create feature branch
git checkout -b feature/awesome-feature

# Make changes, commit with conventional messages
git commit -m "feat(feature): awesome implementation"

# Push and create PR
git push origin feature/awesome-feature
```

### Creating Pull Requests

```bash
# Create PR with template
gh pr create \
  --title "feat: awesome feature" \
  --body "$(cat .github/PULL_REQUEST_TEMPLATE.md)" \
  --base main
```

### Merging Strategy

- **Squash and merge** - Default (clean history)
- **Create merge commit** - For major features
- **Rebase and merge** - Preferred for documentation

## Troubleshooting

### Common Issues

**Issue:** Status checks failing on PR
- Run `npm run quality-checks` locally
- Fix linting and test errors
- Ensure all dependencies installed

**Issue:** Can't merge PR despite approvals
- Check branch protection rules
- Verify status checks pass
- Ensure branch is up to date with main

**Issue:** Workflow not running
- Check `.github/workflows/*.yml` syntax
- Verify branch filter matches current branch
- Check for syntax errors in YAML

**Issue:** Secrets not accessible in workflow
- Verify secrets are defined in Settings
- Check environment is configured if using environments
- Ensure workflow has correct permissions

## Maintenance

### Regular Tasks

- **Weekly:** Review failed workflows and fix issues
- **Bi-weekly:** Review and merge Dependabot updates
- **Monthly:** Audit repository settings and access
- **Quarterly:** Review and update templates and policies

### Backup and Disaster Recovery

```bash
# Mirror repository
git clone --mirror https://github.com/[owner]/[repo].git
git push --mirror https://github.com/[backup-owner]/[repo].git

# Backup settings (requires manual process)
# Document in GITHUB_SETUP_GUIDE.md
```

## Additional Resources

- [GitHub Documentation](https://docs.github.com)
- [GitHub Actions Guide](https://docs.github.com/en/actions)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

---

## Checklist for Repository Setup

- [ ] Repository created on GitHub
- [ ] All configuration files pushed
- [ ] Branch protection enabled on `main`
- [ ] Status checks configured
- [ ] Code owner reviews enabled
- [ ] Secrets configured in Settings
- [ ] Environments created (staging, production)
- [ ] Security features enabled
- [ ] Teams created and permissions set
- [ ] Slack integration configured
- [ ] Documentation updated
- [ ] First PR created and merged
- [ ] Workflows tested and verified

---

**Last Updated:** 2024
**Version:** 1.0.0
