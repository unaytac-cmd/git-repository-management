#!/bin/bash
# Script to verify Git hooks are properly installed and configured

set -e

echo "🔍 Verifying Git hooks installation..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SUCCESS=0
WARNINGS=0
ERRORS=0

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo -e "${RED}❌ Not in a git repository${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Git repository found${NC}"

# Check if Node.js is installed
if command -v node &> /dev/null; then
    echo -e "${GREEN}✅ Node.js found: $(node --version)${NC}"
    ((SUCCESS++))
else
    echo -e "${RED}❌ Node.js not installed${NC}"
    ((ERRORS++))
fi

# Check if npm is installed
if command -v npm &> /dev/null; then
    echo -e "${GREEN}✅ npm found: $(npm --version)${NC}"
    ((SUCCESS++))
else
    echo -e "${RED}❌ npm not installed${NC}"
    ((ERRORS++))
fi

# Check if node_modules exists
if [ -d node_modules ]; then
    echo -e "${GREEN}✅ node_modules directory exists${NC}"
    ((SUCCESS++))
else
    echo -e "${YELLOW}⚠️  node_modules not found. Run: npm install${NC}"
    ((WARNINGS++))
fi

# Check if Husky is installed
if [ -d .husky ]; then
    echo -e "${GREEN}✅ .husky directory exists${NC}"
    ((SUCCESS++))
else
    echo -e "${RED}❌ .husky directory not found${NC}"
    ((ERRORS++))
fi

# Check individual hooks
HOOKS=("pre-commit" "commit-msg" "pre-push")
for hook in "${HOOKS[@]}"; do
    if [ -f ".husky/$hook" ]; then
        if [ -x ".husky/$hook" ]; then
            echo -e "${GREEN}✅ $hook hook exists and is executable${NC}"
            ((SUCCESS++))
        else
            echo -e "${YELLOW}⚠️  $hook hook exists but is not executable${NC}"
            echo "   Run: chmod +x .husky/$hook"
            ((WARNINGS++))
        fi
    else
        echo -e "${RED}❌ $hook hook not found${NC}"
        ((ERRORS++))
    fi
done

# Check configuration files
CONFIG_FILES=(
    "package.json"
    "commitlint.config.js"
    ".eslintrc.js"
    "jest.config.js"
    "pyproject.toml"
)

echo ""
echo "📋 Checking configuration files..."
for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ $file not found${NC}"
        ((ERRORS++))
    fi
done

# Check if Python is installed (optional)
echo ""
echo "🐍 Checking Python environment (optional)..."
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}✅ Python found: $(python3 --version)${NC}"
    
    # Check if Black is installed
    if command -v black &> /dev/null; then
        echo -e "${GREEN}✅ Black found: $(black --version)${NC}"
    else
        echo -e "${YELLOW}⚠️  Black not installed. Run: pip install -r requirements-dev.txt${NC}"
        ((WARNINGS++))
    fi
    
    # Check if pytest is installed
    if command -v pytest &> /dev/null; then
        echo -e "${GREEN}✅ pytest found: $(pytest --version | head -1)${NC}"
    else
        echo -e "${YELLOW}⚠️  pytest not installed. Run: pip install -r requirements-dev.txt${NC}"
        ((WARNINGS++))
    fi
else
    echo -e "${YELLOW}⚠️  Python not found. Python linting will be skipped.${NC}"
    ((WARNINGS++))
fi

# Check documentation
echo ""
echo "📚 Checking documentation..."
DOC_FILES=(
    "README.md"
    "docs/GIT-HOOKS.md"
    "docs/QUICK-START.md"
    "CHANGELOG.md"
)

for file in "${DOC_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ $file not found${NC}"
        ((ERRORS++))
    fi
done

# Test hook execution (dry run)
echo ""
echo "🧪 Testing hook scripts..."

# Test pre-commit hook syntax
if [ -f .husky/pre-commit ]; then
    if bash -n .husky/pre-commit 2>/dev/null; then
        echo -e "${GREEN}✅ pre-commit hook syntax valid${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ pre-commit hook has syntax errors${NC}"
        ((ERRORS++))
    fi
fi

# Test commit-msg hook syntax
if [ -f .husky/commit-msg ]; then
    if bash -n .husky/commit-msg 2>/dev/null; then
        echo -e "${GREEN}✅ commit-msg hook syntax valid${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ commit-msg hook has syntax errors${NC}"
        ((ERRORS++))
    fi
fi

# Test pre-push hook syntax
if [ -f .husky/pre-push ]; then
    if bash -n .husky/pre-push 2>/dev/null; then
        echo -e "${GREEN}✅ pre-push hook syntax valid${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ pre-push hook has syntax errors${NC}"
        ((ERRORS++))
    fi
fi

# Test commitlint
echo ""
echo "🔍 Testing commitlint..."
if [ -f node_modules/.bin/commitlint ]; then
    TEST_MSG="feat(test): test commit message"
    if echo "$TEST_MSG" | npx commitlint &>/dev/null; then
        echo -e "${GREEN}✅ commitlint working correctly${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}❌ commitlint test failed${NC}"
        ((ERRORS++))
    fi
else
    echo -e "${YELLOW}⚠️  commitlint not installed in node_modules${NC}"
    ((WARNINGS++))
fi

# Summary
echo ""
echo "================================================"
echo "📊 VERIFICATION SUMMARY"
echo "================================================"
echo -e "${GREEN}✅ Successful checks: $SUCCESS${NC}"
if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Warnings: $WARNINGS${NC}"
fi
if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}❌ Errors: $ERRORS${NC}"
fi
echo "================================================"

if [ $ERRORS -eq 0 ]; then
    echo ""
    echo -e "${GREEN}🎉 All critical checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Try a test commit: git commit --allow-empty -m 'test: verify hooks'"
    echo "  2. Check hook output for any issues"
    echo "  3. Read docs/QUICK-START.md for usage guide"
    echo ""
    exit 0
else
    echo ""
    echo -e "${RED}⚠️  Some checks failed. Please fix the errors above.${NC}"
    echo ""
    echo "To fix:"
    echo "  - Run: ./scripts/setup-hooks.sh"
    echo "  - Or manually: npm install && npm run prepare"
    echo ""
    exit 1
fi
