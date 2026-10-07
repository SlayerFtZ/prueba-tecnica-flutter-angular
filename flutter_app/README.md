# flutter_app

A Flutter mini product catalog with search, product detail and a persistent shopping cart.

![CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/ci.yml/badge.svg)

## Features

- Browse products and categories with pagination
- Search with debounce (400 ms) and category filter
- Product detail with quantity selector
- Shopping cart persisted locally with `shared_preferences`
- Light/dark theme

## Tech stack

- **State management:** Riverpod with code generation (`riverpod_generator`, `@riverpod`)
- **Navigation:** `go_router`
- **HTTP:** `dio`
- **Persistence:** `shared_preferences`
- **Config:** `flutter_dotenv`

## Architecture

Feature-first clean architecture. Each feature is split into layers:

```
lib/
├── config/        # router, theme, environment constants
├── core/          # shared utils and error types
└── features/
    ├── cart/
    ├── home/
    ├── product/
    │   ├── domain/           # entities, repository and datasource contracts
    │   ├── infrastructure/   # models, mappers, datasource and repository impls
    │   └── presentation/     # providers, screens, widgets
    └── shared/
```

## Getting started

### Requirements

- Flutter SDK compatible with Dart `^3.13.5`

### Setup

```bash
# 1. Create your local environment file
cp .env.template .env      # Windows PowerShell: Copy-Item .env.template .env

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

Fill in the values of `.env` following the keys listed in `.env.template`.

## Code generation

Providers are written with `@riverpod`. The generated `*.g.dart` files are committed
to the repository, so the app compiles right after cloning.

If you change a provider, regenerate the code:

```bash
dart run build_runner build
```

> **Note:** `pubspec.yaml` pins `analyzer` through `dependency_overrides`.
> `build_runner 2.16.1` is not compatible with `analyzer 14.5.0` (it uses an
> internal API that was removed). Remove the override once `build_runner`
> publishes a compatible release.

## Testing

```bash
flutter analyze
flutter test
```

Includes an integration-style widget test of the main user flow
(**search → product detail → add to cart**) in
`test/flows/purchase_flow_test.dart`. It runs the real app and router, replacing
only the products repository (with a fake) and `SharedPreferences`, so it needs
no network or emulator.

## Continuous integration

A GitHub Actions workflow (`.github/workflows/ci.yml`) runs on every push and
pull request:

1. Creates `.env` from `.env.template`
2. `flutter pub get`
3. `dart run build_runner build`
4. `flutter analyze`
5. `flutter test`