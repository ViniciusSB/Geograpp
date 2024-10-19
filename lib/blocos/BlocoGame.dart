// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import "dart:math";
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import "package:confetti/confetti.dart";
import 'package:geograpp/utilitarios/Textos.dart';

class BlocoGame extends StatefulWidget {
  final String imagemQuebraCabeca;
  const BlocoGame({super.key, required this.imagemQuebraCabeca});

  @override
  State<BlocoGame> createState() => _BlocoGameState();
}

class _BlocoGameState extends State<BlocoGame> {
  late String imagemQuebraCabeca;
  late List<String?> _imagens = [];
  late int _segundosPassados = 0;
  int nivel = 0;
  late ConfettiController _confettiController;
  late Timer? _timer = null;
  bool jogoEmbaralhado = false;
  int _celulaVazia = 99;
  bool jogoCompleto = false;
  int movimentos = 0;
  late List<String> curiosidades = [];

  @override
  void initState() {
    super.initState();
    imagemQuebraCabeca = widget.imagemQuebraCabeca;
    nivel == 0 ? 3 : nivel;
    _imagens = carregarImagens();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));

    switch (imagemQuebraCabeca) {
      case 'relogio':
        curiosidades.add(Textos.relogio1);
        curiosidades.add(Textos.relogio2);
        curiosidades.add(Textos.relogio3);
        break;
      case 'monumento':
        curiosidades.add(Textos.monumento1);
        curiosidades.add(Textos.monumento2);
        curiosidades.add(Textos.monumento3);
        break;
      case 'memorial':
        curiosidades.add(Textos.memorial1);
        curiosidades.add(Textos.memorial2);
        curiosidades.add(Textos.memorial3);
        break;
    }
  }

  List<GestureDetector> gerarGestures(double tamanho) {
    List<GestureDetector> lista = [];

    for (int i = 0; i < _imagens.length; i++) {
      GestureDetector gestureDetector = GestureDetector(
        onTap: () {
          if (jogoEmbaralhado) {
            retornarIndiceVazio();
            realizarTroca(i);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: _imagens[i] != null
                    ? Image.asset(
                        _imagens[i]!,
                        fit: BoxFit.fill,
                      )
                    : Container(color: Colors.grey),
              ),
              if (_imagens[i] != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Text(
                      extrairNumero(_imagens[i]!),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: tamanho * 0.04,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
      lista.add(gestureDetector);
    }

    return lista;
  }

  String extrairNumero(String caminho) {
    String fileName = caminho.split('/').last;
    String number = fileName.split('-').last.split('.').first;
    return number;
  }

  embaralharCartas() {
    jogoEmbaralhado = true;
    inserirImagens();

    //_imagens = carregarImagens();

    embaralharEmMovimetosValidos(_imagens.length);

    //Zera o cronometro e as tentativas sempre que as cartas sao embaralhadas
    setState(() {
      _segundosPassados = 0;
      movimentos = 0;
    });

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  embaralharEmMovimetosValidos(int tamanhoMatriz) {
    if (nivel == 4) {
      int posicaoVazia = 15;
      List<int> movimentosValidos = [-4, 4, -1, 1];
      //Realiza o embaralhamento aleatorio das cartas em 100 movimentos
      for (int i = 0; i < 500; i++) {
        List<int> movimentosPossiveis = [];

        for (int movimento in movimentosValidos) {
          int novaPosicao = posicaoVazia + movimento;

          // Verifica se o movimento é valido e não foge dos limites da matriz
          if (tamanhoMatriz == 16) {
            if (novaPosicao >= 0 &&
                novaPosicao < 16 &&
                !((posicaoVazia % 4 == 0 && movimento == -1) ||
                    (posicaoVazia % 4 == 3 && movimento == 1))) {
              movimentosPossiveis.add(movimento);
            }
          }
        }

        if (movimentosPossiveis.isNotEmpty) {
          int movimentoEscolhido = (movimentosPossiveis..shuffle()).first;
          int celulaEscolhida = posicaoVazia + movimentoEscolhido;

          setState(() {
            _imagens[posicaoVazia] = _imagens[celulaEscolhida];
            _imagens[celulaEscolhida] = null;
          });

          posicaoVazia = celulaEscolhida;
        }
      }
    } else {
      int posicaoVazia = 8;
      List<int> movimentosValidos = [-3, 3, -1, 1];
      //Realiza o embaralhamento aleatorio das cartas em 100 movimentos
      for (int i = 0; i < 100; i++) {
        List<int> movimentosPossiveis = [];

        for (int movimento in movimentosValidos) {
          int novaPosicao = posicaoVazia + movimento;

          // Verifica se o movimento é valido e não foge dos limites da matriz
          if (tamanhoMatriz == 9) {
            if (novaPosicao >= 0 &&
                novaPosicao < 9 &&
                !((posicaoVazia % 3 == 0 && movimento == -1) ||
                    (posicaoVazia % 3 == 2 && movimento == 1))) {
              movimentosPossiveis.add(movimento);
            }
          }
        }

        if (movimentosPossiveis.isNotEmpty) {
          int movimentoEscolhido = (movimentosPossiveis..shuffle()).first;
          int celulaEscolhida = posicaoVazia + movimentoEscolhido;

          setState(() {
            _imagens[posicaoVazia] = _imagens[celulaEscolhida];
            _imagens[celulaEscolhida] = null;
          });

          posicaoVazia = celulaEscolhida;
        }
      }
    }
  }

  retornarIndiceVazio() {
    _celulaVazia = _imagens.indexWhere((e) => e == null);
  }

  realizarTroca(int indiceSelecionado) {
    if (nivel == 4) {
      if ((indiceSelecionado % 4 != 0 &&
              indiceSelecionado - 1 == _celulaVazia) ||
          (indiceSelecionado % 4 != 3 &&
              indiceSelecionado + 1 == _celulaVazia) ||
          indiceSelecionado - 4 == _celulaVazia ||
          indiceSelecionado + 4 == _celulaVazia) {
        movimentos++;
        if (movimentos == 1) {
          setState(() {
            _iniciarCronometro();
          });
        }
        String? auxiliar = _imagens[indiceSelecionado];
        setState(() {
          _imagens[indiceSelecionado] = null;
          _imagens[_celulaVazia] = auxiliar;
        });
      }
    } else {
      if ((indiceSelecionado % 3 != 0 &&
              indiceSelecionado - 1 == _celulaVazia) ||
          (indiceSelecionado % 3 != 2 &&
              indiceSelecionado + 1 == _celulaVazia) ||
          indiceSelecionado - 3 == _celulaVazia ||
          indiceSelecionado + 3 == _celulaVazia) {
        movimentos++;
        if (movimentos == 1) {
          setState(() {
            _iniciarCronometro();
          });
        }
        String? auxiliar = _imagens[indiceSelecionado];
        setState(() {
          _imagens[indiceSelecionado] = null;
          _imagens[_celulaVazia] = auxiliar;
        });
      }
    }

    verificarJogoCompleto();
  }

  verificarJogoCompleto() {
    List<String?> imagensOrdenadas = carregarImagens();

    bool condicao = ListEquality().equals(_imagens, imagensOrdenadas);

    if (condicao) {
      _timer?.cancel();
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          if (imagemQuebraCabeca == "relogio") {
            if (nivel == 4)
              _imagens[15] = "lib/imagens/blocos/relogio/4x4/relogio-16.jpg";
            if (nivel == 3)
              _imagens[8] = "lib/imagens/blocos/relogio/3x3/relogio-9.jpg";
          } else if (imagemQuebraCabeca == "memorial") {
            if (nivel == 4)
              _imagens[15] = "lib/imagens/blocos/memorial/4x4/memorial-16.png";
            if (nivel == 3)
              _imagens[8] = "lib/imagens/blocos/memorial/3x3/memorial-9.png";
          } else {
            if (nivel == 4)
              _imagens[15] =
                  "lib/imagens/blocos/monumento/4x4/monumento-16.jpg";
            if (nivel == 3)
              _imagens[8] = "lib/imagens/blocos/monumento/3x3/monumento-9.jpg";
          }
        });
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          jogoCompleto = condicao;
          dispararConfete();
        });
      });
      curiosidades.shuffle();
    }
  }

  String mensagemDeVitoria() {
    int minutos = 0;
    if (_segundosPassados >= 60) {
      minutos = _segundosPassados ~/ 60;
    }
    int segundosRestantes = _segundosPassados % 60;
    String texto = "";
    if (minutos != 0) {
      texto =
          "Você finalizou com um tempo de $minutos:$segundosRestantes e $movimentos movimentos.";
    } else {
      texto =
          "Você finalizou com um tempo de 00:$segundosRestantes e $movimentos movimentos.";
    }
    return texto;
  }

  mudarNivel(int numero) {
    if (numero == 3) {
      setState(() {
        nivel = 3;
        _imagens = carregarImagens();
      });
    }
    if (numero == 4) {
      setState(() {
        nivel = 4;
        _imagens = carregarImagens();
      });
    }
  }

  List<String?> carregarImagens() {
    List<String?> imagens = [];
    switch (imagemQuebraCabeca) {
      case 'relogio':
        if (nivel == 3 || nivel == 0) {
          imagens.addAll([
            "lib/imagens/blocos/relogio/3x3/relogio-1.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-2.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-3.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-4.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-5.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-6.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-7.jpg",
            "lib/imagens/blocos/relogio/3x3/relogio-8.jpg",
            null,
          ]);
        } else if (nivel == 4) {
          imagens.addAll([
            "lib/imagens/blocos/relogio/4x4/relogio-1.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-2.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-3.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-4.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-5.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-6.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-7.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-8.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-9.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-10.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-11.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-12.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-13.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-14.jpg",
            "lib/imagens/blocos/relogio/4x4/relogio-15.jpg",
            null,
          ]);
        }
        break;
      case 'monumento':
        if (nivel == 3 || nivel == 0) {
          imagens.addAll([
            "lib/imagens/blocos/monumento/3x3/monumento-1.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-2.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-3.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-4.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-5.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-6.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-7.jpg",
            "lib/imagens/blocos/monumento/3x3/monumento-8.jpg",
            null,
          ]);
        } else if (nivel == 4) {
          imagens.addAll([
            "lib/imagens/blocos/monumento/4x4/monumento-1.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-2.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-3.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-4.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-5.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-6.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-7.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-8.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-9.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-10.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-11.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-12.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-13.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-14.jpg",
            "lib/imagens/blocos/monumento/4x4/monumento-15.jpg",
            null,
          ]);
        }
        break;
      case 'memorial':
        if (nivel == 3 || nivel == 0) {
          imagens.addAll([
            "lib/imagens/blocos/memorial/3x3/memorial-1.png",
            "lib/imagens/blocos/memorial/3x3/memorial-2.png",
            "lib/imagens/blocos/memorial/3x3/memorial-3.png",
            "lib/imagens/blocos/memorial/3x3/memorial-4.png",
            "lib/imagens/blocos/memorial/3x3/memorial-5.png",
            "lib/imagens/blocos/memorial/3x3/memorial-6.png",
            "lib/imagens/blocos/memorial/3x3/memorial-7.png",
            "lib/imagens/blocos/memorial/3x3/memorial-8.png",
            null,
          ]);
        } else if (nivel == 4) {
          imagens.addAll([
            "lib/imagens/blocos/memorial/4x4/memorial-1.png",
            "lib/imagens/blocos/memorial/4x4/memorial-2.png",
            "lib/imagens/blocos/memorial/4x4/memorial-3.png",
            "lib/imagens/blocos/memorial/4x4/memorial-4.png",
            "lib/imagens/blocos/memorial/4x4/memorial-5.png",
            "lib/imagens/blocos/memorial/4x4/memorial-6.png",
            "lib/imagens/blocos/memorial/4x4/memorial-7.png",
            "lib/imagens/blocos/memorial/4x4/memorial-8.png",
            "lib/imagens/blocos/memorial/4x4/memorial-9.png",
            "lib/imagens/blocos/memorial/4x4/memorial-10.png",
            "lib/imagens/blocos/memorial/4x4/memorial-11.png",
            "lib/imagens/blocos/memorial/4x4/memorial-12.png",
            "lib/imagens/blocos/memorial/4x4/memorial-13.png",
            "lib/imagens/blocos/memorial/4x4/memorial-14.png",
            "lib/imagens/blocos/memorial/4x4/memorial-15.png",
            null,
          ]);
        }
        break;
    }

    return imagens;
  }

  void inserirImagens() {
    switch (imagemQuebraCabeca) {
      case 'relogio':
        if (nivel == 3) {
          _imagens[0] = "lib/imagens/blocos/relogio/3x3/relogio-1.jpg";
          _imagens[1] = "lib/imagens/blocos/relogio/3x3/relogio-2.jpg";
          _imagens[2] = "lib/imagens/blocos/relogio/3x3/relogio-3.jpg";
          _imagens[3] = "lib/imagens/blocos/relogio/3x3/relogio-4.jpg";
          _imagens[4] = "lib/imagens/blocos/relogio/3x3/relogio-5.jpg";
          _imagens[5] = "lib/imagens/blocos/relogio/3x3/relogio-6.jpg";
          _imagens[6] = "lib/imagens/blocos/relogio/3x3/relogio-7.jpg";
          _imagens[7] = "lib/imagens/blocos/relogio/3x3/relogio-8.jpg";
          _imagens[8] = null;
        } else if (nivel == 4) {
          _imagens[0] = "lib/imagens/blocos/relogio/4x4/relogio-1.jpg";
          _imagens[1] = "lib/imagens/blocos/relogio/4x4/relogio-2.jpg";
          _imagens[2] = "lib/imagens/blocos/relogio/4x4/relogio-3.jpg";
          _imagens[3] = "lib/imagens/blocos/relogio/4x4/relogio-4.jpg";
          _imagens[4] = "lib/imagens/blocos/relogio/4x4/relogio-5.jpg";
          _imagens[5] = "lib/imagens/blocos/relogio/4x4/relogio-6.jpg";
          _imagens[6] = "lib/imagens/blocos/relogio/4x4/relogio-7.jpg";
          _imagens[7] = "lib/imagens/blocos/relogio/4x4/relogio-8.jpg";
          _imagens[8] = "lib/imagens/blocos/relogio/4x4/relogio-9.jpg";
          _imagens[9] = "lib/imagens/blocos/relogio/4x4/relogio-10.jpg";
          _imagens[10] = "lib/imagens/blocos/relogio/4x4/relogio-11.jpg";
          _imagens[11] = "lib/imagens/blocos/relogio/4x4/relogio-12.jpg";
          _imagens[12] = "lib/imagens/blocos/relogio/4x4/relogio-13.jpg";
          _imagens[13] = "lib/imagens/blocos/relogio/4x4/relogio-14.jpg";
          _imagens[14] = "lib/imagens/blocos/relogio/4x4/relogio-15.jpg";
          _imagens[15] = null;
        }
        break;
      case 'monumento':
        if (nivel == 3) {
          _imagens[0] = "lib/imagens/blocos/monumento/3x3/monumento-1.jpg";
          _imagens[1] = "lib/imagens/blocos/monumento/3x3/monumento-2.jpg";
          _imagens[2] = "lib/imagens/blocos/monumento/3x3/monumento-3.jpg";
          _imagens[3] = "lib/imagens/blocos/monumento/3x3/monumento-4.jpg";
          _imagens[4] = "lib/imagens/blocos/monumento/3x3/monumento-5.jpg";
          _imagens[5] = "lib/imagens/blocos/monumento/3x3/monumento-6.jpg";
          _imagens[6] = "lib/imagens/blocos/monumento/3x3/monumento-7.jpg";
          _imagens[7] = "lib/imagens/blocos/monumento/3x3/monumento-8.jpg";
          _imagens[8] = null;
        } else if (nivel == 4) {
          _imagens[0] = "lib/imagens/blocos/monumento/4x4/monumento-1.jpg";
          _imagens[1] = "lib/imagens/blocos/monumento/4x4/monumento-2.jpg";
          _imagens[2] = "lib/imagens/blocos/monumento/4x4/monumento-3.jpg";
          _imagens[3] = "lib/imagens/blocos/monumento/4x4/monumento-4.jpg";
          _imagens[4] = "lib/imagens/blocos/monumento/4x4/monumento-5.jpg";
          _imagens[5] = "lib/imagens/blocos/monumento/4x4/monumento-6.jpg";
          _imagens[6] = "lib/imagens/blocos/monumento/4x4/monumento-7.jpg";
          _imagens[7] = "lib/imagens/blocos/monumento/4x4/monumento-8.jpg";
          _imagens[8] = "lib/imagens/blocos/monumento/4x4/monumento-9.jpg";
          _imagens[9] = "lib/imagens/blocos/monumento/4x4/monumento-10.jpg";
          _imagens[10] = "lib/imagens/blocos/monumento/4x4/monumento-11.jpg";
          _imagens[11] = "lib/imagens/blocos/monumento/4x4/monumento-12.jpg";
          _imagens[12] = "lib/imagens/blocos/monumento/4x4/monumento-13.jpg";
          _imagens[13] = "lib/imagens/blocos/monumento/4x4/monumento-14.jpg";
          _imagens[14] = "lib/imagens/blocos/monumento/4x4/monumento-15.jpg";
          _imagens[15] = null;
        }
        break;
      case 'memorial':
        if (nivel == 3) {
          _imagens[0] = "lib/imagens/blocos/memorial/3x3/memorial-1.png";
          _imagens[1] = "lib/imagens/blocos/memorial/3x3/memorial-2.png";
          _imagens[2] = "lib/imagens/blocos/memorial/3x3/memorial-3.png";
          _imagens[3] = "lib/imagens/blocos/memorial/3x3/memorial-4.png";
          _imagens[4] = "lib/imagens/blocos/memorial/3x3/memorial-5.png";
          _imagens[5] = "lib/imagens/blocos/memorial/3x3/memorial-6.png";
          _imagens[6] = "lib/imagens/blocos/memorial/3x3/memorial-7.png";
          _imagens[7] = "lib/imagens/blocos/memorial/3x3/memorial-8.png";
          _imagens[8] = null;
        } else if (nivel == 4) {
          _imagens[0] = "lib/imagens/blocos/memorial/4x4/memorial-1.png";
          _imagens[1] = "lib/imagens/blocos/memorial/4x4/memorial-2.png";
          _imagens[2] = "lib/imagens/blocos/memorial/4x4/memorial-3.png";
          _imagens[3] = "lib/imagens/blocos/memorial/4x4/memorial-4.png";
          _imagens[4] = "lib/imagens/blocos/memorial/4x4/memorial-5.png";
          _imagens[5] = "lib/imagens/blocos/memorial/4x4/memorial-6.png";
          _imagens[6] = "lib/imagens/blocos/memorial/4x4/memorial-7.png";
          _imagens[7] = "lib/imagens/blocos/memorial/4x4/memorial-8.png";
          _imagens[8] = "lib/imagens/blocos/memorial/4x4/memorial-9.png";
          _imagens[9] = "lib/imagens/blocos/memorial/4x4/memorial-10.png";
          _imagens[10] = "lib/imagens/blocos/memorial/4x4/memorial-11.png";
          _imagens[11] = "lib/imagens/blocos/memorial/4x4/memorial-12.png";
          _imagens[12] = "lib/imagens/blocos/memorial/4x4/memorial-13.png";
          _imagens[13] = "lib/imagens/blocos/memorial/4x4/memorial-14.png";
          _imagens[14] = "lib/imagens/blocos/memorial/4x4/memorial-15.png";
          _imagens[15] = null;
        }
        break;
    }
  }

  void dispararConfete() {
    _confettiController.play();
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _confettiController.dispose();
    super.dispose();
  }

  void _iniciarCronometro() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _segundosPassados++; // Atualizar os segundos passados a cada segundo
      });
    });
  }

  Widget _abrirModal(double heigth, double width) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF303d72),
            borderRadius:
                BorderRadius.circular(20.0), // Define a borda arredondada
          ),
          height: heigth * 0.50, // Altura da modal
          width: width * 0.75, // Larg
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _confettiController.stop();
                          jogoCompleto = false;
                          jogoEmbaralhado = false;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  'Parabéns! Você completou o jogo dos blocos deslizantes!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: width * 0.04, color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(mensagemDeVitoria(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Curiosidade",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  curiosidades[0],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String obterNome() {
    if (imagemQuebraCabeca == "relogio") {
      return "Relógio do sol";
    } else if (imagemQuebraCabeca == "monumento") {
      return "Monumento aos Dezoito do Forte de Copacabana";
    } else {
      return "Memorial Coluna Prestes";
    }
  }

  getAxis() {
    if (nivel == 0) {
      nivel = 3;
    }
    if (nivel == 3) {
      return 3;
    }
    if (nivel == 4) {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tela = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blocos deslizantes",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF6081DB),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: tela.height,
          color: const Color(0xFF303d72),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  right: tela.width * 0.04,
                  left: tela.width * 0.04,
                  top: tela.width * 0.04),
              child: Text(
                obterNome(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontSize: tela.width * 0.06),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: tela.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Tentativas $movimentos",
                      style: TextStyle(
                          color: Colors.white, fontSize: tela.width * 0.04),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Tempo $_segundosPassados",
                      style: TextStyle(
                          color: Colors.white, fontSize: tela.width * 0.04),
                    )
                  ],
                )),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: tela.width * 0.04,
                      vertical: tela.width * 0.02),
                  child: GridView.count(
                    crossAxisCount: getAxis(),
                    childAspectRatio: 1.0,
                    children: gerarGestures(tela.width),
                    shrinkWrap: true,
                  ),
                ),
                if (jogoCompleto) _abrirModal(tela.height, tela.width),
                Align(
                  alignment: Alignment.topCenter, // Posição do confete
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: -pi / 2, // Explodir para cima
                    emissionFrequency: 0.05, // Frequência de emissão
                    numberOfParticles: 50,
                    gravity: 0.1, // Gravidade para confetes caírem lentamente
                    shouldLoop: false,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            ElevatedButton(
              onPressed: embaralharCartas,
              child: Text(
                "Embaralhar cartas",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF3DDBAC))),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Níveis",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => mudarNivel(3),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.blue.shade900),
                        alignment: Alignment.center,
                        child: Text(
                          "3x3",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (nivel == 3)
                      Container(
                        width: 50,
                        height: 3, // altura da linha
                        color: Colors.green,
                      ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => mudarNivel(4),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.blue.shade900),
                        alignment: Alignment.center,
                        child: Text(
                          "4x4",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (nivel == 4)
                      Container(
                        width: 50,
                        height: 2,
                        color: Colors.green,
                      ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
