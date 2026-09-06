import 'package:flutter/material.dart';

class Categoria {
  final String nombre;
  final IconData icono;
  const Categoria(this.nombre, this.icono);
}

class Restaurante {
  final String nombre;
  final String tipo;
  final String tiempo;
  final double rating;
  const Restaurante(this.nombre, this.tipo, this.tiempo, this.rating);
}

const _categorias = [
  Categoria('Arepas', Icons.bakery_dining),
  Categoria('Sancocho', Icons.soup_kitchen),
  Categoria('Mariscos', Icons.set_meal),
  Categoria('Pollo', Icons.egg_alt),
  Categoria('Jugos', Icons.local_drink),
  Categoria('Postres', Icons.icecream),
];

const _restaurantes = [
  Restaurante('La Guajira Sabor', 'Comida Típica Vallenata', '25-35 min', 4.8),
  Restaurante('La Brasa Roja', 'Comida rápida', '25-35 min', 4.5),
  Restaurante('Sushi Express', 'Japonesa', '30-40 min', 4.6),
  Restaurante('Pizza Nonna', 'Italiana', '20-30 min', 4.7),
];

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: colors.primary, size: 18),
              const SizedBox(width: 4),
              const Expanded(
                child: Text('Entregando en\nValledupar, Cesar',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Busca restaurantes o platos...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OFERTA DE HOY',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 4),
                Text('30% off en tu primer pedido',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Usar código: VALLE30',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Categorías', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categorias.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final c = _categorias[i];
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: colors.primary.withValues(alpha: 0.15),
                      child: Icon(c.icono, color: colors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(c.nombre, style: const TextStyle(fontSize: 11)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Restaurantes', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...(_restaurantes.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: colors.primary.withValues(alpha: 0.15),
                          child: Icon(Icons.restaurant, color: colors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.nombre,
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(r.tipo, style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('⭐ ${r.rating}  ·  ${r.tiempo}',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
        ],
      ),
    );
  }
}
