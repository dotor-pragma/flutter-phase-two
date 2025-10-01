# Fase 2

Aplicacion Flutter que consume la Fake Store API para mostrar un catalogo de productos en formato de tarjetas. El proyecto ejemplifica una arquitectura por capas (presentacion, dominio e infraestructura) apoyada en Provider para el manejo de estado y Dio para el acceso HTTP, manteniendo responsabilidades separadas y un flujo de datos testeable.

## Tabla de contenidos
- [Caracteristicas principales](#caracteristicas-principales)
- [Arquitectura y flujo](#arquitectura-y-flujo)
- [Estructura de carpetas](#estructura-de-carpetas)
- [Configuracion previa](#configuracion-previa)
- [Ejecucion local](#ejecucion-local)
- [Comandos utiles](#comandos-utiles)
- [Personalizacion](#personalizacion)
- [Pendientes y oportunidades](#pendientes-y-oportunidades)

## Caracteristicas principales
- Consume `/products` desde la Fake Store API (o cualquier backend compatible configurado por `.env`).
- Presenta un listado con imagen, categoria, precio y calificacion de cada producto.
- Gestion del estado con `Provider` y notificaciones reactivas mediante `ChangeNotifier`.
- Manejo de errores a traves del tipo `Failure`, diferenciando fallas HTTP y excepciones de parseo.
- Inyeccion sencilla de dependencias para cambiar entre origenes de datos remotos o locales (mock).

## Arquitectura y flujo
```
MainApp
 └─> MultiProvider
      └─ StoreViewModel (ChangeNotifier)
          └─ GetAllProductsUseCase (dominio)
              └─ ProductRepository (dominio)
                  └─ ProductDatasource (infraestructura)
                       └─ DioClient (HTTP) o LocalProductsDatasource
```
- **Presentacion:** Widgets en `features/store/presentation` consumen el `StoreViewModel`, renderizan estados de carga, exito o error, y delegan estilos a `AppTheme`.
- **Dominio:** Define contratos (`ProductRepository`, `ProductDatasource`), entidades puras (`ProductEntity`) y casos de uso (`GetAllProductsUseCase`).
- **Infraestructura:** Implementa contratos usando `Dio` (`RemoteProductsDatasourceImpl`) o datos simulados (`LocalProductsDatasourceImpl`). `ProductModel` traduce JSON a entidades de dominio.
- **Core:** Configura `DioClient` con `ApiConfig`, centraliza constantes y el modelo `Failure`.

## Estructura de carpetas
```
lib/
├─ core/                    # Configuracion comun (network, errores)
├─ config/theme/            # Definicion de temas
├─ features/store/
│   ├─ domain/              # Entidades, contratos y casos de uso
│   ├─ infrastructure/      # Models, datasources y repositorios concretos
│   └─ presentation/        # ViewModel, pantallas y widgets
└─ shared/data/             # Datos locales de apoyo
```

## Configuracion previa
1. Instala Flutter (>= 3.24.x) y configura un dispositivo/emulador.
2. Duplica el archivo `.env.example` si existe, o crea `.env` en la raiz con al menos:
   ```env
   BASE_URL=https://fakestoreapi.com
   ```
3. Ejecuta `flutter pub get` para descargar dependencias.

## Ejecucion local
```bash
flutter run
```
El comando anterior inicializa la aplicacion, carga las variables definidas en `.env` mediante `flutter_dotenv` y consulta el endpoint configurado. Si prefieres no depender de la red, reemplaza la instancia del datasource en `main.dart` por `LocalProductsDatasourceImpl`.

## Comandos utiles
- `flutter pub get` — sincroniza dependencias.
- `flutter analyze` — valida reglas estaticas (usa `flutter_lints`).

## Personalizacion
- **Tema:** modifica `AppTheme` (`lib/config/theme/app_theme.dart`) para aplicar paletas, tipografias o esquemas oscuros.
- **Endpoints:** ajusta `BASE_URL` en `.env` o agrega nuevas rutas en `ApiConfig` para reutilizarlas en otros casos de uso.
- **Nuevas features:** sigue el patron de capas existente: agrega entidades y casos de uso en dominio, implementaciones en infraestructura y widgets/ViewModels en presentacion.

