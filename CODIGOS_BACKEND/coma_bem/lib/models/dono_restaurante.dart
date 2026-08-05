import 'usuario.dart';

class DonoRestaurante extends Usuario {
  String cnpj;

  DonoRestaurante(super.id, super.nome, super.email, super.senha, this.cnpj);

  @override
  void exibirMenu() {
    print('--------- Menu do Dono do Restaurante --------');
    print('1. Cadastrar Pratos');
    print('2. Visualizar avaliações recebidas');
  }

  @override
  void gerenciarConta() {
    print('Gerenciando dados bancários da empresa CNPJ: $cnpj.');
  }
}