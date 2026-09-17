import 'package:flutter/material.dart';

import '../models/restaurante_model.dart';
import 'food_detail_screen.dart';
import '../components/network_image_with_placeholder.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({required this.restaurant, super.key});

  final RestauranteModel restaurant;

  @override
  Widget build(BuildContext context) {
    final List<PratoModel> pratos = restaurant.pratos;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                    child: NetworkImageWithPlaceholder(
                      restaurant.bannerImage,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            restaurant.nome,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1D3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.star, size: 16, color: Color(0xFFF1A124)),
                              const SizedBox(width: 4),
                              Text('${restaurant.rating}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      restaurant.endereco,
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.schedule, size: 18, color: Color(0xFFC92121)),
                        const SizedBox(width: 8),
                        Text(restaurant.tempoEntrega),
                        const SizedBox(width: 16),
                        const Icon(Icons.restaurant, size: 18, color: Color(0xFFC92121)),
                        const SizedBox(width: 8),
                        Text(restaurant.categoria),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sobre Nós',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      restaurant.descricao,
                      style: const TextStyle(color: Colors.black87, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tipo de Cozinha',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(restaurant.categoria),
                      backgroundColor: const Color(0xFFFFF1D3),
                      labelStyle: const TextStyle(color: Color(0xFFC92121), fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Cardápio',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
              if (pratos.isEmpty)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Text(
                      'Nenhum prato cadastrado',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final prato = pratos[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailScreen(prato: prato),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: NetworkImageWithPlaceholder(
                                  prato.imageUrl,
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      prato.nome,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      prato.descricao,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black54),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'R\$ ${prato.preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Color(0xFFC92121),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: pratos.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
