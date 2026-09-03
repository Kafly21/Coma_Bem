class RestauranteModel {
  const RestauranteModel({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.rating,
    required this.tempoEntrega,
    required this.endereco,
    required this.descricao,
    required this.bannerImage,
    required this.pratos,
  });

  final int id;
  final String nome;
  final String categoria;
  final double rating;
  final String tempoEntrega;
  final String endereco;
  final String descricao;
  final String bannerImage;
  final List<PratoModel> pratos;
}

class PratoModel {
  const PratoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imageUrl,
    required this.restaurantName,
  });

  final int id;
  final String nome;
  final String descricao;
  final double preco;
  final String imageUrl;
  final String restaurantName;
}

const List<RestauranteModel> demoRestaurants = <RestauranteModel>[
  RestauranteModel(
    id: 1,
    nome: 'Burger Joint',
    categoria: 'Hambúrguer',
    rating: 4.9,
    tempoEntrega: '25-35 min',
    endereco: 'Av. Paulista, 123',
    descricao: 'Hambúrgueres artesanais, batatas crocantes e combinações premium para qualquer momento.',
    bannerImage: 'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=80',
    pratos: <PratoModel>[
      PratoModel(
        id: 101,
        nome: 'Double Bacon Burger',
        descricao: 'Pão brioche, duas carnes suculentas, bacon crocante e molho especial.',
        preco: 34.90,
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80',
        restaurantName: 'Burger Joint',
      ),
      PratoModel(
        id: 102,
        nome: 'Batata Frita Cheddar',
        descricao: 'Batatas crocantes com cheddar derretido e cebola roxa.',
        preco: 18.50,
        imageUrl: 'https://images.unsplash.com/photo-1576107232684-1279f390859f?auto=format&fit=crop&w=900&q=80',
        restaurantName: 'Burger Joint',
      ),
    ],
  ),
  RestauranteModel(
    id: 2,
    nome: 'Sushi House',
    categoria: 'Japonesa',
    rating: 4.8,
    tempoEntrega: '30-40 min',
    endereco: 'Rua da Liberdade, 45',
    descricao: 'Sushi fresco, sashimi e combinações especiais para todos os gostos.',
    bannerImage: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=1200&q=80',
    pratos: <PratoModel>[
      PratoModel(
        id: 201,
        nome: 'Temaki de Salmão',
        descricao: 'Temaki crocante com salmão, alga e cream cheese.',
        preco: 24.00,
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?auto=format&fit=crop&w=900&q=80',
        restaurantName: 'Sushi House',
      ),
    ],
  ),
];
