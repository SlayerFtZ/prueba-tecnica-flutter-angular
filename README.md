# Prueba técnica — Flutter (Riverpod) + Angular

![Flutter CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/ci.yml/badge.svg)

![Angular CI](https://github.com/SlayerFtZ/prueba-tecnica-flutter-angular/actions/workflows/angular-ci.yml/badge.svg)

* [Flutter app](./flutter_app)
* [Angular app](./angular_app)

## Estructura

* `flutter_app/`: app "Mini Catálogo" (Flutter + Riverpod).
* `angular_app/`: módulo "Panel de pedidos" (Angular).

## Entorno y versiones

Probado en Windows 11 con:

| Herramienta               | Versión         |
| ------------------------- | --------------- |
| Flutter                   | 3.47.6 (stable) |
| Dart                      | 3.13.5          |
| flutter_riverpod          | 3.4.3           |
| dio                       | 5.11.1          |
| Node.js                   | 24.20.0         |
| npm                       | 11.19.0         |
| Angular CLI               | 22.2.1          |
| Angular (`@angular/core`) | 22.2.1          |
| TypeScript                | 6.0.3           |

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

* **domain:** entidades inmutables y contratos (`ProductsRepository`, `ProductsDatasource`, `CartRepository`). No conoce `dio`, `shared_preferences` ni widgets; solo usa `foundation` de Flutter para `@immutable`.

* **infrastructure:** modelos con `fromJson`, mappers modelo → entidad e implementaciones de datasource y repositorio (`dio` para el catálogo, `shared_preferences` para el carrito).

* **presentation:** pantallas, widgets y providers de Riverpod. La UI nunca habla con la infraestructura: solo lee providers.

**Inyección de dependencias con Riverpod.** Las dependencias se exponen con `@riverpod` (`riverpod_generator`) siguiendo la cadena `dio → datasource → repository`, y cada eslabón se publica por su **interfaz**, no por su implementación. Por eso en los tests se reemplaza el repositorio con un fake mediante `overrides`, sin red ni mocks de `dio`.

**Estado.** Notifiers para estado con lógica (búsqueda con debounce y paginación, carrito persistido) y providers `family` para lo que depende de un parámetro (detalle por `id`, cantidad por producto). Los providers de larga vida (`dio`, repositorios, carrito) usan `keepAlive`; el resto se libera automáticamente.

**Errores.** Los fallos se modelan con tipos `Failure` en `core/error`, y la UI muestra su mensaje sin depender de excepciones concretas de la capa de datos.

### Angular

La aplicación utiliza una arquitectura **feature-first**, organizando el código por funcionalidades principales: `dashboard`, `orders` y `products`.

Cada funcionalidad mantiene sus propias páginas, componentes, modelos, servicios y configuración de rutas, manteniendo relacionadas las responsabilidades correspondientes a cada área.


* **pages:** contienen las vistas principales de cada funcionalidad.
* **components:** contienen componentes específicos y reutilizables dentro de cada feature.
* **models:** definen las estructuras de datos utilizadas por cada funcionalidad.
* **services:** encapsulan la comunicación y lógica relacionada con los datos.
* **routes:** cada feature mantiene su propia configuración de rutas.
* **spec.ts:** las páginas, componentes y servicios cuentan con pruebas unitarias según corresponda.

Esta organización permite mantener las funcionalidades encapsuladas y facilita la localización, mantenimiento y evolución del código.

Además, el proyecto cuenta con un workflow independiente de GitHub Actions para Angular, encargado de instalar las dependencias, ejecutar las pruebas unitarias y validar la compilación de la aplicación.

## Pendiente / qué mejoraría con más tiempo

### Flutter

* Implementaría autenticación con Zitadel para la gestión de acceso y seguridad.
* Implementaría Stripe como pasarela de pago simulada utilizando tarjetas de prueba.
* Se agregó la dependencia y se inició la estructura para implementar traducción de idioma utilizando Gettext.
* Mejoraría la UX durante la carga de imágenes, por ejemplo, agregando un spinner de carga y caché.
* Crearía el splash principal con el logo y nombre de la aplicación, además de su launcher.
* Mejoraría el tema oscuro.
* Implementaría otra librería para mensajes de notificación en lugar de utilizar `SnackBar`.
* Implementaría Lottie para animaciones.
* Implementaría la funcionalidad para compartir contenido mediante redes sociales o WhatsApp.

### Angular

* Mejoraría la cobertura y profundidad de las pruebas unitarias en los componentes y servicios principales.
* Incorporaría una estrategia más completa para el manejo y visualización de errores provenientes de la API.
* Mejoraría los estados de carga y las transiciones de la interfaz.
* Implementaría una configuración de entornos más completa para desarrollo, pruebas y producción.
* Ampliaría el pipeline de CI con validaciones adicionales antes del despliegue.
