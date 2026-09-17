import 'package:flutter/material.dart';
import '../components/network_image_with_placeholder.dart';

import '../models/restaurante_model.dart';
import 'food_review_screen.dart';
import '../components/botao_customizado.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({required this.prato, super.key});

  final PratoModel prato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: Text(prato.nome),
        backgroundColor: const Color(0xFFC92121),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: NetworkImageWithPlaceholder(
                        prato.imageUrl,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            prato.nome,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          'R\$ ${prato.preco.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFC92121),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Descrição',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prato.descricao,
                      style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ingredientes',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              Chip(label: Text('Pão brioche')),
                              Chip(label: Text('Carne')),
                              Chip(label: Text('Bacon')),
                              Chip(label: Text('Queijo')),
                              Chip(label: Text('Alface')),
                              Chip(label: Text('Tomate')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE9E9E9))),
              ),
              child: BotaoCustomizado(
                texto: 'Avaliar este Prato',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FoodReviewScreen(prato: prato),
                    ),
                  );
                },
                backgroundColor: const Color(0xFFF1A124),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
