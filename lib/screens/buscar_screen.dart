import 'package:flutter/material.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({super.key});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  final _controller = TextEditingController();

  static const _todos = [
    'La Guajira Sabor',
    'La Brasa Roja',
    'Sushi Express',
    'Pizza Nonna',
    'Verde Bowl',
    'El Corral Criollo',
  ];

  List<String> get _filtrados => _todos
      .where((r) => r.toLowerCase().contains(_controller.text.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buscar', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Restaurantes o platos...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _filtrados.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.restaurant),
                title: Text(_filtrados[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
