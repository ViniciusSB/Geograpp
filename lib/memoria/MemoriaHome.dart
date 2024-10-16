// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/memoria/Memoria.dart';
import 'package:geograpp/memoria/SaibaMaisIndigenas.dart';
import 'package:geograpp/memoria/MetadadosJogoMemoria.dart';

class MemoriaHome extends StatefulWidget {
  const MemoriaHome({super.key});

  @override
  State<MemoriaHome> createState() => _MemoriaHomeState();
}

class _MemoriaHomeState extends State<MemoriaHome> {
  _navegacaoJogoDaMemoria(String dificuldade, int qtdCartas) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Memoria(
                  dificuldade: dificuldade,
                  qtdCartas: qtdCartas,
                )));
  }

  _navegacaoMetadados() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MetadadosJogoMemoria()));
  }

  _navegacaoSaibaMais() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SaibaMaisIndigenas()));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.08, bottom: screenWidth * 0.04),
              child: Text(
                "Jogo da Memória - Indigenas do Tocantins",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF866E68),
                ),
              ),
            ),
            Image.asset(
              Imagens.indigenasLogo,
              height: screenWidth * 0.75,
              width: screenWidth * 0.75,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Dificuldades",
              style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF6cabb0))),
                    onPressed: () => _navegacaoJogoDaMemoria("facil", 6),
                    child: Text("Fácil",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white))),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF6cabb0))),
                    onPressed: () => _navegacaoJogoDaMemoria("medio", 12),
                    child: Text("Médio",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white))),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF6cabb0))),
                    onPressed: () => _navegacaoJogoDaMemoria("dificil", 16),
                    child: Text("Difícil",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04, color: Colors.white)))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _navegacaoMetadados,
                  child: Row(
                    children: [
                      Text(
                        "Sobre",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6cabb0),
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.02,
                      horizontal: screenWidth * 0.04,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _navegacaoSaibaMais,
                  child: Row(
                    children: [
                      Text(
                        "Saiba Mais",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.more,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6cabb0),
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.02,
                      horizontal: screenWidth * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
