import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Classe responsável por gerenciar a conexão com o banco de dados SQLite
/// e realizar as transações de autenticação, inserção, consulta, alteração e deleção.
class DatabaseHelper {
  static final DatabaseHelper _instancia = DatabaseHelper._interno();
  static Database? _bancoDeDados;

  static DatabaseHelper get instancia => _instancia;

  factory DatabaseHelper() => _instancia;

  DatabaseHelper._interno();

  /// Inicia a conexão com o banco de dados.
  Future<Database> get bancoDeDados async {
    if (_bancoDeDados != null) return _bancoDeDados!;
    _bancoDeDados = await _iniciarBanco();
    return _bancoDeDados!;
  }

  /// Configura o caminho do banco no dispositivo e cria as tabelas se for a primeira execução.
  Future<Database> _iniciarBanco() async {
    String caminhoBanco = await getDatabasesPath();
    String caminhoCompleto = join(caminhoBanco, 'coma_bem.db');

    return await openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  /// Cria a estrutura inicial do banco de dados (Tabelas).
  Future<void> _criarTabelas(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE usuario (
        usu_id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        usu_tx_email TEXT NOT NULL UNIQUE,
        usu_tx_senha TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE restaurante (
        res_id_restaurante INTEGER PRIMARY KEY AUTOINCREMENT,
        res_nm_restaurante TEXT NOT NULL,
        res_nu_latitude TEXT NOT NULL,
        res_nu_longitude TEXT NOT NULL,
        res_ds_tipo_culinaria TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE prato (
        pra_id_prato INTEGER PRIMARY KEY AUTOINCREMENT,
        pra_nm_prato TEXT NOT NULL,
        pra_im_foto TEXT,
        pra_id_restaurante INTEGER NOT NULL,
        FOREIGN KEY (pra_id_restaurante) REFERENCES restaurante(res_id_restaurante)
      )
    ''');

    await db.execute('''
      CREATE TABLE avaliacao (
        avl_id_avaliacao INTEGER PRIMARY KEY AUTOINCREMENT,
        avl_nu_ranking INTEGER NOT NULL CHECK (avl_nu_ranking >= 1 AND avl_nu_ranking <= 5),
        avl_tx_recomendacao TEXT NOT NULL,
        avl_id_prato INTEGER NOT NULL,
        avl_id_usuario INTEGER NOT NULL,
        FOREIGN KEY (avl_id_prato) REFERENCES prato(pra_id_prato),
        FOREIGN KEY (avl_id_usuario) REFERENCES usuario(usu_id_usuario)
      )
    ''');

    await db.insert('usuario', {
      'usu_tx_email': 'admin@comabem.com',
      'usu_tx_senha': 'admin123',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // ============================================================================
  // TRANSAÇÕES DE MANIPULAÇÃO DE DADOS (CRUD) E AUTENTICAÇÃO
  // ============================================================================

  /// Realiza a AUTENTICAÇÃO do usuário.
  /// Consulta no banco de dados se o e-mail e a senha informados existem e coincidem.
  /// Retorna os dados do usuário em caso de sucesso, ou nulo se as credenciais forem inválidas.
  Future<Map<String, dynamic>?> autenticarUsuario(
    String email,
    String senha,
  ) async {
    Database db = await bancoDeDados;

    List<Map<String, dynamic>> resultado = await db.query(
      'usuario',
      where: 'usu_tx_email = ? AND usu_tx_senha = ?',
      whereArgs: [email, senha],
    );

    if (resultado.isNotEmpty) return resultado.first;
    return null;
  }

  /// Realiza a INSERÇÃO (Create) de um novo registro.
  /// Recebe o nome da tabela e um mapa com os dados, inserindo-os no banco.
  /// Retorna o ID numérico gerado para o novo registro.
  Future<int> inserirDados(String tabela, Map<String, dynamic> dados) async {
    Database db = await bancoDeDados;
    return await db.insert(tabela, dados);
  }

  /// Realiza a CONSULTA (Read) de registros.
  /// Retorna uma lista com todos os dados cadastrados na tabela solicitada.
  Future<List<Map<String, dynamic>>> consultarDados(String tabela) async {
    Database db = await bancoDeDados;
    return await db.query(tabela);
  }

  /// Realiza a ALTERAÇÃO (Update) de um registro existente.
  /// Atualiza os dados com base na coluna de ID (chave primária) informada.
  /// Retorna o número de linhas que foram modificadas no banco.
  Future<int> alterarDados(
    String tabela,
    Map<String, dynamic> novosDados,
    String colunaId,
    int id,
  ) async {
    Database db = await bancoDeDados;

    return await db.update(
      tabela,
      novosDados,
      where: '$colunaId = ?',
      whereArgs: [id],
    );
  }

  /// Realiza a DELEÇÃO (Delete) de um registro.
  /// Remove permanentemente os dados da tabela com base no ID informado.
  /// Retorna o número de linhas excluídas.
  Future<int> deletarDados(String tabela, String colunaId, int id) async {
    Database db = await bancoDeDados;
    return await db.delete(tabela, where: '$colunaId = ?', whereArgs: [id]);
  }

  /// Insere um novo restaurante, seu prato principal e a avaliação associada.
  Future<int> cadastrarRestauranteCompleto({
    required String nomeRestaurante,
    required String latitude,
    required String longitude,
    required String tipoCulinaria,
    required String nomePrato,
    required String fotoPrato,
    required int ranking,
    required String recomendacao,
    int idUsuario = 1,
  }) async {
    final Database db = await bancoDeDados;

    final int idRestaurante = await db.insert('restaurante', {
      'res_nm_restaurante': nomeRestaurante,
      'res_nu_latitude': latitude,
      'res_nu_longitude': longitude,
      'res_ds_tipo_culinaria': tipoCulinaria,
    });

    final int idPrato = await db.insert('prato', {
      'pra_nm_prato': nomePrato,
      'pra_im_foto': fotoPrato,
      'pra_id_restaurante': idRestaurante,
    });

    await db.insert('avaliacao', {
      'avl_nu_ranking': ranking,
      'avl_tx_recomendacao': recomendacao,
      'avl_id_prato': idPrato,
      'avl_id_usuario': idUsuario,
    });

    return idRestaurante;
  }

  /// Insere um novo restaurante no banco de dados.
  /// Espera um mapa de dados contendo nome, latitude, longitude e tipo de culinária.
  Future<void> inserirRestaurante(Map<String, dynamic> dadosRestaurante) async {
    try {
      Database db = await bancoDeDados;

      // O sqflite já utiliza parâmetros seguros por padrão no método insert
      int idGerado = await db.insert('restaurante', dadosRestaurante);

      print('Sucesso: Restaurante cadastrado com o ID $idGerado.');
    } catch (erro) {
      // O try-catch captura o erro e impede que o aplicativo trave
      print('Erro ao tentar cadastrar o restaurante: \$erro');
    }
  }

  /// Retorna uma lista de restaurantes filtrada pelo tipo de culinária (ex: 'Italiana').
  Future<List<Map<String, dynamic>>> listarRestaurantesPorTipo(
    String tipo,
  ) async {
    try {
      Database db = await bancoDeDados;

      // Uso correto do parâmetro '?' para evitar ataques de SQL Injection
      List<Map<String, dynamic>> lista = await db.query(
        'restaurante',
        where: 'res_ds_tipo_culinaria = ?',
        whereArgs: [tipo],
      );

      print('Sucesso: Foram encontrados \${lista.length} restaurantes.');
      return lista;
    } catch (erro) {
      print('Erro ao buscar restaurantes do tipo \$tipo: \$erro');
      return []; // Retorna uma lista vazia em caso de falha
    }
  }

  /// Atualiza o ranking (nota) e o texto de recomendação de uma avaliação existente.
  Future<void> atualizarAvaliacao(
    int idAvaliacao,
    int novaNota,
    String novoTexto,
  ) async {
    try {
      Database db = await bancoDeDados;

      int linhasAfetadas = await db.update(
        'avaliacao',
        {'avl_nu_ranking': novaNota, 'avl_tx_recomendacao': novoTexto},
        where: 'avl_id_avaliacao = ?', // Proteção com parâmetro
        whereArgs: [idAvaliacao],
      );

      if (linhasAfetadas > 0) {
        print('Sucesso: Avaliação atualizada.');
      } else {
        print('Aviso: Nenhuma avaliação encontrada com o ID $idAvaliacao.');
      }
    } catch (erro) {
      print('Erro ao atualizar a avaliação: \$erro');
    }
  }

  /// Exclui permanentemente um prato do cardápio utilizando seu ID.
  Future<void> removerPrato(int idPrato) async {
    try {
      Database db = await bancoDeDados;

      int linhasAfetadas = await db.delete(
        'prato',
        where:
            'pra_id_prato = ?', // Parâmetro para evitar exclusão acidental de toda a tabela
        whereArgs: [idPrato],
      );

      if (linhasAfetadas > 0) {
        print('Sucesso: Prato deletado do cardápio.');
      } else {
        print('Aviso: Nenhum prato encontrado com o ID $idPrato.');
      }
    } catch (erro) {
      print('Erro ao tentar remover o prato: \$erro');
    }
  }

  /// Retorna restaurantes cujo nome contenha o trecho digitado (Busca aproximada).
  Future<List<Map<String, dynamic>>> buscarRestaurantePorNome(
    String termoBusca,
  ) async {
    try {
      Database db = await bancoDeDados;

      // O % antes e depois do termo significa "qualquer coisa antes ou depois" dessa palavra.
      List<Map<String, dynamic>> lista = await db.query(
        'restaurante',
        where: 'res_nm_restaurante LIKE ?',
        whereArgs: ['%$termoBusca%'],
      );

      print(
        'Sucesso: Foram encontrados ${lista.length} restaurantes contendo "$termoBusca".',
      );
      return lista;
    } catch (erro) {
      // O try-catch captura o erro e impede que o aplicativo trave
      print('Erro ao buscar restaurante por nome: $erro');
      return [];
    }
  }

  /// Retorna todos os pratos vinculados ao ID de um restaurante específico.
  Future<List<Map<String, dynamic>>> listarPratosPorRestaurante(
    int idRestaurante,
  ) async {
    try {
      Database db = await bancoDeDados;

      List<Map<String, dynamic>> cardapio = await db.query(
        'prato',
        where: 'pra_id_restaurante = ?', // Filtrando pela Chave Estrangeira
        whereArgs: [idRestaurante],
      );

      print(
        'Sucesso: ${cardapio.length} pratos carregados para o restaurante ID $idRestaurante.',
      );
      return cardapio;
    } catch (erro) {
      print('Erro ao carregar o cardápio: $erro');
      return [];
    }
  }
}
