import 'package:flutter/material.dart';

import '../models/restaurante_model.dart';
import 'cadastro_screen.dart';
import 'restaurant_detail_screen.dart';
import '../components/network_image_with_placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onSearchRedirect});

  final void Function(String)? onSearchRedirect;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String query = _searchController.text.trim().toLowerCase();
    final List<RestauranteModel> filteredRestaurants = demoRestaurants.where((restaurant) {
      if (query.isEmpty) return true;

      final String restaurantText = '${restaurant.nome} ${restaurant.categoria} ${restaurant.pratos.map((prato) => prato.nome).join(' ')}'.toLowerCase();
      return restaurantText.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFF1A124),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Olá, nome.usuario',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFC92121),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1A124),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const CadastroScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                onSubmitted: (value) {
                  final query = value.trim();
                  if (query.isNotEmpty) {
                    widget.onSearchRedirect?.call(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Buscar restaurantes, pratos...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFC92121)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'DESTAQUES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFC92121),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const <Widget>[
                    _HighlightCard(
                      title: 'Ofertas do dia',
                      subtitle: 'Burger + batata',
                      color: Color(0xFFFFE29C),
                    ),
                    _HighlightCard(
                      title: 'Mais pedidos',
                      subtitle: 'Sushi premium',
                      color: Color(0xFFFFC107),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'RECENTES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFC92121),
                ),
              ),
              const SizedBox(height: 14),
              if (filteredRestaurants.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    'Nenhum resultado encontrado.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                )
              else
                ...filteredRestaurants.map(
                  (restaurant) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          // use reusable network image with placeholder
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: NetworkImageWithPlaceholder(
                              restaurant.bannerImage,
                              width: 88,
                              height: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  restaurant.nome,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.star, size: 16, color: Color(0xFFF1A124)),
                                    const SizedBox(width: 4),
                                    Text('${restaurant.rating}'),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF1D3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        restaurant.categoria,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFC92121),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  restaurant.tempoEntrega,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}