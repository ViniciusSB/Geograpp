// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class ComoJogarQuiz extends StatefulWidget {
  const ComoJogarQuiz({super.key});

  @override
  State<ComoJogarQuiz> createState() => _ComoJogarQuizState();
}

class _ComoJogarQuizState extends State<ComoJogarQuiz> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Como jogar - Quiz Tocantins",
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
                  Imagens.arara,
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
                      text: '"Conhecendo o Tocantins" ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "se trata de quiz de perguntas e resposta sobre tópicos relacionados aos recursos naturais, recursos econômicos, questões culturais, hidrografia, clima, vegetação e relevo do estado do Tocantins. O jogo apresenta 3 níveis de dificuldade, no catálogo conta com 30 questões de 4 alternativas, ao final do jogo é gerada uma classificação a partir do desempenho do jogador.",
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
