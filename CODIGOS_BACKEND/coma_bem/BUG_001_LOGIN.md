# Relatório de Bug: Falha no Fluxo de Login

- **ID do Bug:** #001
- **Severidade:** ALTA (Impede o acesso ao aplicativo)
- **Funcionalidade:** Tela de Login (`login_screen.dart`)

1. **Descrição do Problema**

O robô de testes de integração falhou ao tentar realizar o login no aplicativo durante os testes de regressão. O fluxo é interrompido após o preenchimento da senha porque o botão principal foi renomeado.

2. **Passos para Reproduzir**

1. Abrir o aplicativo no emulador.
2. Digitar e-mail válido.
3. Digitar senha válida.
4. Tentar clicar no botão principal de acesso.

3. **Resultado Esperado**

O robô deveria encontrar o botão com o texto "Entrar", clicar nele e ser redirecionado para a tela "Catálogo de Restaurantes".

4. **Resultado Atual**

O teste falha com Timeout. O log do terminal aponta o erro: zero widgets with text "Entrar".

5. **Causa Raiz Encontrada**

O texto do botão na interface gráfica foi alterado de "Entrar" para "Acessar", quebrando o script do robô de automação que ainda procura pela palavra antiga.

6. **Correção Sugerida**

- Restaurar o texto para `Text('Entrar')` em `lib/screens/login_screen.dart` ou
- Atualizar o teste de integração para procurar `find.text('Acessar')` se a mudança na UI foi intencional.

7. **Notas**

Arquivo criado automaticamente durante o laboratório de testes de regressão.
