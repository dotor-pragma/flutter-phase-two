# Fase 2

Aplicación de consola en Dart que consulta la Fake Store API y muestra los productos en terminal siguiendo un esquema de arquitectura limpia (presentación, dominio e infraestructura). Se conservaron los casos de uso y repositorios existentes del proyecto Flutter original, pero ahora la salida se realiza únicamente por CLI.

## Características principales
- Consumo de `/products` en Fake Store API apuntando a `https://fakestoreapi.com` por defecto.
- Manejo de errores con el tipo `Failure`, distinguiendo fallos HTTP y excepciones de parseo.
- Separación clara de responsabilidades: casos de uso, repositorios, datasources y capa de presentación para consola.
- Fácil reemplazo del origen de datos por mocks locales o implementaciones adicionales.

## Arquitectura y flujo
```
bin/fase_2.dart
 └─ StoreCliPresenter (presentación CLI)
     └─ GetAllProductsUseCase (dominio)
         └─ ProductRepository (dominio)
             └─ ProductDatasource (infraestructura)
                  └─ DioClient (HTTP)
```
- **Presentación:** `StoreCliPresenter` orquesta la obtención de productos y los imprime en consola.
- **Dominio:** Define contratos (`ProductRepository`, `ProductDatasource`), entidades (`ProductEntity`) y casos de uso (`GetAllProductsUseCase`).
- **Infraestructura:** Implementa los contratos utilizando `Dio` (`RemoteProductsDatasourceImpl`) o datos locales (`LocalProductsDatasourceImpl`). `ProductModel` transforma JSON en entidades de dominio.
- **Core:** Expone utilidades compartidas como `DioClient`, `ApiConfig` y el modelo `Failure`.

## Estructura de carpetas
```
bin/
└─ fase_2.dart           # Punto de entrada de la aplicación de consola
lib/
├─ core/                # Configuración común (network, errores)
├─ domain/              # Entidades, contratos y casos de uso
├─ infrastructure/      # Models, datasources y repositorios concretos
├─ presentation/cli     # Lógica de impresión en consola
└─ shared/data/         # Datos locales de apoyo
```

## Configuración previa
1. Instala el SDK de Dart (>= 3.9.2).
2. Ejecuta `dart pub get` para descargar dependencias.

## Ejecución
```bash
dart run
```
El comando configura `DioClient` con la URL por defecto de Fake Store y solicita el listado de productos. El resultado se imprime en la terminal.

## Comandos útiles
- `dart pub get` — sincroniza dependencias.
- `dart analyze` — valida reglas estáticas (usa `package:lints`).

## Personalización
- **Endpoints:** si necesitas apuntar a otra API, modifica `ApiConfig.baseUrl`.
- **Nuevas features:** agrega nuevos casos de uso en `lib/domain` e implementaciones concretas en `lib/infrastructure`. Puedes crear nuevos presentadores en `lib/presentation/cli` para ampliar la experiencia en terminal.
