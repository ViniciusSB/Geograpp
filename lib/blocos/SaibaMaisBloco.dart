// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class SaibaMaisBloco extends StatefulWidget {
  const SaibaMaisBloco({super.key});

  @override
  State<SaibaMaisBloco> createState() => _SaibaMaisBlocoState();
}

class _SaibaMaisBlocoState extends State<SaibaMaisBloco> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Como jogar - Blocos deslizantes",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  Imagens.comoJogarG,
                  height: screenWidth * 0.75,
                  width: screenWidth * 0.75,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "O jogo ",
                    ),
                    TextSpan(
                      text: '"Blocos deslizantes" ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "se trata de um jogo de quebra-cabeças deslizantes, o objetivo é formar a imagem completa do ponto turístico escolhido. Cada imagem contem de 8 a 16 fragmentos de imagens dependendo do nível selecionado, entre elas existe um espaço livre que permite a organização dos blocos próximos, o objetivo é formar a imagem original em sua sequencia correta. A partir do primeiro movimento o jogo cronometra o tempo e a quantidade total de movimentos. Ao finalizar o jogo uma curiosidade sobre o ponto turístico selecionado será exibida.",
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
