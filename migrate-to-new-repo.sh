#!/bin/bash

# Migration Script: Transfer Flutter App to New Repository
# Usage: ./migrate-to-new-repo.sh YOUR_GITHUB_USERNAME

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if GitHub username provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: GitHub username required${NC}"
    echo "Usage: ./migrate-to-new-repo.sh YOUR_GITHUB_USERNAME"
    exit 1
fi

GITHUB_USERNAME="$1"
REPO_NAME="minimal-focus-app"
SOURCE_DIR="$(pwd)"

echo -e "${GREEN}=== Flutter App Migration Script ===${NC}"
echo -e "GitHub Username: ${YELLOW}$GITHUB_USERNAME${NC}"
echo -e "Repository Name: ${YELLOW}$REPO_NAME${NC}"
echo ""

# Step 1: Verify we're in the right directory
if [ ! -f "pubspec.yaml" ] || [ ! -d "lib" ]; then
    echo -e "${RED}Error: Not in a Flutter project directory${NC}"
    echo "Please run this script from the Flutter project root"
    exit 1
fi

echo -e "${GREEN}✓ Verified Flutter project structure${NC}"

# Step 2: Create new directory
cd ..
if [ -d "$REPO_NAME" ]; then
    echo -e "${YELLOW}Warning: Directory $REPO_NAME already exists${NC}"
    read -p "Delete and recreate? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$REPO_NAME"
    else
        echo -e "${RED}Aborted${NC}"
        exit 1
    fi
fi

mkdir "$REPO_NAME"
cd "$REPO_NAME"

echo -e "${GREEN}✓ Created directory: $REPO_NAME${NC}"

# Step 3: Initialize Git repository
git init
git branch -M main

echo -e "${GREEN}✓ Initialized Git repository with main branch${NC}"

# Step 4: Copy Flutter project files
echo "Copying Flutter project files..."

cp -r "$SOURCE_DIR/lib" ./
cp "$SOURCE_DIR/pubspec.yaml" ./
cp "$SOURCE_DIR/analysis_options.yaml" ./
cp "$SOURCE_DIR/.gitignore" ./
cp "$SOURCE_DIR/README.md" ./
cp "$SOURCE_DIR/IMPLEMENTATION.md" ./

# Copy migration guide if it exists
if [ -f "$SOURCE_DIR/MIGRATION_GUIDE.md" ]; then
    cp "$SOURCE_DIR/MIGRATION_GUIDE.md" ./
fi

echo -e "${GREEN}✓ Copied all Flutter project files${NC}"

# Step 5: Create test directory structure
mkdir -p test

echo -e "${GREEN}✓ Created test directory${NC}"

# Step 6: Add remote
REMOTE_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
git remote add origin "$REMOTE_URL"

echo -e "${GREEN}✓ Added remote: $REMOTE_URL${NC}"

# Step 7: Stage all files
git add .

echo -e "${GREEN}✓ Staged all files${NC}"

# Step 8: Create initial commit
git commit -m "Initial commit: Flutter productivity app

Features:
- Pomodoro timer with customizable duration
- Eye focus ritual with breathing guidance
- Habit tracking with daily completion
- Daily goals checklist
- Condition tracking (sleep, mood, focus)

Tech stack:
- Flutter SDK >=3.0.0
- Riverpod for state management
- Hive for local storage
- go_router for navigation
- Dark mode with minimal design"

echo -e "${GREEN}✓ Created initial commit${NC}"

# Step 9: Display next steps
echo ""
echo -e "${GREEN}=== Migration Prepared Successfully ===${NC}"
echo ""
echo "Next steps:"
echo -e "1. Create the repository on GitHub:"
echo -e "   ${YELLOW}https://github.com/new${NC}"
echo -e "   Name: ${YELLOW}minimal-focus-app${NC}"
echo -e "   ${RED}Do NOT initialize with README or .gitignore${NC}"
echo ""
echo -e "2. Push to GitHub:"
echo -e "   ${YELLOW}cd $(pwd)${NC}"
echo -e "   ${YELLOW}git push -u origin main${NC}"
echo ""
echo -e "3. Verify installation:"
echo -e "   ${YELLOW}flutter pub get${NC}"
echo -e "   ${YELLOW}flutter run${NC}"
echo ""
echo -e "${GREEN}Repository ready at: $(pwd)${NC}"
