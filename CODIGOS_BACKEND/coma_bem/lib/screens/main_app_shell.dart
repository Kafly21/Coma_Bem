import 'package:flutter/material.dart';

import '../models/restaurante_model.dart';
import 'home_screen.dart';
import 'restaurant_detail_screen.dart';
import '../components/botao_customizado.dart';
import '../components/network_image_with_placeholder.dart';

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  late int _currentIndex;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          HomeScreen(
            onSearchRedirect: (query) => setState(() {
              _searchQuery = query;
              _currentIndex = 1;
            }),
          ),
          SearchScreen(initialQuery: _searchQuery),
          const OrdersScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFC92121),
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Opiniões Realizadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.initialQuery});

  final String? initialQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RestauranteModel> _filter(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return demoRestaurants;
    return demoRestaurants.where((r) {
      final text = '${r.nome} ${r.categoria} ${r.pratos.map((p) => p.nome).join(' ')}'.toLowerCase();
      return text.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filter(_searchController.text);

    return Scaffold(
      backgroundColor: const Color(0xFFC92121),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC92121),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Buscar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Buscar restaurantes, pratos...',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF9A1F1F),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.search_off_rounded, size: 56, color: Colors.white70),
                          SizedBox(height: 8),
                          Text('Nenhum resultado encontrado', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, index) {
                        final r = results[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: NetworkImageWithPlaceholder(
                                r.bannerImage,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(r.nome, style: const TextStyle(fontWeight: FontWeight.w800)),
                            subtitle: Text('${r.categoria} • ${r.tempoEntrega}'),
                            trailing: Text('${r.rating}', style: const TextStyle(color: Color(0xFFF1A124), fontWeight: FontWeight.w700)),
                            onTap: () {
                              // navegar para detalhe — reusar a tela existente
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => RestaurantDetailScreen(restaurant: r),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Opiniões Realizadas'),
        backgroundColor: const Color(0xFFC92121),
        foregroundColor: Colors.white,
      ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: const <Widget>[
              _ReviewCard(
                title: 'Burger Joint',
                rating: '4.5',
                review: 'Ótimo burger, batatas crocantes. Recomendo!',
                date: '2026-09-10',
              ),
              _ReviewCard(
                title: 'Sushi House',
                rating: '5.0',
                review: 'Sushi fresco e atendimento excelente.',
                date: '2026-09-12',
              ),
            ],
          ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xFFC92121),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFF1A124),
              child: Icon(Icons.person, size: 42, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'nome.usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'nome.usuario@email.com',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            const _ProfileOption(title: 'Endereços', icon: Icons.location_on_outlined),
            const _ProfileOption(title: 'Pagamentos', icon: Icons.credit_card_outlined),
            const _ProfileOption(title: 'Ajuda', icon: Icons.help_outline),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BotaoCustomizado(
                texto: 'Sair',
                onPressed: () {},
                backgroundColor: const Color(0xFFF1A124),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.rating,
    required this.review,
    required this.date,
  });

  final String title;
  final String rating;
  final String review;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE3A6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.rate_review, color: Color(0xFFC92121)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 6),
                Text(review, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Text(date, style: const TextStyle(color: Colors.black38, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1D3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(rating, style: const TextStyle(color: Color(0xFFC92121), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: const Color(0xFFC92121)),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
