# Taller Flutter: consumo de API COVID y notificaciones locales

Aplicación Android desarrollada con Flutter que consulta una API pública de COVID-19, muestra los datos de un país elegido y envía una notificación local con el resumen.

**Autor:** Juan Manuel Bejarano Mendez
**Curso:** Multimedia para moviles 
**Fecha:** 19 de noviembre de 2026

## Descarga del APK

Puedes descargar el APK desde la sección [Releases](../../releases) de este repositorio.

> Reemplaza el enlace anterior por la URL de tu release cuando la publiques.

## Funcionalidades

- Consulta la API pública [disease.sh](https://disease.sh) mediante peticiones HTTP.
- Convierte el JSON de la respuesta en un modelo de Dart (`CovidData`).
- Muestra los datos del país elegido: casos, muertes, recuperados y fecha de actualización.
- Envía una notificación local con el resumen de los datos.
- Maneja estados de carga y errores, con botón para reintentar.

### Ampliaciones realizadas

- **Bandera del país:** se obtiene del campo `countryInfo.flag` de la API y se muestra con `Image.network`.
- **Lista dinámica de países:** el selector se carga desde `https://disease.sh/v3/covid-19/countries`, con una lista de respaldo si la petición falla.
- **Interfaz separada en widgets:** `CountrySelector`, `CovidCard` y `ErrorView`, cada uno en su propio archivo.

## Estructura del proyecto

```
lib/
├── main.dart                     # Estado de la pantalla y llamada a los widgets
├── covid_data.dart               # Modelo de datos
├── covid_api.dart                # Servicio de API (HTTP)
├── notification_service.dart     # Servicio de notificaciones locales
└── widgets/
    ├── country_selector.dart     # Selector de país
    ├── covid_card.dart           # Tarjeta con los datos y botón de notificación
    └── error_view.dart           # Vista de error con botón de reintento
```

## Tecnologías y dependencias

- Flutter 3.22 o superior
- [`http`](https://pub.dev/packages/http) `^1.2.0`
- [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) `^19.0.0`

## Cómo ejecutar el proyecto

1. Clona el repositorio:
   ```
   git clone <URL-del-repositorio>
   cd <carpeta-del-proyecto>
   ```
2. Instala las dependencias:
   ```
   flutter pub get
   ```
3. Conecta un teléfono Android con depuración USB o abre un emulador (API 33 o superior).
4. Ejecuta la app:
   ```
   flutter run
   ```

Para generar el APK:

```
flutter build apk --release
```

El archivo queda en `build/app/outputs/flutter-apk/app-release.apk`.

## Notas

- Los datos de COVID-19 de la API ya no se actualizan como antes, y el campo `updated` puede mostrar una fecha reciente aunque las cifras sean históricas.
- Las notificaciones solo funcionan en Android (no en el navegador).
- En Android 13 o superior, la app pide el permiso de notificaciones al abrirse.

## Capturas de pantalla

<!-- Agrega aquí tus capturas, por ejemplo: -->
<!-- ![Pantalla principal](capturas/principal.png) -->
