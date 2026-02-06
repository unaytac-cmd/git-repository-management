#!/bin/bash
# Script to set up Git hooks with Husky

set -e

echo "🚀 Setting up Git hooks for code quality enforcement..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ first."
    exit 1
fi

echo "✅ Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ npm found: $(npm --version)"

# Install Node.js dependencies
echo ""
echo "📦 Installing Node.js dependencies..."
npm install

# Install Husky hooks
echo ""
echo "🪝 Installing Husky Git hooks..."
npm run prepare

# Make hook scripts executable
echo ""
echo "🔧 Making hook scripts executable..."
chmod +x .husky/pre-commit
chmod +x .husky/commit-msg
chmod +x .husky/pre-push
chmod +x .husky/_/husky.sh

echo ""
echo "✅ Git hooks setup complete!"
echo ""
echo "📋 Installed hooks:"
echo "  - pre-commit: Runs linters (ESLint for JS, Black for Python)"
echo "  - commit-msg: Validates commit message format (conventional commits)"
echo "  - pre-push: Runs test suite (Jest for JS, pytest for Python)"
echo ""

# Check if Python is installed
if command -v python3 &> /dev/null; then
    echo "✅ Python found: $(python3 --version)"
    echo ""
    echo "📦 To install Python development dependencies, run:"
    echo "   pip install -r requirements-dev.txt"
    echo ""
else
    echo "⚠️  Python not found. Python linting will be skipped."
    echo "   Install Python 3.8+ to enable Python code quality checks."
    echo ""
fi

echo "🎉 Setup complete! You're ready to start committing with quality checks."
echo ""
echo "💡 Tips:"
echo "  - Test commit message: git commit --allow-empty -m 'test: sample commit'"
echo "  - Skip hooks temporarily: git commit --no-verify"
echo "  - View hook logs: Check terminal output during git operations"
