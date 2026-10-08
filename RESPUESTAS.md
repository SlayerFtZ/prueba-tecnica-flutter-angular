# Parte 1 — Preguntas conceptuales (15 %)
Instrucción: Responder con frases propias y, cuando aplique, un ejemplo corto de código. Extensión sugerida: 3 a 6 líneas por pregunta.

# Dart y Flutter

# 1. ¿Qué diferencia hay entre final y const en Dart? ¿Por qué importa usar const en constructores de widgets?
final significa que una variable solo puede recibir un valor una vez, pero ese valor puede conocerse en tiempo de ejecución.
const indica que el valor es una constante conocida en tiempo de compilación.
En widgets, usar const permite reutilizar instancias constantes y ayuda a Flutter a evitar trabajo innecesario al reconstruir la interfaz.

final now = DateTime.now();
const padding = EdgeInsets.all(16);
const Text('Hola');

# 2. Explica el null safety de Dart. ¿Cuándo usarías ?, !, ?? y late? ¿Por qué abusar de ! es una mala práctica?

El null safety evita que una variable pueda ser null si su tipo no lo permite; String? sí permite null.
Uso ?. para acceder de forma segura, ?? para establecer un valor por defecto y late cuando sé que inicializaré una variable antes de usarla.
! indica que afirmo que un valor no es nulo; abusar de él es mala práctica porque puede provocar una excepción en ejecución.

String? name;
print(name?.length ?? 0);

# 3. ¿Cuál es la diferencia entre StatelessWidget y StatefulWidget? ¿Qué aportan ConsumerWidget y ConsumerStatefulWidget?

Un StatelessWidget no mantiene un estado mutable propio, mientras que un StatefulWidget utiliza un objeto State para manejar datos y ciclo de vida.
ConsumerWidget permite acceder a providers de Riverpod mediante WidgetRef.
ConsumerStatefulWidget combina el estado de un StatefulWidget con el acceso a Riverpod mediante ref.

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Text('${cart.length} productos');
  }
}

# 4. ¿Qué es un Future y qué es un Stream? Da un caso de uso real de cada uno.

Un Future representa un único resultado que llegará posteriormente, por ejemplo una petición HTTP para obtener el detalle de un producto.
Un Stream representa una secuencia de valores que pueden llegar durante un periodo de tiempo.
Un caso real sería usar un Stream para recibir actualizaciones continuas mediante un WebSocket.

final product = await dio.get('/products/1'); // Future
stream.listen((event) => print(event));       // Stream

# 5. ¿Por qué es preferible extraer un widget a una clase propia en lugar de un método _buildAlgo() que retorna un Widget?

Una clase propia tiene su propio Element y BuildContext, puede ser const y permite aislar mejor una parte de la interfaz.
También facilita reutilizar y probar ese componente de forma independiente.
Un método _buildAlgo() solo organiza el código, pero se vuelve a ejecutar cuando se reconstruye el widget padre.

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) => Text('\$$price');
}

Riverpod

# 6. ¿Qué problema resuelve Riverpod frente a setState o frente a Provider (el paquete)?

setState es útil para estado local, pero compartir ese estado puede obligar a pasar datos por diferentes widgets.
Riverpod permite declarar el estado y sus dependencias mediante providers fuera del árbol de widgets.
Además, facilita manejar estado asíncrono, dependencias y pruebas sin depender directamente de BuildContext.

# 7. Explica la diferencia entre ref.watch, ref.read y ref.listen. ¿Dónde es incorrecto usar ref.read?

ref.watch observa un provider y hace que la UI se actualice cuando cambia, por lo que es apropiado en build.
ref.read obtiene el valor sin suscribirse y suele utilizarse en callbacks como onPressed.
ref.listen permite reaccionar a cambios para realizar efectos secundarios. Es incorrecto usar ref.read en build cuando la UI necesita reaccionar a cambios.

final items = ref.watch(cartProvider);

onPressed: () => ref.read(cartProvider.notifier).clear();

ref.listen(cartProvider, (prev, next) => showSnack(context));

# 8. ¿Cuándo usarías un Provider, un FutureProvider, un Notifier y un AsyncNotifier?

Usaría Provider para exponer valores síncronos de solo lectura, como un repositorio.
FutureProvider es útil para obtener un dato asíncrono que principalmente se consulta.
Notifier sirve para estado síncrono que cambia mediante métodos, mientras que AsyncNotifier sirve para estado modificable que también necesita operaciones asíncronas.

# 9. ¿Qué hace el modificador autoDispose y qué problema evita? ¿Y family?

autoDispose permite destruir el estado de un provider cuando ya no tiene consumidores, evitando conservar datos o recursos que ya no se necesitan.
Esto puede ayudar a evitar estados obsoletos y consumo innecesario de memoria.
family permite crear instancias de un mismo provider usando un parámetro, por ejemplo un ID de producto.

@riverpod
Future<Product> productDetail(Ref ref, int id) =>
    ref.watch(productsRepositoryProvider).getById(id);

# 10. ¿Cómo manejas los estados de carga, error y datos con AsyncValue? Escribe un ejemplo con .when o pattern matching.

AsyncValue permite representar en un solo tipo los estados de carga, error y datos de una operación asíncrona.
Con .when puedo indicar qué debe mostrar la interfaz en cada estado.
Esto evita manejar varias variables separadas para controlar la carga y los errores.

final products = ref.watch(productsProvider);

return products.when(
  loading: () => const CircularProgressIndicator(),
  error: (e, _) => Text('Error: $e'),
  data: (items) => ProductList(items: items),
);

#  11. ¿Cómo sobrescribirías un provider en un test para inyectar un repositorio falso?

Usaría overrides dentro de un ProviderScope para reemplazar el repositorio real por uno falso.
Así el test no depende de la API, de la red o de datos externos.
El repositorio falso puede devolver datos controlados para probar diferentes escenarios.

ProviderScope(
  overrides: [
    productsRepositoryProvider
        .overrideWithValue(FakeProductsRepository()),
  ],
  child: const MyApp(),
);

Angular

# 12. ¿Qué diferencia hay entre un componente standalone y uno declarado en un NgModule?

Un componente standalone declara directamente sus dependencias mediante imports y no necesita pertenecer a un NgModule.
En el enfoque tradicional, el componente se declara dentro de un NgModule, que administra sus declaraciones e imports.
Standalone reduce código repetitivo y hace más claro qué dependencias necesita cada componente.

@Component({
  selector: 'app-order-card',
  imports: [CurrencyPipe],
  templateUrl: './order-card.html',
})
export class OrderCardComponent {}

# 13. Explica la diferencia entre un Observable (RxJS) y un Signal. ¿Cuándo preferirías cada uno?

Un Observable representa un flujo de eventos y permite usar operadores de RxJS como switchMap o debounceTime.
Un Signal representa un valor reactivo actual que Angular puede rastrear directamente.
Preferiría signals para el estado de la interfaz y observables para flujos asíncronos, eventos o procesos que requieren operadores de RxJS.

const filters = signal({ minTotal: null });
const visible = computed(() =>
  orders().filter(o => o.total >= (filters().minTotal ?? 0))
);

# 14. ¿Para qué sirven @Input() / input() y @Output() / output()? ¿Cómo se comunican dos componentes hermanos?

input() permite que un componente padre envíe datos a un hijo, mientras que output() permite que el hijo envíe eventos al padre.
Dos componentes hermanos normalmente se comunican mediante su padre común.
El padre recibe el evento de un hermano y pasa el dato al otro mediante un input, o también puede utilizarse un servicio compartido.

readonly order = input.required<Order>();
readonly viewDetail = output<number>();

# 15. ¿Qué es la inyección de dependencias en Angular y para qué sirve providedIn: 'root'?

La inyección de dependencias permite que una clase reciba los servicios que necesita sin tener que crearlos directamente.
Esto reduce el acoplamiento y facilita sustituir dependencias durante las pruebas.
providedIn: 'root' registra el servicio en el inyector principal y normalmente permite compartir una misma instancia en toda la aplicación.

@Injectable({ providedIn: 'root' })
export class OrdersService {
  private readonly http = inject(HttpClient);
}

# 16. ¿Por qué hay que preocuparse por las suscripciones a Observables? Menciona dos formas de evitar fugas de memoria.

Una suscripción que permanece activa después de destruir un componente puede seguir ejecutando código y mantener recursos innecesariamente.
Una forma de evitarlo es usar async pipe o toSignal, que gestionan la limpieza automáticamente.
Otra opción es cancelar la suscripción explícitamente con takeUntilDestroyed().

data$.pipe(takeUntilDestroyed(this.destroyRef)).subscribe(...);
state = toSignal(this.service.getOrders());

Prueba técnica (para candidatos)

Código limpio y buenas prácticas

# 17. Explica con tus palabras el principio de responsabilidad única (SRP) y cómo lo aplicarías en una app Flutter.

El principio de responsabilidad única indica que una clase debe tener una sola razón principal para cambiar.
En Flutter, separaría la UI, el manejo del estado y el acceso a los datos en componentes diferentes.
Por ejemplo, un widget debería mostrar productos, mientras que un Notifier maneja el estado y un repositorio se encarga de obtener los datos.

# 18. ¿Por qué separar la app en capas (presentación, dominio, datos)? ¿Qué va en cada una?

Separar en capas permite que los cambios tengan un impacto menor y facilita probar cada parte por separado.
Presentación: pantallas, widgets y estado de la UI. Dominio: entidades y contratos de repositorios.
Datos: modelos, mappers, datasources e implementaciones de repositorios.
Así, la UI no necesita conocer directamente detalles de la API o del almacenamiento.

# 19. ¿Qué diferencia hay entre una prueba unitaria, una de widget y una de integración?

Una prueba unitaria comprueba una función o clase de forma aislada y normalmente es rápida.
Una prueba de widget monta un widget, permite interactuar con él y verifica lo que muestra la interfaz.
Una prueba de integración ejecuta la aplicación completa en un emulador o dispositivo y valida un flujo más cercano al uso real.

# 20. Menciona tres convenciones que sigues al hacer commits y abrir un pull request.

Hacer commits pequeños y usar mensajes claros, por ejemplo feat: agregar filtro de pedidos o fix: corregir carga de productos.

Crear un pull request enfocado en un solo cambio, explicando qué se modificó y cómo probarlo.

Trabajar en una rama descriptiva y revisar que las pruebas y el CI pasen antes de solicitar la revisión.

Parte 4 — Code review

Fragmento A — Flutter / Riverpod

Resumen: el código tiene un bug grave (una petición HTTP dentro de build que se repite en bucle) y rompe la arquitectura (la UI llama a http), el estado (muta la lista) y el uso de Riverpod (ref.read en build).

#

# Qué está mal

# Por qué importa

# Cómo lo corregiría

# 1
La petición http.get está dentro de build() y llama a setState
build se ejecuta en cada redibujado. setState provoca otro build, que lanza otra petición: un bucle infinito de peticiones y reconstrucciones
Mover la carga a un FutureProvider o AsyncNotifier. build solo debe describir la UI
# 2
La UI usa http directamente y la URL está escrita en el widget
Rompe la separación por capas y dificulta las pruebas sin red
Crear un repositorio con una interfaz e inyectarlo mediante un provider. La URL debe estar fuera del widget
# 3
ref.read(cartProvider) dentro de build
read no se suscribe, por lo que el contador del AppBar no se actualiza cuando cambia el carrito
Usar ref.watch en build, preferiblemente con select cuando solo se necesita una parte del estado
# 4
ref.read(cartProvider).add(p) muta la lista en sitio
Se mantiene el mismo objeto y el provider puede no notificar correctamente el cambio
Mantener el estado inmutable: state = [...state, product] dentro de un Notifier
# 5
var cartProvider = StateProvider<List<Map>>
var permite reasignar el provider, Map no tiene tipos y se mezcla la lógica con el estado
Usar final, un modelo Product y un NotifierProvider con métodos como add y remove
# 6
Datos sin tipo: List data, p['title'], jsonDecode directo
Los errores en claves o tipos aparecen en ejecución y no hay buen autocompletado
Crear un modelo tipado con Product.fromJson
# 7
Estado de negocio con setState y bandera loading
Mezcla la UI con la lógica y no representa claramente error, lista vacía o reintento
Usar AsyncValue y manejar loading, error y data
# 8
No hay manejo de errores ni se revisa statusCode
Una falla de red puede dejar un estado incorrecto o producir una excepción sin tratar
Validar la respuesta y lanzar un error controlado para mostrarlo en la UI
# 9
setState después de una operación asíncrona sin comprobar mounted
Si el widget fue destruido antes de terminar la petición, puede producir un error
Al usar providers se evita este problema; en un State tradicional, comprobar mounted
# 10
CircularProgressIndicator() está suelto, sin Scaffold ni Center
La pantalla de carga no mantiene correctamente la estructura visual
Mantener el Scaffold y mostrar el indicador dentro de Center
# 11
ListView(children: data.map(...).toList())
Construye todos los elementos aunque no sean visibles
Usar ListView.builder para construir los elementos bajo demanda
# 12
prnt('agregado')
Es código de depuración que no debería quedar como feedback de producción
Eliminarlo o mostrar feedback visual apropiado
# 13
Concatenación de cadenas
Es menos legible y puede provocar errores de formato
Usar interpolación, por ejemplo 'Productos ($count)'
# 14
Sin const ni super.key en el constructor
Se pierden oportunidades de optimización y se incumplen buenas prácticas de Flutter
Usar constructores const con super.key
# 15
El carrito guarda mapas crudos y no tiene cantidad
Los productos duplicados se repiten y no se puede calcular fácilmente un total
Usar un modelo CartItem con product y quantity

# Reescritura del fragmento A

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// ---------- dominio ----------

@immutable
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
  });

  final int id;
  final String title;
  final double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        price: (json['price'] as num).toDouble(),
      );
}

abstract interface class ProductsRepository {
  Future<List<Product>> fetchProducts();
}

class ProductsFailure implements Exception {
  const ProductsFailure(this.message);

  final String message;
}

// ---------- datos ----------

class HttpProductsRepository implements ProductsRepository {
  HttpProductsRepository(this._client);

  final http.Client _client;

  static final _productsUri =
      Uri.parse('https://dummyjson.com/products');

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await _client.get(_productsUri);

    if (response.statusCode != 200) {
      throw const ProductsFailure(
        'No se pudieron cargar los productos.',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    return (body['products'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList();
  }
}

// ---------- providers ----------

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final productsRepositoryProvider = Provider<ProductsRepository>(
  (ref) => HttpProductsRepository(ref.watch(httpClientProvider)),
);

final productsProvider = FutureProvider<List<Product>>(
  (ref) => ref.watch(productsRepositoryProvider).fetchProducts(),
);

class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => const [];

  void add(Product product) {
    state = [...state, product];
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<Product>>(CartNotifier.new);

// ---------- presentación ----------

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartCount =
        ref.watch(cartProvider.select((cart) => cart.length));

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos ($cartCount)'),
      ),
      body: products.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'No se pudieron cargar los productos.',
              ),
              TextButton(
                onPressed: () => ref.invalidate(productsProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (items) => items.isEmpty
            ? const Center(
                child: Text('No hay productos.'),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    ProductTile(product: items[index]),
              ),
      ),
    );
  }
}

class ProductTile extends ConsumerWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text('\$${product.price}'),
      onTap: () => ref.read(cartProvider.notifier).add(product),
    );
  }
}

# Fragmento B — Angular
Resumen: el componente hace polling con un setInterval que nunca se limpia, llama a HttpClient directamente, usa any y no muestra estados de carga ni de error.
# Qué está mal
# Por qué importa
# Cómo lo corregiría
# 1
setInterval en ngOnInit sin limpiarl
Sigue ejecutándose después de destruir el componente y puede producir fugas y peticiones innecesari
Usar timer de RxJS junto con takeUntilDestroyed
# 2
subscribe() sin limpiar dentro del interval
Las suscripciones pueden acumularse y las peticiones pueden solaparse
Usar switchMap para controlar la petición anterior y gestionar la suscripción
# 3
orders: any y (r: any)
Se pierde el tipado y los errores aparecen durante la ejecució
Crear interfaces como Order y OrdersResponse
# 4
El componente inyecta HttpClient directamente
Mezcla presentación con acceso a datos y dificulta las pruebas
Crear un OrdersService que encapsule las peticiones
# 5
*ngFor en un standalone sin importar NgFo
Puede provocar problemas de compilación y además no usa el control flow moderno
Usar @for con track
# 6
No hay estados de carga ni error
El usuario no sabe qué ocurre si la petición está cargando o falla
Crear un estado de carga, error y datos y mostrarlo en el template
# 7
URL y 5000 ms escritos directamente
Son valores difíciles de cambiar y probar
Usar constantes o configuración de environment
# 8
Sin una estrategia clara de detección de cambio
Puede producir actualizaciones innecesarias y complica trabajar con una app reactiva
Usar OnPush y signals para el estado mostrado
# 9
Constructor para la inyección y poca información en la vista
El código puede ser más directo y la información mostrada es limitada
Usar inject() y pipes como currenc
# 10
Polling cada 5 segundos sin justificarlo
Consume red y batería aunque quizá no sea necesari
Confirmar que el polling sea necesario y pausarlo cuando corresponda

# Corrección sugerida del fragmento B

@Injectable({ providedIn: 'root' })
export class OrdersService {
  private readonly http = inject(HttpClient);

  getOrders(): Observable<Order[]> {
    return this.http
      .get<OrdersResponse>(`${environment.apiUrl}/carts`)
      .pipe(map((res) => res.carts));
  }
}

const REFRESH_MS = 5000;

@Component({
  selector: 'app-orders',
  imports: [CurrencyPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    @if (state().status === 'loading') {
      <p>Cargando…</p>
    } @else if (state().status === 'error') {
      <p role="alert">No se pudieron cargar los pedidos.</p>
    } @else {
      @for (o of orders(); track o.id) {
        <div>{{ o.total | currency }}</div>
      }
    }
  `,
})
export class OrdersComponent {
  private readonly service = inject(OrdersService);

  protected readonly state = toSignal(
    timer(0, REFRESH_MS).pipe(
      switchMap(() =>
        this.service.getOrders().pipe(
          toLoadState('Error')
        )
      ),
    ),
    {
      initialValue: { status: 'loading' } as LoadState<Order[]>,
    },
  );

  protected readonly orders = computed(() => {
    const state = this.state();

    return state.status === 'success'
      ? state.data
      : [];
  });
}