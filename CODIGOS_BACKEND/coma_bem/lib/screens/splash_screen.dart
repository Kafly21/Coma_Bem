// Importa o pacote base do Flutter para criação de interfaces (Material Design)
import 'package:flutter/material.dart';

// Importa a biblioteca 'dart:async' para podermos usar o Timer (temporizador)
import 'dart:async';

// Importa a próxima tela para onde o usuário será levado após a Splash Screen
import 'login_screen.dart';

// A SplashScreen precisa ser um StatefulWidget pois seu estado vai mudar
// (ela vai sumir após um tempo)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // O método initState() é chamado automaticamente
  // assim que a tela é carregada pela primeira vez.
  @override
  void initState() {
    super.initState();

    // Timer é uma função assíncrona.
    // Ele conta o tempo definido (aqui, 3 segundos)
    // e executa a função dentro das chaves {} quando o tempo acaba.
    Timer(Duration(seconds: 3), () {

      // O Navigator gerencia a troca de telas no Flutter.
      // pushReplacement substitui a Splash Screen pela LoginScreen.
      // Assim, se o usuário clicar no botão "Voltar" do celular,
      // ele não volta para a Splash Screen, ele sai do app.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  // O método build() é onde desenhamos os elementos visuais (widgets) da tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor define a cor de fundo da tela inteira.
      // Troque pela cor definida no seu protótipo.
      backgroundColor: Colors.orangeAccent,

      // Center centraliza todo o conteúdo no meio da tela.
      body: Center(

        // Column organiza os elementos um embaixo do outro.
        child: Column(

          // Centraliza a coluna verticalmente.
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // Widget Icon desenha um ícone nativo.
            Icon(
              Icons.restaurant,
              size: 100,
              color: Colors.white,
            ),

            // Espaço entre os elementos.
            SizedBox(height: 20),

            // Widget Text exibe o nome do aplicativo.
            Text(
              'Coma Bem',

              // Formatação do texto.
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            // Rodinha de carregamento.
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}