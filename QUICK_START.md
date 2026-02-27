# Quick Reference: Create minimal-focus-app Repository

## Method 1: Automated Script (Recommended)

```bash
# From the current repository directory
./migrate-to-new-repo.sh YOUR_GITHUB_USERNAME

# Then create repo on GitHub at https://github.com/new
# Name it: minimal-focus-app
# Do NOT initialize with README

# Finally, push:
cd ../minimal-focus-app
git push -u origin main
```

## Method 2: Manual Commands

```bash
# 1. Create new directory and initialize
mkdir ../minimal-focus-app
cd ../minimal-focus-app
git init
git branch -M main

# 2. Copy Flutter files (run from minimal-focus-app directory)
SOURCE="../skills-copilot-codespaces-vscode"
cp -r $SOURCE/lib ./
cp $SOURCE/pubspec.yaml ./
cp $SOURCE/analysis_options.yaml ./
cp $SOURCE/.gitignore ./
cp $SOURCE/README.md ./
cp $SOURCE/IMPLEMENTATION.md ./
mkdir test

# 3. Add remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/minimal-focus-app.git

# 4. Commit and push
git add .
git commit -m "Initial commit: Flutter productivity app"
git push -u origin main
```

## Method 3: Using GitHub CLI

```bash
# 1. Create repository on GitHub
gh repo create minimal-focus-app --public --source=. --remote=upstream

# 2. Copy files as in Method 2
# 3. Push to main
git push -u upstream main
```

## Verify Installation

```bash
cd minimal-focus-app
flutter pub get
flutter run
```

## Files Included

- `lib/` - All Flutter source code (21 files)
- `pubspec.yaml` - Dependencies configuration
- `analysis_options.yaml` - Linting rules
- `.gitignore` - Git ignore patterns
- `README.md` - Project documentation
- `IMPLEMENTATION.md` - Technical details

## Repository Info

- **Name**: minimal-focus-app
- **Type**: Flutter mobile application
- **Features**: Pomodoro, Habits, Focus Ritual, Condition Tracking
- **Lines of Code**: ~1,700+
- **Platform**: iOS, Android, Web compatible
