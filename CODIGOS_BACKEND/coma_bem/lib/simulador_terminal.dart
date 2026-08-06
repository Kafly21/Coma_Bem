import 'dart:io';

import 'models/usuario.dart';
import 'models/cliente.dart';
import 'models/administrador.dart';

void main() {
  List<Usuario> usuariosCadastrados = [];
  bool sistemaRodando = true;

  print("=== BEM-VINDO AO SIMULADOR DE OBJETOS COMA BEM ===");

  while (sistemaRodando) {
    print('\nSelecione uma ação:');
    print('1 - Cadastrar novo Cliente');
    print('2 - Cadastrar novo Administrador');
    print('3 - Listar perfis e exibir Menus (Testar Polimorfismo)');
    print('4 - Sair do Sistema');

    stdout.write('Sua opção: ');

    String? opcao = stdin.readLineSync();

    // Controle de Fluxo: Múltiplas escolhas
    switch (opcao) {
      case '1':
        print('\n--- CADASTRO DE CLIENTE ---');
        stdout.write('Digite o nome do cliente: ');
        String? nome = stdin.readLineSync();

        // ================================================================
        // DESAFIO 1: PROGRAME O CADASTRO DE CLIENTE
        // 1. Crie um objeto do tipo Cliente passando o 'nome' digitado.
        //    (Para o ID, Email e Senha, você pode inventar valores fictícios).
        // 2. Adicione este objeto dentro da lista 'usuariosCadastrados'.
        // 3. Imprima uma mensagem de sucesso.
        // ================================================================

        //print('Ops, a lógica do Desafio 1 ainda não foi feita!');

        // Garantindo que não seja null
        String nomeCliente = nome ?? 'Sem nome';

        // Gerando ID automático
        int id = usuariosCadastrados.length + 1;

        // Criando o cliente
        Cliente cliente = Cliente(
          id,
          nomeCliente,
          'cliente$id@email.com',
          '123456'
        );

        // Adicionando na lista
        usuariosCadastrados.add(cliente);

        // Sucesso
        print('Cliente cadastrado com sucesso!');

        break;

      case '2':
        print('\n --- CADASTRO DE ADMINISTRADOR --- ');
        stdout.write('Digite o nome do administrador: ');
        String? nomeAdmin = stdin.readLineSync();

        // ============================================================
        // DESAFIO 2: PROGRAME O CADASTRO DE ADMINISTRADOR
        // 1. Crie um objeto do tipo Administrador passando o 'nomeAdmin'.
        // 2. Adicione este objeto dentro da lista 'usuariosCadastrados'.
        // 3. Imprima uma mensagem de sucesso.
        // ============================================================

        //print('Ops, a lógica do Desafio 2 ainda não foi feita!');

        // Garantindo que não seja null
        String nomeAdministrador = nomeAdmin ?? 'Sem nome';

        // Gerando ID automático
        int id = usuariosCadastrados.length + 1;

        // Criando o administrador
        Administrador admin = Administrador(
          id,
          nomeAdministrador,
          'admin$id@email.com',
          '123456'
        );

        // Adicionando na lista
        usuariosCadastrados.add(admin);

        // Sucesso
        print('Administrador cadastrado com sucesso!');

        break;

      case '3':
        print('\n --- LISTAGEM DE USUÁRIOS --- ');

        // ============================================================
        // DESAFIO 3: PROGRAME A LISTAGEM (POLIMORFISMO)
        // 1. Verifique se a lista 'usuariosCadastrados' está vazia. Se estiver,
        //    imprima "Nenhum usuário cadastrado".
        // 2. Caso tenha usuários, faça um laço de repetição (for) percorrendo a lista.
        // 3. Imprima o nome do usuário.
        // 4. Chame o método exibirMenu() para provar que o Polimorfismo funciona!
        // ============================================================

        //print('Ops, a lógica do Desafio 3 ainda não foi feita!');

        if (usuariosCadastrados.isEmpty) {
          print('Nenhum usuário cadastrado.');
        } else {
          for (Usuario usuario in usuariosCadastrados) {
            print('\nNome: ${usuario.nomeUsuario}');
            
            // Aqui acontece o POLIMORFISMO
            usuario.exibirMenu();
          }
        }

        break;    

      case '4':
        sistemaRodando = false;
        print('\nEncerrando o sistema. Até logo!');
        break;

      default:
        print('\nOpção inválida. Por favor, tente novamente com um número de 1 a 4.');    
    }
  }
}