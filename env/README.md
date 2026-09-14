# Environment files

Use the matching entrypoint for each environment:

```bash
flutter run -t lib/main_development.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_production.dart
```

Copy `.env.example` when creating a new local environment file. The concrete `.env.*` files are ignored by git and are bundled as Flutter assets at build time.

Read the active configuration through `getIt<AppConfig>()` after bootstrap has completed.