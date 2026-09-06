import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/inicio_screen.dart';
import 'screens/buscar_screen.dart';
import 'screens/pedidos_screen.dart';
import 'screens/perfil_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RapidoYa',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: AdaptiveShell(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

enum _Breakpoint { compact, medium, expanded }

class AdaptiveShell extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;

  const AdaptiveShell({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<AdaptiveShell> createState() => _AdaptiveShellState();
}

class _AdaptiveShellState extends State<AdaptiveShell> {
  int _index = 0;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Inicio'),
    NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
    NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Pedidos'),
    NavigationDestination(icon: Icon(Icons.person_outline), label: 'Perfil'),
  ];

  static const _railDestinations = [
    NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text('Inicio')),
    NavigationRailDestination(icon: Icon(Icons.search), label: Text('Buscar')),
    NavigationRailDestination(icon: Icon(Icons.receipt_long_outlined), label: Text('Pedidos')),
    NavigationRailDestination(icon: Icon(Icons.person_outline), label: Text('Perfil')),
  ];

  _Breakpoint _breakpointFor(double width) {
    if (width < 600) return _Breakpoint.compact;
    if (width < 840) return _Breakpoint.medium;
    return _Breakpoint.expanded;
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const InicioScreen(),
      const BuscarScreen(),
      const PedidosScreen(),
      PerfilScreen(isDark: widget.isDark, onToggleTheme: widget.onToggleTheme),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bp = _breakpointFor(constraints.maxWidth);

        if (bp == _Breakpoint.compact) {
          return Scaffold(
            body: SafeArea(child: screens[_index]),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: _destinations,
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                NavigationRail(
                  extended: bp == _Breakpoint.expanded,
                  selectedIndex: _index,
                  onDestinationSelected: (i) => setState(() => _index = i),
                  destinations: _railDestinations,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: screens[_index]),
              ],
            ),
          ),
        );
      },
    );
  }
}
