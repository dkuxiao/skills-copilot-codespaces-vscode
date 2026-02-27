# Minimal Focus App - Flutter MVP

A minimal focus app built with Flutter centered on concentration, habit tracking, and productivity.

## Features

- **Pomodoro Timer**: Customizable focus timer (default 25 minutes)
- **Eye Focus Ritual**: 30-second breathing exercise with visual focus point
- **Habit Tracking**: Daily habit check-ins with historical tracking
- **Daily Goals**: Task checklist for the current day
- **Condition Tracking**: Record sleep, mood, and focus levels

## Tech Stack

- **Flutter** (SDK >= 3.0.0)
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Routing**: go_router
- **Notifications**: flutter_local_notifications (setup pending)

## Project Structure

```
lib/
├── features/          # Feature-based organization
│   ├── home/         # Dashboard/home screen
│   ├── focus/        # Pomodoro timer
│   ├── ritual/       # Eye focus ritual mode
│   ├── habits/       # Habit management
│   └── condition/    # Daily condition tracking
├── models/           # Hive data models
├── providers/        # Riverpod state providers
├── theme/            # App theme configuration
├── utils/            # Utility functions and router
└── main.dart         # App entry point
```

## Setup Instructions

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   cd /path/to/skills-copilot-codespaces-vscode
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive type adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d chrome      # Web
   flutter run -d ios         # iOS
   flutter run -d android     # Android
   ```

## Usage

### Home Screen
- View daily goals and habits
- Quick access to focus modes
- Check/update daily condition

### Pomodoro Focus
- Default 25-minute timer (customizable)
- Start, pause, and reset controls
- Timer countdown display

### Eye Focus Ritual
- 30-second guided breathing exercise
- Visual focus point (black dot)
- Leads into focus session

### Habits
- Create and manage daily habits
- Track completion over time
- Delete habits when no longer needed

### Condition Tracking
- Log sleep hours (0-12 hours)
- Rate mood (1-5 scale)
- Rate focus level (1-5 scale)

## Development

### Running Tests
```bash
flutter test
```

### Code Generation
When modifying Hive models, regenerate adapters:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Building for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Design Philosophy

- **Minimal**: No unnecessary features or visual clutter
- **Dark Mode**: Optimized for focus with calming colors
- **Local First**: All data stored locally, no cloud sync
- **Distraction-free**: Simple, purpose-driven interface

## Color Scheme

- Background: `#0D0D0D`
- Surface: `#1A1A1A`
- Primary: `#6C7A89`
- Secondary: `#95A5A6`
- Text: `#E0E0E0`

## Future Enhancements

- [ ] Local notifications for timer completion
- [ ] Statistics and insights
- [ ] Export/backup data
- [ ] Customizable themes
- [ ] Break timer after pomodoro sessions

## License

MIT License
