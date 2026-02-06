#!/bin/bash
# Standalone script to validate commit message format
# Can be used independently of Husky for testing

COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Regex pattern for conventional commits
PATTERN="^(feat|fix|docs|style|refactor|perf|test|chore|ci|infra|revert)(\([a-z0-9-]+\))?: .{1,100}$"

if [[ ! $COMMIT_MSG =~ $PATTERN ]]; then
    echo "❌ Invalid commit message format"
    echo ""
    echo "Your commit message:"
    echo "  $COMMIT_MSG"
    echo ""
    echo "Expected format: type(scope): subject"
    echo ""
    echo "Valid types: feat, fix, docs, style, refactor, perf, test, chore, ci, infra, revert"
    echo ""
    echo "Examples:"
    echo "  feat(auth): add JWT token validation"
    echo "  fix(api): resolve timeout issue"
    echo "  docs: update README with setup instructions"
    echo ""
    exit 1
fi

echo "✅ Commit message format is valid"
exit 0
