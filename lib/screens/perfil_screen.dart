import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;

  const PerfilScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Perfil', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Adrian'),
            subtitle: Text('Valledupar, Cesar'),
          ),
          const Divider(height: 32),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Tema oscuro'),
            value: isDark,
            onChanged: onToggleTheme,
          ),
        ],
      ),
    );
  }
}
