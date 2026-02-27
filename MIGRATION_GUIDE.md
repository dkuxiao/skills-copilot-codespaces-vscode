# Migration Guide: Creating minimal-focus-app Repository

This guide explains how to create a new GitHub repository called "minimal-focus-app" and transfer the Flutter productivity app code to it.

## Prerequisites

- GitHub account with permission to create repositories
- Git installed locally
- Flutter SDK installed

## Step 1: Create New GitHub Repository

1. Go to https://github.com/new
2. Repository name: `minimal-focus-app`
3. Description: "A minimal productivity app with focus timer and habit tracking"
4. Choose: Public or Private
5. **Do NOT initialize** with README, .gitignore, or license (we'll add our own)
6. Click "Create repository"

## Step 2: Clone This Repository Locally

```bash
# Clone the source repository
git clone https://github.com/dkuxiao/skills-copilot-codespaces-vscode.git
cd skills-copilot-codespaces-vscode

# Switch to the Flutter app branch
git checkout claude/implement-minimal-productivity-app
```

## Step 3: Prepare Flutter Project Files

Create a new directory for the migration:

```bash
# Create a fresh directory
cd ..
mkdir minimal-focus-app
cd minimal-focus-app

# Initialize as a git repository
git init
git branch -M main
```

## Step 4: Copy Flutter Project Files

```bash
# Copy all Flutter project files from the source
cp -r ../skills-copilot-codespaces-vscode/lib ./
cp ../skills-copilot-codespaces-vscode/pubspec.yaml ./
cp ../skills-copilot-codespaces-vscode/analysis_options.yaml ./
cp ../skills-copilot-codespaces-vscode/.gitignore ./
cp ../skills-copilot-codespaces-vscode/README.md ./
cp ../skills-copilot-codespaces-vscode/IMPLEMENTATION.md ./
```

## Step 5: Add Standard Flutter Project Files

You may want to add these standard Flutter files (optional):

```bash
# Create test directory
mkdir test

# Create platform directories if needed
mkdir -p android ios web linux macos windows
```

## Step 6: Connect to New GitHub Repository

```bash
# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/minimal-focus-app.git

# Verify remote
git remote -v
```

## Step 7: Commit and Push to Main Branch

```bash
# Add all files
git add .

# Commit
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

# Push to main branch
git push -u origin main
```

## Step 8: Verify and Setup

```bash
# Install dependencies
flutter pub get

# Generate Hive adapters (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Alternative: Using the Migration Script

We've provided a migration script that automates steps 2-7. See `migrate-to-new-repo.sh`.

```bash
chmod +x migrate-to-new-repo.sh
./migrate-to-new-repo.sh YOUR_GITHUB_USERNAME
```

## Verification Checklist

After migration, verify:

- [ ] Repository created on GitHub
- [ ] All Flutter source files present in `lib/`
- [ ] `pubspec.yaml` with all dependencies
- [ ] `.gitignore` configured properly
- [ ] README.md and IMPLEMENTATION.md included
- [ ] Code pushed to main branch
- [ ] `flutter pub get` runs successfully
- [ ] `flutter run` launches the app

## Troubleshooting

### Issue: Permission denied when pushing

```bash
# Make sure you're authenticated
gh auth login
# OR use SSH keys
```

### Issue: Flutter dependencies fail

```bash
# Clear cache and retry
flutter pub cache repair
flutter pub get
```

### Issue: Build runner fails

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Repository Structure

After migration, your new repository will have:

```
minimal-focus-app/
├── .git/
├── .gitignore
├── README.md
├── IMPLEMENTATION.md
├── analysis_options.yaml
├── pubspec.yaml
└── lib/
    ├── features/
    │   ├── home/
    │   ├── focus/
    │   ├── ritual/
    │   ├── habits/
    │   └── condition/
    ├── models/
    ├── providers/
    ├── theme/
    ├── utils/
    └── main.dart
```

## Next Steps

After successful migration:

1. Update repository description on GitHub
2. Add topics/tags: `flutter`, `productivity`, `pomodoro`, `habits`
3. Create issues for future enhancements
4. Set up CI/CD if needed
5. Add LICENSE file if desired
6. Consider adding GitHub Actions for Flutter CI

## Support

If you encounter issues:
- Check Flutter installation: `flutter doctor`
- Verify Git configuration: `git config --list`
- Ensure GitHub credentials are set up
- Review the IMPLEMENTATION.md for technical details
