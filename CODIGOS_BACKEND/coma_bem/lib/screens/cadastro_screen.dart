import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../database/database_helper.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  // Controladores de texto para ler o que o usuário
  // vai digitar nos campos.
  final TextEditingController _nomeController =
      TextEditingController();

  final TextEditingController _culinariaController =
      TextEditingController();

  // Armazena o caminho da foto no aparelho.
  // O ? significa que pode começar como nulo.
  File? _fotoPrato;

  // Variáveis para guardar as coordenadas do GPS.
  String _latitude = '';
  String _longitude = '';

  // Instância do ImagePicker para acessar a câmera.
  final ImagePicker _picker = ImagePicker();

  // ==========================================
  // FUNÇÃO: TIRAR FOTO COM A CÂMERA
  // ==========================================

  // Função assíncrona porque precisamos esperar
  // o usuário tirar e confirmar a foto.
  Future<void> _tirarFoto() async {

    // Abre a câmera do dispositivo.
    final XFile? fotoCapturada =
        await _picker.pickImage(
          source: ImageSource.camera,
        );

    // Se o usuário tirou uma foto.
    if (fotoCapturada != null) {

      // Atualiza a tela para mostrar a foto.
      setState(() {

        // Converte o arquivo retornado pela câmera
        // em um objeto File.
        _fotoPrato = File(fotoCapturada.path);
      });
    }
  }

  // ==========================================
  // FUNÇÃO: SALVAR NO BANCO DE DADOS
  // ==========================================

  void _salvarCadastro() async {

    // Mapa que representa uma linha do banco.
    //
    // As chaves devem ser idênticas
    // aos nomes das colunas do banco.
    Map<String, dynamic> dadosRestaurante = {

      'res_nm_restaurante': _nomeController.text,

      'res_ds_tipo_culinaria':
          _culinariaController.text,

      'res_nu_latitude':
          _latitude,

      'res_nu_longitude':
          _longitude,
    };

    // Chama a função inserirDados()
    // informando a tabela restaurante.
    await DatabaseHelper().inserirDados(
      'restaurante',
      dadosRestaurante,
    );

    // Caso fosse inserir o prato,
    // o PDF mostra que seria possível usar:
    //
    // 'pra_im_foto': _fotoPrato!.path

    // Mostra mensagem de sucesso.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Restaurante cadastrado!'),
      ),
    );

    // Volta para a tela anterior.
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Novo Cadastro'),
        backgroundColor: Colors.orange,
      ),

      // SingleChildScrollView permite rolar o formulário
      // quando o teclado aparecer.
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            // Campo do nome do restaurante.
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Restaurante',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // ==========================================
            // DESAFIO 2: CAMPOS FALTANTES
            // ==========================================

            // O PDF pede para adicionar:
            // 1. Tipo de culinária
            // 2. Nome do prato
            // 3. Ranking (nota de 1 a 5)
            // 4. Recomendações
            // ==========================================

            SizedBox(height: 20),

            // ==========================================
            // SEÇÃO DA CÂMERA (FOTO DO PRATO)
            // ==========================================

            Text(
              'Foto do Prato:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 10),

            Container(
              height: 200,
              width: double.infinity,

              // Fundo cinza caso não exista foto.
              color: Colors.grey[300],

              // Se existir foto, exibe.
              child: _fotoPrato != null
                  ? Image.file(
                      _fotoPrato!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                        'Nenhuma foto selecionada',
                      ),
                    ),
            ),

            SizedBox(height: 10),

            // Botão da câmera.
            ElevatedButton.icon(
              onPressed: _tirarFoto,

              icon: Icon(Icons.camera_alt),

              label: Text('Tirar Foto do Prato'),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}    