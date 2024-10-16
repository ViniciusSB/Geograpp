// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:geograpp/TelaInicial.dart";
import "package:geograpp/utilitarios/Imagens.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _navegacaoJogos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaInicial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geograpp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6081DB),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Imagens.unitins,
              width: screenWidth * 0.75,
              height: screenWidth * 0.75,
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Criador: ',
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.04),
                  ),
                  TextSpan(
                    text: 'Vinícius Santos Bessa',
                    style: TextStyle(
                        color: Color(0xFF60DBBF), fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Curso: ',
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.04),
                  ),
                  TextSpan(
                    text: 'Sistemas de informação',
                    style: TextStyle(
                        color: Color(0xFF60DBBF), fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Orientador: ',
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.04),
                  ),
                  TextSpan(
                    text: 'Prof. Me. Jeferson Moraes da Costa',
                    style: TextStyle(
                        color: Color(0xFF60DBBF), fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
            // Botão
            SizedBox(
              width: screenWidth * 0.8,
              height: 60.0,
              child: InkWell(
                onTap: _navegacaoJogos,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Imagens.jogos),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Acessar jogos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
