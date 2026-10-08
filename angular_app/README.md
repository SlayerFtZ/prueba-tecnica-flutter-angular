# angular_app

Angular admin-style **orders panel** that lists carts from the
[DummyJSON](https://dummyjson.com/docs/carts) API, with a reactive filter, a
lazy-loaded detail page, and extra dashboard and products pages.

![CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/angular-ci.yml/badge.svg)

## Features

* Orders list rendered as cards (`GET /carts`)
* Reactive filter by **minimum total** and **user ID**
* Loading, error (with retry) and empty states
* Order detail at `/orders/:id` (lazy loaded)
* Custom `discountPercent` pipe
* Dashboard with order summary and a products list (extras)
* Environment configuration through `.env`
* 17 unit tests across pages, components, services and the pipe

## Tech stack

* **Framework:** Angular 22 (standalone components, zoneless, built-in control flow)
* **Language:** TypeScript 6 with `strict` and `strictTemplates`
* **State:** signals (`signal`, `computed`, `toSignal`) and RxJS
* **HTTP:** `HttpClient`, only inside services
* **Forms:** typed reactive forms
* **Styling:** Tailwind CSS 4
* **Testing:** Vitest, jsdom and `HttpTestingController`
* **Environment:** `.env` with a generated TypeScript configuration file
* **CI:** GitHub Actions

## Architecture

Feature-first architecture. Each feature groups its pages, components, models,
services and routes:

```text
src/app/
├── core/
│   ├── config/              # environment and application configuration
│   ├── layout/              # shell: navbar, sidebar, footer
│   └── services/            # app-wide services
│
├── features/
│   ├── dashboard/
│   │   ├── pages/           # dashboard views
│   │   └── dashboard-routes.ts
│   │
│   ├── orders/
│   │   ├── components/      # order card, filters and items (presentational)
│   │   ├── models/          # Order, OrderProduct, OrdersResponse
│   │   ├── pages/           # orders list (container) and order detail
│   │   ├── services/        # OrdersService (only place that uses HttpClient)
│   │   └── orders.routes.ts
│   │
│   └── products/
│       ├── components/
│       ├── models/
│       ├── pages/
│       ├── services/
│       └── products-routes.ts
│
└── shared/                  # LoadState, toLoadState, pipe, loading/error components
```

Each feature is organized by responsibility:

* **pages:** main views. The orders list is the container: it owns data and filter state.
* **components:** presentational pieces specific to a feature.
* **models:** TypeScript interfaces that type the API data. There is no `any`.
* **services:** the only layer that talks to the API.
* **routes:** each feature defines its own routes and is lazy loaded.
* **spec.ts:** unit tests next to the code they cover.

### Design decisions

* **Logic vs presentation.** `OrdersService` (`providedIn: 'root'`) wraps
  `HttpClient` and returns typed observables. `OrdersPageComponent` (container)
  consumes it. `OrderCardComponent` (presentational) receives data with
  `input.required()`, emits `viewDetail` with `output()`, and injects nothing.
* **Loading and error states.** `LoadState<T>` is a discriminated union
  (`loading | error | success`) and `toLoadState()` is an RxJS operator that
  maps any request into it, so every page handles the three states the same way.
* **No memory leaks.** Production code has no manual `subscribe()`. Streams are
  consumed with `toSignal`, `toObservable` and `outputFromObservable`, which are
  cleaned up with the component.
* **Reactive filter.** A typed `FormGroup` of `FormControl`s emits the filter
  values. The page stores them in a `signal` and derives the visible list with
  `computed`.
* **Change detection.** `OnPush` on every component, except the root component.
* **Routing.** The `:id` route param is bound directly to an `input()` through
  `withComponentInputBinding()`.
* **Path aliases:** `@core/*`, `@shared/*`, `@features/*`.

## Angular ↔ Flutter parallels

| Angular | Flutter (the other app in this repo) |
|---|---|
| `OrdersService` | Repository (`ProductsRepository` and its datasource) |
| `HttpClient` | `dio` |
| `signal` / `Observable` / `toSignal` | Riverpod provider (`ref.watch`) |
| `LoadState<T>` + `toLoadState()` | `AsyncValue` (`loading` / `error` / `data`) |
| `computed()` (filtered list) | Derived provider / `select` |
| Presentational component (`OrderCard`) | Stateless widget |
| `input()` | Widget constructor parameters |
| `output()` | Callbacks (`VoidCallback` / `ValueChanged<T>`) |
| Container component (`OrdersPage`) | Screen that watches providers |
| `FormControl` | `TextEditingController` |
| Router + `withComponentInputBinding()` | `go_router` with path parameters |
| `toSignal` / `outputFromObservable` auto-cleanup | `autoDispose` / `ref.onDispose` |
| `providedIn: 'root'` | `keepAlive` provider |
| Test with `HttpTestingController` / mocked service | Test with a fake repository through `overrides` |

In short: the service plays the role of the repository, signals and observables
play the role of providers, and a presentational component is a stateless widget
that gets data in and sends events out.

## Getting started

### Requirements

* Node.js 22 or newer
* npm 11+
* Angular CLI 22

### Setup

```bash
# 1. Create your local environment file
cp .env.template .env      # Windows PowerShell: Copy-Item .env.template .env

# 2. Install dependencies
npm install

# 3. Start the development server
npm start
```

Open `http://localhost:4200/`.

## Environment configuration

Unlike the Flutter app, Angular does not read `.env` at runtime: browser bundles
are public. A small script turns `.env` into a TypeScript file before the app
runs, builds or tests.

```bash
npm run env
```

It reads `.env` when available, or `.env.template` as a fallback, and generates:

```text
src/app/core/config/env.generated.ts
```

`npm start`, `npm run build` and `npm test` run it automatically. If you call
`ng serve`, `ng build` or `ng test` directly, run `npm run env` first.

The generated file and `.env` are ignored by Git. The main variable is:

```env
API_URL=https://dummyjson.com
```

Never put secrets here: anything in the bundle is visible to users. The
DummyJSON API needs no key.

## Testing

```bash
npm test                    # watch mode
npm test -- --watch=false   # single run, as in CI
```

17 tests across 9 files:

* **`OrdersService`:** `HttpTestingController` checks the GET request, the
  mapping to the `carts` array, `/carts/:id` and error propagation.
* **`OrderCardComponent`:** renders the order data and emits `viewDetail` on click.
* **`OrdersPageComponent`:** loading, error, one card per order, and filtering by
  minimum total (service mocked).
* **`OrderDetailComponent`:** loading, detail and error states.
* **`DiscountPercentPipe`**, plus smoke tests for other pages and components.

## Build

```bash
npm run build
```

The build also generates the environment file first. Output goes to
`dist/angular_app/`.

## Continuous integration

A GitHub Actions workflow (`.github/workflows/angular-ci.yml`) runs when changes
that affect the Angular app are pushed or proposed through a pull request.

The workflow:

1. Checks out the repository.
2. Configures Node.js 22.
3. Installs dependencies with `npm ci`.
4. Creates `.env` from `.env.template`.
5. Runs the unit tests.
6. Builds the Angular application.
