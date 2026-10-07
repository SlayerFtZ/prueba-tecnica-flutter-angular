
# Prueba técnica — Flutter (Riverpod) + Angular

![CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/ci.yml/badge.svg)

- [Flutter app](./flutter_app)
- [Angular app](./angular_app)
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
Arquitectura **feature-first** con tres capas por feature (`product`, `cart`, `home`), más `config`, `core` y `shared` para lo transversal.
- **domain:** entidades inmutables y contratos (`ProductsRepository`, `ProductsDatasource`, `CartRepository`). No conoce `dio`, `shared_preferences` ni widgets; solo usa `foundation` de Flutter para `@immutable`.
- **infrastructure:** modelos con `fromJson`, mappers modelo → entidad e implementaciones de datasource y repositorio (`dio` para el catálogo, `shared_preferences` para el carrito).
- **presentation:** pantallas, widgets y providers de Riverpod. La UI nunca habla con la infraestructura: solo lee providers.

**Inyección de dependencias con Riverpod.** Las dependencias se exponen con `@riverpod` (`riverpod_generator`) siguiendo la cadena `dio → datasource → repository`, y cada eslabón se publica por su **interfaz**, no por su implementación. Por eso en los tests se reemplaza el repositorio con un fake mediante `overrides`, sin red ni mocks de `dio`.

**Estado.** Notifiers para estado con lógica (búsqueda con debounce y paginación, carrito persistido) y providers `family` para lo que depende de un parámetro (detalle por `id`, cantidad por producto). Los providers de larga vida (`dio`, repositorios, carrito) usan `keepAlive`; el resto se libera automáticamente.

**Errores.** Los fallos se modelan con tipos `Failure` en `core/error`, y la UI muestra su mensaje sin depender de excepciones concretas de la capa de datos.

## Pendiente / qué mejoraría con más tiempo

# Flutter
Huviera implementado auth con zitadel para gestion de acceso de seguridad
Implementacion con stripe para pasarela de pago simulado coon tarjetas de pruebas (444 444 444 444)
Agregue la dependecia y empeze la estrcutra para implementar traduccion de idioma utilziando gettext
Mejora de uix para la carga de las imagenes como por ejemplo ponerles un spinner de carga y el cache 
Crear el splash principa con logo y nombre de la aplicacion , y su launcher
Mejorar el thema oscuro
Implementar otra libreria de mensajes de notifiacion y no usas el snackbar
Implementar lottie para animaciones
Implementar la funcionalidad de compartir contenido por redes o whatapp
# Angular