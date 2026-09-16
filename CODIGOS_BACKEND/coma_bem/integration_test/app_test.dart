import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:coma_bem/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validação funcional: login -> catálogo -> novo cadastro', (WidgetTester tester) async {
    // Inicia o app
    app.main();
    await tester.pumpAndSettle();

    // Encontra os campos de login (TextFormField) - email primeiro, senha depois
    final campoEmail = find.byType(TextFormField).first;
    final campoSenha = find.byType(TextFormField).last;

    // Encontra o botão Entrar pelo texto
    final botaoEntrar = find.text('Entrar');

    // Digita credenciais
    await tester.enterText(campoEmail, 'admin@comabem.com');
    await tester.enterText(campoSenha, 'senha123');
    await tester.pumpAndSettle();

    // Clica em Entrar
    await tester.tap(botaoEntrar);
    await tester.pumpAndSettle();

    // Verifica que a tela principal (catálogo) apareceu — procuramos por 'DESTAQUES'
    expect(find.text('DESTAQUES'), findsOneWidget);

    // DESAFIO: abrir a tela de cadastro usando o botão +
    final botaoNovo = find.byIcon(Icons.add_rounded);
    expect(botaoNovo, findsOneWidget);
    await tester.tap(botaoNovo);
    await tester.pumpAndSettle();

    // Validar que a tela de cadastro abriu procurando pelo texto 'Foto do prato'
    expect(find.text('Foto do prato'), findsOneWidget);
  });
}
