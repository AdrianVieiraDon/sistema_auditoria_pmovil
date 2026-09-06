# RapidoYa

App de domicilios de comida (estilo Rappi) hecha en Flutter, con layout adaptativo
y tema claro/oscuro basado en tokens de diseño.

## Pantallas

- **Inicio**: ubicación de entrega, buscador, banner de oferta, categorías y
  lista de restaurantes.
- **Buscar**: buscador de restaurantes por nombre.
- **Pedidos**: seguimiento del pedido en curso usando acelerómetro y giroscopio
  reales del celular para detectar si está "En camino" o "Detenido", además de
  la información del repartidor y la batería de su dispositivo.
- **Perfil**: datos del usuario y switch para cambiar entre tema claro y oscuro.

## Diseño adaptativo

La navegación cambia según el ancho de pantalla:

- **< 600dp**: `NavigationBar` inferior.
- **600–840dp**: `NavigationRail` colapsado.
- **> 840dp**: `NavigationRail` extendido.

## Tema

Los colores están definidos como tokens en `lib/theme/app_colors.dart`
(`AppColorsLight` y `AppColorsDark`) y se aplican en `lib/theme/app_theme.dart`
para construir los `ThemeData` claro y oscuro de la app.

## Ejecutar

```
flutter create .
flutter pub get
flutter run
```
