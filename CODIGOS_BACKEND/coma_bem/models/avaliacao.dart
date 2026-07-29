/// Classe que une os dados do usuário e do prato avaliado.
class Avaliacao {
  // Atributos privados
  int _idAvaliacao;
  int _ranking; // Nota de 1 a 5
  String _recomendacao; // Texto da avaliação
  int _idPrato; // FK
  int _idUsuario; // FK

  // Construtor
  Avaliacao(this._idAvaliacao, this._ranking, this._recomendacao,
      this._idPrato, this._idUsuario);

  // Getters
  int get idAvaliacao => _idAvaliacao;
  int get ranking => _ranking;
  String get recomendacao => _recomendacao;
  int get idPrato => _idPrato;
  int get idUsuario => _idUsuario;

  // Setters
  set ranking(int nota) {
    // Validação idêntica à restrição CHECK do banco de dados
    if (nota >= 1 && nota <= 5) {
      _ranking = nota;
    } else {
      print('Erro: A nota deve estar entre 1 e 5.');
    }
  }

  set recomendacao(String texto) => _recomendacao = texto;
}