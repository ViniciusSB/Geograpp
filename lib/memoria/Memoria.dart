// ignore_for_file: prefer_const_constructors

import "dart:math";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:geograpp/utilitarios/Imagens.dart";

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
  late int qtdCartas;
  late List<bool> _imagemEscondida;
  late List<bool> _match;
  int tentativas = 0;
  int ultimoIndiceAberto = 99;

  @override
  void initState() {
    super.initState();
    dificuldade = widget.dificuldade;
    qtdCartas = widget.qtdCartas;
    _numeros = gerarValores(qtdCartas);
    _imagemEscondida = List.filled(qtdCartas, true);
    _match = List.filled(qtdCartas, false);
  }

  bool _jogoCompleto = false;
  bool _fechandoImagensAutomaticamente = false;

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
                  _match[indicesAbertos[0]] = !_match[indicesAbertos[0]];
                  _match[indicesAbertos[1]] = !_match[indicesAbertos[1]];
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
                _jogoCompleto = !_jogoCompleto;
              } else if (dificuldade == "medio" && qtdMatchs == 12) {
                _jogoCompleto = !_jogoCompleto;
              } else if (dificuldade == "dificil" && qtdMatchs == 16) {
                _jogoCompleto = !_jogoCompleto;
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
            color: Color(0xFF303d72),
            borderRadius:
                BorderRadius.circular(20.0), // Define a borda arredondada
          ),
          height: tamanho * 0.75, // Altura da modal
          width: tamanho * 0.75, // Larg
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Parabéns! Você completou o jogo da memoria!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: tamanho * 0.04, color: Colors.white),
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
                    });
                  },
                  child: const Text(
                    'Jogar novamente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.04),
              child: Text(
                "$tentativas",
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.06),
              ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
