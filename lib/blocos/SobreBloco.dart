// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class SobreBloco extends StatefulWidget {
  const SobreBloco({super.key});

  @override
  State<SobreBloco> createState() => _SobreBlocoState();
}

class _SobreBlocoState extends State<SobreBloco> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sobre - Blocos deslizantes",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6081DB),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  Imagens.metadados,
                  width: screenWidth * 0.75,
                  height: screenWidth * 0.75,
                ),
              ),
              SizedBox(height: 18),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Título do Objeto: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Blocos deslizantes.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Linguagem: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Português (Brasil).",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Descrição: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "jogo interativo de quebra-cabeças deslizantes com pontos turisticos de Palmas-Tocantins. Teste a sua concentração, paciência e persistência neste jogo desafiador.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Palavras-Chave: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "ODA, Geografia, Tocantins, Quebra-cabeça.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Autor: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Vinícius Santos Bessa.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Idade sugerida: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "a partir de 10 anos.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Contexto sugerido: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "não consta.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 3),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth * 0.04),
                  children: [
                    TextSpan(
                      text: "Dificuldade: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "difícil.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
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
