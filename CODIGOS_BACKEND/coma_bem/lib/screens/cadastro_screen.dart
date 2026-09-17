import '../components/campo_formulario_customizado.dart';
import '../components/botao_customizado.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/database_helper.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeRestauranteController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _culinariaController = TextEditingController();
  final TextEditingController _nomePratoController = TextEditingController();
  final TextEditingController _recomendacaoController = TextEditingController();

  int _ranking = 5;
  File? _fotoPrato;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nomeRestauranteController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _culinariaController.dispose();
    _nomePratoController.dispose();
    _recomendacaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarFoto() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.gallery);
    if (imagem == null) return;

    setState(() {
      _fotoPrato = File(imagem.path);
    });
  }

  Future<void> _tirarFoto() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.camera);
    if (imagem == null) return;
  
    setState(() {
      _fotoPrato = File(imagem.path);
    });
  }

  Future<void> _salvarCadastro() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_fotoPrato == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma foto do prato antes de salvar.'),
          backgroundColor: Color(0xFFC92121),
        ),
      );
      return;
    }

    // Validação preventiva do ranking (deve estar entre 1 e 5)
    if (_ranking < 1 || _ranking > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O Ranking deve ser uma nota de 1 a 5!'),
          backgroundColor: Color(0xFFC92121),
        ),
      );
      return;
    }

    final String nomeRestaurante = _nomeRestauranteController.text.trim();
    final String latitude = _latitudeController.text.trim();
    final String longitude = _longitudeController.text.trim();
    final String tipoCulinaria = _culinariaController.text.trim();
    final String nomePrato = _nomePratoController.text.trim();
    final String recomendacao = _recomendacaoController.text.trim();

    try {
      await DatabaseHelper.instancia.cadastrarRestauranteCompleto(
        nomeRestaurante: nomeRestaurante,
        latitude: latitude,
        longitude: longitude,
        tipoCulinaria: tipoCulinaria,
        nomePrato: nomePrato,
        fotoPrato: _fotoPrato!.path,
        ranking: _ranking,
        recomendacao: recomendacao,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Restaurante cadastrado com sucesso!'),
          backgroundColor: Color(0xFFF1A124),
        ),
      );

      Navigator.pop(context);
    } catch (erro, stack) {
      // Log detalhado para ajudarmos na depuração
      debugPrint('DEBUG - Erro ao salvar no SQLite: $erro');
      debugPrint('$stack');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocorreu um erro inesperado ao salvar.'),
          backgroundColor: Color(0xFFC92121),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Cadastro do restaurante'),
        backgroundColor: const Color(0xFFC92121),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Informações principais',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 18),
                _buildField(
                  controller: _nomeRestauranteController,
                  label: 'Nome do restaurante',
                  icon: Icons.storefront,
                  validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildField(
                        controller: _latitudeController,
                        label: 'Latitude',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        controller: _longitudeController,
                        label: 'Longitude',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildField(
                  controller: _culinariaController,
                  label: 'Tipo de culinária',
                  icon: Icons.restaurant_menu,
                  validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  controller: _nomePratoController,
                  label: 'Nome do prato',
                  icon: Icons.fastfood,
                  validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Foto do prato',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE5E5E5)),
                  ),
                  child: _fotoPrato != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            _fotoPrato!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Nenhuma foto selecionada',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _selecionarFoto,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galeria'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BotaoCustomizado(
                        texto: 'Camera',
                        icon: Icons.camera_alt,
                        onPressed: _tirarFoto,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'Ranking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: _ranking,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: List.generate(5, (index) => index + 1)
                      .map(
                        (value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value estrela${value > 1 ? 's' : ''}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _ranking = value);
                    }
                  },
                ),
                const SizedBox(height: 18),
                _buildField(
                  controller: _recomendacaoController,
                  label: 'Recomendação do usuário',
                  icon: Icons.comment,
                  maxLines: 4,
                  validator: (value) => value == null || value.trim().isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: BotaoCustomizado(
                    texto: 'Salvar restaurante',
                    onPressed: _salvarCadastro,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFC92121)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
