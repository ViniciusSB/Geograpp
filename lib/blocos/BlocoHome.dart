// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geograpp/blocos/BlocoGame.dart';
import 'package:geograpp/blocos/SaibaMaisBloco.dart';
import 'package:geograpp/blocos/SobreBloco.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class BlocoHome extends StatefulWidget {
  const BlocoHome({super.key});

  @override
  State<BlocoHome> createState() => _BlocoHomeState();
}

class _BlocoHomeState extends State<BlocoHome> {
  _abrirBlocoGame(String imagem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocoGame(
                imagemQuebraCabeca: imagem
              )),
    );
  }

  void _navegarSobre() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SobreBloco()),
    );
  }

  void _navegarSaibaMais() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaibaMaisBloco()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tela = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: tela.width * 0.08,
          bottom: tela.width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Blocos deslizantes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF866E68),
                  fontWeight: FontWeight.bold,
                  fontSize: tela.width * 0.06,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Image.asset(
                Imagens.blocosLogo,
                width: tela.width * 0.75,
                height: tela.height * 0.4,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Escolha uma imagem abaixo para jogar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _abrirBlocoGame("relogio"),
                        child: Image.asset(
                          Imagens.relogio,
                          width: tela.width * 0.25,
                          height: tela.height * 0.1,
                        ),
                      ),
                      Text("Relógio do sol"),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _abrirBlocoGame("memorial"),
                        child: Image.asset(
                          Imagens.memorial,
                          width: tela.width * 0.25,
                          height: tela.height * 0.1,
                        ),
                      ),
                      Text("Memorial"),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _abrirBlocoGame("monumento"),
                        child: Image.asset(
                          Imagens.monumento,
                          width: tela.width * 0.25,
                          height: tela.height * 0.1,
                        ),
                      ),
                      Text("Monumento")
                    ],
                  )),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _navegarSobre,
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
                      backgroundColor: Color(0xFF3DDBAC),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _navegarSaibaMais,
                    child: Row(
                      children: [
                        Text(
                          "Como Jogar",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.gamepad,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DDBAC),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
