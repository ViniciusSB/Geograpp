// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/quiz/ComoJogarQuiz.dart';
import 'package:geograpp/quiz/SobreQuiz.dart';
import 'package:geograpp/quiz/QuizTocantins.dart';

class ConhecendoTocantins extends StatefulWidget {
  const ConhecendoTocantins({Key? key}) : super(key: key);

  @override
  State<ConhecendoTocantins> createState() => ConhecendoTocantinsState();
}

class ConhecendoTocantinsState extends State<ConhecendoTocantins> {
  void _abrirSaibaMais() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComoJogarQuiz()),
    );
  }

  void _abrirJogo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizTocantins()),
    );
  }

  void _abrirSobre() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SobreQuiz()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.08,
              bottom: screenWidth * 0.04,
            ),
            child: Text(
              "Quiz Tocantins",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Color(0xFF866E68),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth * 0.04,
          ),
          GestureDetector(
            onTap: _abrirJogo,
            child: Image.asset(
              Imagens.quiz,
              width: screenWidth * 0.75,
              height: screenWidth * 0.75,
            ),
          ),
          SizedBox(
            height: screenWidth * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _abrirSobre,
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
                onPressed: _abrirSaibaMais,
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
                  backgroundColor: Color(0xFF6cabb0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
