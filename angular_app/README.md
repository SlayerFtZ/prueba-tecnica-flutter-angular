# angular_app

Angular application for managing orders, products and dashboard information.

![CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/angular-ci.yml/badge.svg)

## Features

* Dashboard with order summary information
* Browse products
* Browse orders
* Order filtering
* Order detail view
* Order items visualization
* Unit tests for pages, components and services
* Environment configuration through `.env`

## Tech stack

* **Framework:** Angular 22
* **Language:** TypeScript
* **Styling:** CSS
* **Testing:** Vitest
* **UI components:** SweetAlert2
* **Build tooling:** Angular CLI
* **Environment:** `.env` with a generated TypeScript configuration file
* **CI:** GitHub Actions

## Architecture

Feature-first architecture. Each feature groups its pages, components, models, services and routes:

```text
src/app/

├── core/
│   └── config/              # environment and application configuration
│
├── features/
│   ├── dashboard/
│   │   ├── pages/           # dashboard views
│   │   └── dashboard-routes.ts
│   │
│   ├── orders/
│   │   ├── components/      # order cards, filters and items
│   │   ├── models/          # order models
│   │   ├── pages/           # orders list and order detail
│   │   ├── services/        # orders API service
│   │   └── orders.routes.ts
│   │
│   └── products/
│       ├── components/      # product components
│       ├── models/          # product models
│       ├── pages/           # products list
│       ├── services/        # products API service
│       └── products-routes.ts
│
└── shared/                  # shared application components
```

Each feature is organized according to its responsibility:

* **pages:** main views of each feature, such as the dashboard, orders list, order detail and products list.
* **components:** reusable UI components specific to a feature.
* **models:** TypeScript models used to represent application data.
* **services:** services responsible for communication with the API and feature-related data logic.
* **routes:** route definitions for each feature.
* **spec.ts:** unit tests associated with pages, components and services.

This structure keeps each feature encapsulated and makes the application easier to maintain and extend as it grows.

## Getting started

### Requirements

* Node.js compatible with the project dependencies
* npm 11+
* Angular CLI 22

### Setup

```bash
# 1. Install dependencies
npm install

# 2. Start the development server
npm start
```

The application uses an environment file to configure the API URL.

Create a local `.env` file from the provided template:

```bash
# Linux/macOS
cp .env.template .env

# Windows PowerShell
Copy-Item .env.template .env
```

The `.env` file should contain the required values defined in `.env.template`.

## Environment configuration

The application generates its TypeScript environment configuration before running or building the application.

The command:

```bash
npm run env
```

reads `.env` when available, or `.env.template` as a fallback, and generates:

```text
src/app/core/config/env.generated.ts
```

The generated file is ignored by Git and should not be edited manually.

The main environment variable is:

```env
API_URL=https://dummyjson.com
```

## Testing

Run the unit tests with:

```bash
npm test
```

The project includes unit tests for pages, components and services using Angular's configured testing environment.

## Build

To create a production build:

```bash
npm run build
```

The build process also generates the environment configuration before compiling the application.

The generated application is placed in:

```text
dist/angular_app/
```

## Continuous integration

A GitHub Actions workflow (`.github/workflows/angular-ci.yml`) runs when changes are pushed or proposed through a pull request affecting the Angular application.

The workflow:

1. Checks out the repository.
2. Configures Node.js 22.
3. Installs dependencies with `npm ci`.
4. Creates `.env` from `.env.template`.
5. Runs the unit tests.
6. Builds the Angular application.
