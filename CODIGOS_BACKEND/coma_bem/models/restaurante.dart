/// Classe que representa a tabela de Restaurantes.
class Restaurante {
  // Atributos privados
  int _idRestaurante;
  String _nomeRestaurante;
  String _latitude;
  String _longitude;
  String _tipoCulinaria;

  // Construtor
  Restaurante(this._idRestaurante, this._nomeRestaurante, this._latitude,
      this._longitude, this._tipoCulinaria);

  // Getters
  int get idRestaurante => _idRestaurante;
  String get nomeRestaurante => _nomeRestaurante;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get tipoCulinaria => _tipoCulinaria;

  // Setters
  set nomeRestaurante(String nome) => _nomeRestaurante = nome;
  set latitude(String lat) => _latitude = lat;
  set longitude(String lon) => _longitude = lon;
  set tipoCulinaria(String tipo) => _tipoCulinaria = tipo;
}