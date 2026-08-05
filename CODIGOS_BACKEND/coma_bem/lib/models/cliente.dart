import 'usuario.dart';

class Cliente extends Usuario {
  Cliente(super.id, super.nome, super.email, super.senha);

  void avaliarPrato(String prato, int nota) {
    print("O cliente $nomeUsuario avaliou o prato $prato com nota $nota.");
  }

  @override
  void exibirMenu() {
    print('--------- Menu do Cliente --------');
    print('1. Buscar Restaurantes');
    print('2. Meus Favoritos');
  }

  @override
  void gerenciarConta() {
    print('Gerenciando a forma de pagamento e de endereço de entrega.');
  }
}