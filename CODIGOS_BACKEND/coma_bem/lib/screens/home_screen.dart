import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _restaurantes = [];

  @override
  void initState() {
    super.initState();
    _carregarRestaurantes();
  }

  void _carregarRestaurantes() async {
    var dados = await DatabaseHelper().consultarDados('restaurante');

    if (!mounted) return;

    setState(() {
      _restaurantes = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Barra superior.
      appBar: AppBar(
        title: Text('Catálogo de Restaurantes'),
        backgroundColor: Colors.orange,
      ),

      // Lista dos restaurantes.
      body: ListView.builder(

        // Quantidade de itens.
        itemCount: _restaurantes.length,

        // Cria cada restaurante.
        itemBuilder: (context, index) {

          // Card de cada restaurante.
          return Card(
            margin: EdgeInsets.all(10),

            // Cor do Card.
            color: Colors.orange[50],

            child: ListTile(

              // Ícone à esquerda.
              leading: Icon(
                Icons.fastfood,
                color: Colors.orange,
              ),

              // Nome do restaurante.
              title: Text(
                _restaurantes[index]['res_nm_restaurante'],
              ),

              // Tipo de culinária.
              subtitle: Text(
                'Culinária: ${_restaurantes[index]['res_ds_tipo_culinaria']}',
              ),
            ),
          );
        },
      ),

      // Botão "+" para cadastrar restaurante.
      floatingActionButton: FloatingActionButton(

        // Quando clicado, abre a tela de cadastro.
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroScreen(),
            ),
          );
        },

        // Ícone de "mais".
        child: Icon(Icons.add),

        // Cor do botão.
        backgroundColor: Colors.orange,
      ),
    );
  }
}