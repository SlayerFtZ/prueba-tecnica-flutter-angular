# Prueba técnica — Flutter (Riverpod) + Angular

## Estructura
- `flutter_app/`: app "Mini Catálogo" (Flutter + Riverpod).
- `angular_app/`: módulo "Panel de pedidos" (Angular).
## Entorno y versiones

Probado en Windows 11 con:

| Herramienta | Versión |
|---|---|
| Flutter | 3.47.6 (stable) |
| Dart | 3.13.5 |
| flutter_riverpod | 3.4.3 |
| dio | 5.11.1 |
| Node.js | 24.20.0 |
| npm | 11.19.0 |
| Angular CLI | 22.2.1 |
| Angular (`@angular/core`) | 22.2.1 |
| TypeScript | 6.0.3 |

## Cómo ejecutar
### Flutter
```bash
cd flutter_app
flutter pub get
flutter run
```

### Angular
```bash
cd angular_app
npm install
npm start
```

## Decisiones de arquitectura
### Flutter
Arquitectura por feature con tres capas. domain contiene entidades puras y contratos (repositorio y datasource), sin depender de Flutter ni de dio. infrastructure contiene los modelos con fromJson, los mappers modelo → entidad y las implementaciones. presentation contiene pantallas, widgets y providers de Riverpod. La UI solo habla con providers, que exponen el repositorio por su interfaz, así que en los tests se sustituye por un fake con overrides.

## Pendiente / qué mejoraría con más tiempo
_Pendiente_