// ignore_for_file: prefer_const_constructors

import "dart:math";
import 'dart:async';

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:confetti/confetti.dart";
import "package:geograpp/utilitarios/Imagens.dart";
import 'package:audioplayers/audioplayers.dart';
import "package:geograpp/utilitarios/Sons.dart";
import "package:geograpp/utilitarios/Textos.dart";

class Memoria extends StatefulWidget {
  final String dificuldade;
  final int qtdCartas;
  const Memoria(
      {super.key, required this.dificuldade, required this.qtdCartas});

  @override
  State<Memoria> createState() => _MemoriaState();
}

class _MemoriaState extends State<Memoria> {
  List<int> _numeros = [];
  late String dificuldade;
  late int _segundosPassados = 0;
  late Timer? _timer = null;
  late String _imagemMago = "";
  late int qtdCartas;
  late ConfettiController _confettiController;
  late List<bool> _imagemEscondida;
  late List<bool> _match;
  late String _imagemVitoria;
  late String _curiosidadeVitoria;
  int tentativas = 0;
  int ultimoIndiceAberto = 99;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    dificuldade = widget.dificuldade;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    qtdCartas = widget.qtdCartas;
    _numeros = gerarValores(qtdCartas);
    _imagemEscondida = List.filled(qtdCartas, true);
    _match = List.filled(qtdCartas, false);
    _imagemMago = Imagens.magoOla;
    _iniciarCronometro();
    controlarImagemMago("ola");
  }

  bool _jogoCompleto = false;
  bool _fechandoImagensAutomaticamente = false;

  void controlarImagemMago(String palavra) {
    // Palavra a = acertei, e = errei, g = ganhei, n = neutro
    Random r = Random();
    int numeroAleatorio;
    setState(() {
      switch (palavra) {
        case "a":
          numeroAleatorio = r.nextInt(2);
          if (numeroAleatorio == 0) {
            _imagemMago = Imagens.magoMuitoBem;
            _iniciarCronometro();
          } else {
            _imagemMago = Imagens.magoBoa;
            _iniciarCronometro();
          }
          break;
        case "e":
          _imagemMago = Imagens.magoOps;
          _iniciarCronometro();
          break;
        case "g":
          _imagemMago = Imagens.magoParabens;
          _iniciarCronometro();
          break;
        case "ola":
          _iniciarCronometro();
          _timer = Timer.periodic(Duration(seconds: 1), (timer) {
            if (_segundosPassados == 4) {
              _imagemMago = Imagens.magoNeutro;
            }
          });
          break;
      }
    });
  }

  void _iniciarCronometro() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _segundosPassados = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _segundosPassados++;
          //Img do mago quando alguem esta afk
          if (_segundosPassados > 16) {
            if (_imagemMago != Imagens.magoVcTaAi &&
                _imagemMago != Imagens.magoPreguica &&
                _imagemMago != Imagens.magoParabens) {
              _imagemMago = Random().nextBool()
                  ? Imagens.magoPreguica
                  : Imagens.magoVcTaAi;
            }
          }
        });
      }
    });
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

  void _certaRespostaSom() async {
    await _audioPlayer.play(AssetSource(Sons.certo));
  }

  void _respostaErradaSom() async {
    await _audioPlayer.play(AssetSource(Sons.errado));
  }

  void gerarInformacoesVitoria() {
    Random r = Random();
    int num = r.nextInt(4);
    switch (num) {
      case 0:
        _curiosidadeVitoria = Textos.indigenasArtesanato;
        _imagemVitoria = Imagens.indigenasArtesanato;
        break;
      case 1:
        _curiosidadeVitoria = Textos.indigenasColheita;
        _imagemVitoria = Imagens.indigenasColheita;
        break;
      case 2:
        _curiosidadeVitoria = Textos.indigenasNavegando;
        _imagemVitoria = Imagens.indigenasNavegando;
        break;
      case 3:
        _curiosidadeVitoria = Textos.indigenasPinturasCorporais;
        _imagemVitoria = Imagens.indigenasPinturasCorporais;
        break;
    }
  }

  //Gerar valores aleatorios para a combinação de imagens do jogo da memoria
  List<int> gerarValores(int qtdCartas) {
    List<int> lista = [];
    while (lista.length < qtdCartas) {
      int numero = Random().nextInt(qtdCartas);
      if (!lista.contains(numero)) {
        lista.add(numero);
      }
    }

    return lista;
  }

  List<GestureDetector> gerarGestures(double tamanho) {
    List<GestureDetector> lista = [];
    for (int i = 0; i < qtdCartas; i++) {
      if (dificuldade == "facil" && _numeros[i] > 2) {
        // Caso passe das 3 imagens o if recalcula os valores para as imagens se repetirem do 1 ao 3 ou do indice 0 ao 2
        _numeros[i] = _numeros[i] - 3;
      }
      // Caso passe das 6 imagens o if recalcula os valores para as imagens se repetirem do 1 ao 6 ou do indice 0 ao 5
      if (dificuldade == "medio" && _numeros[i] > 5) {
        _numeros[i] = _numeros[i] - 6;
      }
      // Caso passe das 8 imagens o if recalcula os valores para as imagens se repetirem do 1 ao 8 ou do indice 0 ao 7
      else if (dificuldade == "dificil" && _numeros[i] > 7) {
        _numeros[i] = _numeros[i] - 8;
      }

      GestureDetector gestureDetector = GestureDetector(
        onTap: () {
          if (!_fechandoImagensAutomaticamente) {
            setState(() {
              //condicao para verificar se as cartas abertas formaram par
              bool par =
                  _imagemEscondida.where((e) => e == false).toList().length %
                          2 ==
                      1;

              //Impede a troca de imagens que ja deram match e impede a troca de uma mesma imagem
              if (!_match[i] && ultimoIndiceAberto != i) {
                _imagemEscondida[i] = !_imagemEscondida[i];
              }

              //Retorna uma lista dos indices do _numeros gerados que estão abertos e que ainda não deram match, os que já deram os dados não são puxados
              List indicesAbertos = _imagemEscondida
                  .asMap()
                  .keys
                  .where((element) =>
                      !_imagemEscondida[element] && !_match[element])
                  .toList();

              ultimoIndiceAberto = indicesAbertos.isNotEmpty
                  ? indicesAbertos[indicesAbertos.length - 1]
                  : 99;

              //Verifica se os 2 ultimos itens abertos combinam se sim o booleano é marcado como true
              if (indicesAbertos.length >= 2) {
                int valor1 = _numeros[indicesAbertos[0]];
                int valor2 = _numeros[indicesAbertos[1]];

                if (valor1 == valor2) {
                  tentativas++;
                  //att a img do mago
                  controlarImagemMago("a");
                  _match[indicesAbertos[0]] = !_match[indicesAbertos[0]];
                  _match[indicesAbertos[1]] = !_match[indicesAbertos[1]];
                  _certaRespostaSom();
                }
              }

              //Fecha as 2 ultimas cartas caso não aconteça o match entre elas
              indicesAbertos = _imagemEscondida
                  .asMap()
                  .keys
                  .where((element) =>
                      !_imagemEscondida[element] && !_match[element])
                  .toList();
              if (par && indicesAbertos.length >= 2) {
                tentativas++;
                _fechandoImagensAutomaticamente = true;
                //att a imagem do mago
                controlarImagemMago("e");
                _respostaErradaSom();
                Future.delayed(const Duration(milliseconds: 1000), () {
                  setState(() {
                    _imagemEscondida[indicesAbertos[0]] =
                        !_imagemEscondida[indicesAbertos[0]];
                    _imagemEscondida[indicesAbertos[1]] =
                        !_imagemEscondida[indicesAbertos[1]];
                    _fechandoImagensAutomaticamente = false;
                  });
                });
              }
              int qtdMatchs =
                  _match.where((element) => element == true).toList().length;
              if (dificuldade == "facil" && qtdMatchs == 6) {
                controlarImagemMago("g");
                _jogoCompleto = !_jogoCompleto;
                gerarInformacoesVitoria();
                dispararConfete();
              } else if (dificuldade == "medio" && qtdMatchs == 12) {
                controlarImagemMago("g");
                _jogoCompleto = !_jogoCompleto;
                gerarInformacoesVitoria();
                dispararConfete();
              } else if (dificuldade == "dificil" && qtdMatchs == 16) {
                controlarImagemMago("g");
                _jogoCompleto = !_jogoCompleto;
                gerarInformacoesVitoria();
                dispararConfete();
              }
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: _match[i] ? Colors.green : Color(0xFF303d72),
                  width: 2.0),
              borderRadius: BorderRadius.circular(8.0)),
          child: _imagemEscondida[i]
              ? Image.asset(Imagens.bandeiraTocantins)
              : Image.asset(
                  "lib/imagens/memoria/${(_numeros[i] + 1).toString()}.jpg",
                  fit: BoxFit.cover,
                ),
        ),
      );

      lista.add(gestureDetector);
    }
    return lista;
  }

  Widget _abrirModal(double tamanho) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_imagemVitoria),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.70), BlendMode.dstATop),
            ),
            borderRadius:
                BorderRadius.circular(20.0), // Define a borda arredondada
          ),
          height: tamanho * 0.75, // Altura da modal
          width: tamanho * 0.75, // Larg
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Parabéns! Você completou o jogo da memoria!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: tamanho * 0.04, color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Conheça informações sobre as etinias locais do Tocantins no botão de saiba mais.",
                  style: TextStyle(color: Colors.white),
                ),
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
                  _curiosidadeVitoria,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tamanho * 0.15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF6cabb0))),
                    onPressed: () {
                      // Fechar o modal e reiniciar o jogo
                      setState(() {
                        _jogoCompleto = false;
                        _numeros = gerarValores(qtdCartas);
                        tentativas = 0;
                        _imagemEscondida.fillRange(
                            0, _imagemEscondida.length, true);
                        _match.fillRange(0, _match.length, false);
                        _imagemMago = Imagens.magoNeutro;
                        _imagemVitoria = "";
                        _curiosidadeVitoria = "";
                        _confettiController.stop;
                        _iniciarCronometro();
                      });
                    },
                    child: const Text(
                      'Jogar novamente',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAxisCout() {
    if (qtdCartas == 6) {
      return 2;
    } else if (qtdCartas == 12) {
      return 3;
    } else {
      return 4;
    }
  }

  getAspectRatio() {
    if (qtdCartas == 6) {
      return 1.2;
    } else if (qtdCartas == 12) {
      return 1.0;
    } else {
      return 0.8;
    }
  }

  getDIficuldade() {
    if (qtdCartas == 6) {
      return "Fácil";
    } else if (qtdCartas == 12) {
      return "Médio";
    } else {
      return "Difícil";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jogo da memória - Dificuldade ${getDIficuldade()}",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF303d72),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.04),
                  child: Text(
                    "$tentativas",
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.06),
                  ),
                ),
                Image.asset(
                  _imagemMago,
                  height: screenWidth * 0.25,
                  width: screenWidth * 0.25,
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: GridView.count(
                      crossAxisCount: getAxisCout(),
                      childAspectRatio: getAspectRatio(),
                      children: gerarGestures(screenWidth),
                    ),
                  ),
                  if (_jogoCompleto) // Mostrar o modal apenas se o jogo estiver completo
                    _abrirModal(screenWidth),
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
            ),
          ],
        ),
      ),
    );
  }
}
