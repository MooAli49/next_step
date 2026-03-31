## Next Step

Next Step is a Flutter mobile application built with GetX and Supabase. It uses
responsive layouts (via `flutter_screenutil`), local caching, and secure
storage to provide a modern, scalable app foundation.

## Features

- Flutter application targeting Android, iOS, web, and desktop
- Routing and state management with GetX
- Supabase integration for backend services
- Local caching via `shared_preferences` and secure data via
  `flutter_secure_storage`
- Responsive UI with `flutter_screenutil`
- Asset management for images, fonts, and JSON configuration

## Tech Stack

- Flutter (Dart)
- GetX
- Supabase Flutter
- Shared Preferences, Secure Storage
- Dio + Pretty Dio Logger
- Flutter ScreenUtil

## Prerequisites

- Flutter SDK installed (matching the version in `pubspec.yaml`)
- Dart SDK (bundled with Flutter)
- Android Studio or Xcode for platform builds

## Getting Started

1. Install Flutter dependencies:

   ```bash
   flutter pub get
   ```

2. Configure Supabase credentials in `lib/core/constants/app_secret.dart` (or
   your own environment management strategy):

   ```dart
   class AppSecret {
     AppSecret._();

     static const String supabaseUrl = 'https://your-project.supabase.co';
     static const String supabaseAnonKey = 'your-anon-or-public-key';
   }
   ```

3. Run the app:

   ```bash
   # Android / iOS
   flutter run

   # Web
   flutter run -d chrome
   ```

## Project Structure (high level)

- `lib/main.dart` – app entry point, initializes services and Supabase
- `lib/next_step.dart` – root widget, sets up `GetMaterialApp` and routes
- `lib/core/` – core constants, routing, services, and utilities
- `assets/` – images, fonts, and JSON configuration (countries, job roles)

## Building for Release

```bash
# Android APK / AppBundle
flutter build apk
flutter build appbundle

# iOS (requires macOS + Xcode)
flutter build ios

# Web
flutter build web
```

Refer to the official Flutter documentation for platform-specific signing and
store deployment steps.
