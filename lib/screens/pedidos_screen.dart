import 'dart:async';
import 'dart:math';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  AccelerometerEvent? _accel;
  GyroscopeEvent? _gyro;
  StreamSubscription<AccelerometerEvent>? _accelSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  bool _enMovimiento = false;

  final Battery _battery = Battery();
  int? _nivelBateria;
  StreamSubscription<BatteryState>? _bateriaSub;

  String _infoDispositivo = 'Cargando datos del celular del repartidor...';

  static const _umbralAccel = 1.5;
  static const _umbralGyro = 0.5;

  @override
  void initState() {
    super.initState();
    _iniciarSensores();
    _cargarBateria();
    WidgetsBinding.instance.addPostFrameCallback((_) => _cargarDispositivo());
  }

  Future<void> _iniciarSensores() async {
    await Permission.sensors.request();
    _accelSub = accelerometerEventStream().listen((e) {
      _accel = e;
      _actualizarMovimiento();
    });
    _gyroSub = gyroscopeEventStream().listen((e) {
      _gyro = e;
      _actualizarMovimiento();
    });
  }

  void _actualizarMovimiento() {
    final a = _accel;
    final g = _gyro;
    if (a == null || g == null) return;
    final magnitudAccel = sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
    final desviacion = (magnitudAccel - 9.8).abs();
    final magnitudGyro = sqrt(g.x * g.x + g.y * g.y + g.z * g.z);
    final movimiento = desviacion > _umbralAccel || magnitudGyro > _umbralGyro;
    if (mounted && movimiento != _enMovimiento) {
      setState(() => _enMovimiento = movimiento);
    }
  }

  Future<void> _cargarBateria() async {
    final nivel = await _battery.batteryLevel;
    if (mounted) setState(() => _nivelBateria = nivel);
    _bateriaSub = _battery.onBatteryStateChanged.listen((_) => _cargarBateria());
  }

  Future<void> _cargarDispositivo() async {
    final plugin = DeviceInfoPlugin();
    String texto;
    try {
      final platform = Theme.of(context).platform;
      if (platform == TargetPlatform.android) {
        final info = await plugin.androidInfo;
        texto = '${info.manufacturer} ${info.model} · Android ${info.version.release}';
      } else if (platform == TargetPlatform.iOS) {
        final info = await plugin.iosInfo;
        texto = '${info.name} · iOS ${info.systemVersion}';
      } else {
        texto = 'Plataforma no soportada en esta demo.';
      }
    } catch (e) {
      texto = 'No se pudo leer la información del dispositivo.';
    }
    if (mounted) setState(() => _infoDispositivo = texto);
  }

  @override
  void dispose() {
    _accelSub?.cancel();
    _gyroSub?.cancel();
    _bateriaSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pedido en curso', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Card(
            color: _enMovimiento
                ? colors.secondary.withValues(alpha: 0.15)
                : colors.primary.withValues(alpha: 0.15),
            child: ListTile(
              leading: Icon(
                _enMovimiento ? Icons.two_wheeler : Icons.pause_circle,
                color: _enMovimiento ? colors.secondary : colors.primary,
              ),
              title: Text(_enMovimiento ? 'En camino' : 'Detenido'),
              subtitle: const Text('Estado calculado con sensores del celular'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delivery_dining),
              title: const Text('Carlos M. · Moto ABC-123'),
              subtitle: Text(_infoDispositivo),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(
                (_nivelBateria ?? 100) < 20
                    ? Icons.battery_alert
                    : Icons.battery_full,
              ),
              title: Text('Batería del repartidor: ${_nivelBateria ?? '--'}%'),
              subtitle: (_nivelBateria ?? 100) < 20
                  ? const Text('Batería baja')
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
