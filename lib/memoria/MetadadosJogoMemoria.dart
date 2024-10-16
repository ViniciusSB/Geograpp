// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class MetadadosJogoMemoria extends StatefulWidget {
  const MetadadosJogoMemoria({super.key});

  @override
  State<MetadadosJogoMemoria> createState() => _MetadadosJogoMemoriaState();
}

class _MetadadosJogoMemoriaState extends State<MetadadosJogoMemoria> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sobre - Jogo da memória",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(padding: EdgeInsets.only(top: 16)),
              Center(
                child: Image.asset(
                  Imagens.metadados,
                  height: screenWidth * 0.75,
                  width: screenWidth * 0.75,
                ),
              ),
              const SizedBox(height: 18),
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
                      text: "Jogo da memória - Indígenas do Tocantins",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 3),
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
              const SizedBox(height: 3),
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
                          "jogo da memória que conta com as 8 etnias indígenas do Tocantins, apresentando 3 níveis de difuldade para estimular o raciocínio lógico e a concentração. ",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 3),
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
                      text: "ODA, Geografia, Tocantins, Jogo da memória.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 3),
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
              const SizedBox(height: 3),
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
              const SizedBox(height: 3),
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
                      text: "educação básica de geografia 6º e 7º ano.",
                      style: TextStyle(color: Color(0xFF6cabb0)),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 3),
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
                      text: "fácil, médio, difícil.",
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
