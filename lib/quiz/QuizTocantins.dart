import "dart:math";
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:geograpp/quiz/RevisarQuestao.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/utilitarios/Perguntas.dart';
import 'package:geograpp/utilitarios/Sons.dart';
import 'package:geograpp/utilitarios/Textos.dart';
import 'package:group_button/group_button.dart';
import "package:confetti/confetti.dart";
import 'package:audioplayers/audioplayers.dart';

class QuizTocantins extends StatefulWidget {
  const QuizTocantins({super.key});

  @override
  _QuizTocantinsState createState() => _QuizTocantinsState();
}

class _QuizTocantinsState extends State<QuizTocantins> {
  String _texto = Textos.instrucao1;
  int pontuacao = 0;
  int classificacao = 0;
  bool questaoFinalizada = false;
  bool certaResposta = false;
  bool jogoFinalizado = false;
  bool semResposta = false;
  late ConfettiController _confettiController;
  String? resposta;
  Map _questao = {};
  late List _perguntas;
  late Perguntas perguntaas;
  late List<Map<String, String>> listaDePerguntas;
  List<String> historicoRespostas = [];
  int _contador = 1;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    perguntaas = Perguntas();
    listaDePerguntas = perguntaas.perguntas;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  _navegacaoRevisarQuestao(List<Map<String, String>> lp, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RevisarQuestao(
          dadosQuestao: lp,
          index: index,
        ),
      ),
    );
  }

  void dispararConfete() {
    _confettiController.play();
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

  void _certaRespostaSom() async {
    await _audioPlayer.play(AssetSource(Sons.certo));
  }

  void _respostaErradaSom() async {
    await _audioPlayer.play(AssetSource(Sons.errado));
  }

  void _avancar() {
    _contador += 1;
    gerenciador();
  }

  void reiniciarJogo() {
    int nvlJogo = listaDePerguntas.length;
    listaDePerguntas = perguntaas.perguntas;
    pontuacao = 0;
    _confettiController.stop();
    classificacao = 0;
    certaResposta = false;
    jogoFinalizado = false;
    resposta = null;
    _contador = 3;
    if (nvlJogo == 5) {
      dificuldade(5);
    } else if (nvlJogo == 10) {
      dificuldade(10);
    } else {
      dificuldade(20);
    }
  }

  void verificarResposta() {
    if (resposta != null) {
      setState(() {
        semResposta = false;
        if (resposta == _questao["r"]) {
          certaResposta = true;
          pontuacao += 1;
          _certaRespostaSom();
        } else {
          certaResposta = false;
          _respostaErradaSom();
        }
        questaoFinalizada = true;
        int numQuestao = _contador - 3;
        listaDePerguntas[_contador - 4]["rd"] = resposta!; //resposta dada
        listaDePerguntas[_contador - 4]["nq"] = numQuestao.toString();
      });
    } else {
      setState(() {
        semResposta = true;
      });
    }
  }

  void gerarClassificacao() {
    int qtdPerguntas = listaDePerguntas.length;
    double score = pontuacao / qtdPerguntas;
    if (score >= 0 && score <= 0.39) {
      classificacao = 1;
    } else if (score >= 0.4 && score <= 0.59) {
      classificacao = 2;
    } else if (score >= 0.6 && score <= 0.79) {
      classificacao = 3;
    } else {
      classificacao = 4;
    }
  }

  void questao() {
    _contador += 1;
    resposta = null;
    if (_contador - 3 > listaDePerguntas.length) {
      setState(() {
        jogoFinalizado = true;
        _questao = {};
        gerarClassificacao();
        if (classificacao == 3 || classificacao == 4) {
          dispararConfete();
        }
      });
    } else {
      setState(() {
        questaoFinalizada = false;
        _questao = listaDePerguntas[_contador - 4];
        List<String> q = [];
        q.add(_questao["p1"]);
        q.add(_questao["p2"]);
        q.add(_questao["p3"]);
        q.add(_questao["r"]);
        q.shuffle();
        listaDePerguntas[_contador - 4]["p1"] = q[0];
        listaDePerguntas[_contador - 4]["p2"] = q[1];
        listaDePerguntas[_contador - 4]["p3"] = q[2];
        listaDePerguntas[_contador - 4]["p4"] = q[3];
        _perguntas = q;
      });
    }
  }

  void dificuldade(int qtdQuestoes) {
    //Embaralhando as questoes aleatoriamente
    listaDePerguntas.shuffle();
    listaDePerguntas = listaDePerguntas.sublist(0, qtdQuestoes);
    questao();
  }

  void gerenciador() {
    setState(() {
      switch (_contador) {
        case 2:
          _texto = Textos.instrucao2;
          break;
        case 3:
          _texto = Textos.instrucao3;
          break;
      }
    });
  }

  String retornarImagemDeFundo(String c) {
    String endereco = "";
    switch (c) {
      case "recursos econômicos - agronegócio":
        endereco = Imagens.agronegocio;
        break;
      case "recursos naturais":
        endereco = Imagens.recursosNaturais;
        break;
      case "arqueologia/geologia":
        endereco = Imagens.arqueologiaGeologia;
        break;
      case "recursos econômicos - pecuária":
        endereco = Imagens.pecuaria;
        break;
      case "clima e vegetação":
        endereco = Imagens.climaVegetacao;
        break;
      case "comunidades tradicionais":
        endereco = Imagens.comunidadesTradicionais;
        break;
      case "turismo":
        endereco = Imagens.turismo;
        break;
      case "relevo":
        endereco = Imagens.relevo;
        break;
      case "hidrografia":
        endereco = Imagens.hidrografia;
        break;
    }

    return endereco;
  }

  List<Widget> _historicoQuestoes() {
    List<Widget> leb = [];
    final mediaQuery = MediaQuery.of(context);

    for (int i = 0; i < listaDePerguntas.length; i++) {
      bool acerto = listaDePerguntas[i]["rd"] == listaDePerguntas[i]["r"];
      ElevatedButton eb = ElevatedButton(
        onPressed: () => _navegacaoRevisarQuestao(listaDePerguntas, i),
        style: ButtonStyle(
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all<Size>(
            Size.fromWidth(mediaQuery.size.width * 0.85),
          ),
          backgroundColor: MaterialStateProperty.all(
              acerto ? Colors.green : Colors.red[600]),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            listaDePerguntas[i]["q"]!,
            textAlign: TextAlign.left,
          ),
        ),
      );
      leb.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: eb,
        ),
      );
    }

    return leb;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conhecendo o Tocantins',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6081DB),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          if (_questao["c"] != null)
            Opacity(
              opacity: 0.25,
              child: Image.asset(
                retornarImagemDeFundo(_questao["c"]),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.topCenter, // Posição do confete
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirection: -pi / 2, // Explodir para cima
                          emissionFrequency: 0.05, // Frequência de emissão
                          numberOfParticles: 50,
                          gravity:
                              0.1, // Gravidade para confetes caírem lentamente
                          shouldLoop: false,
                        ),
                      ),
                      if (_contador > 3 &&
                          _contador <= listaDePerguntas.length + 3)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Categoria: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04),
                              ),
                              TextSpan(
                                text: '${_questao["c"]}',
                                style: TextStyle(
                                    color: Color(0xFF6cabb0),
                                    fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        ),
                      if (_contador > 3 &&
                          _contador <= listaDePerguntas.length + 3)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${_contador - 3}/',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04),
                              ),
                              TextSpan(
                                text: '${listaDePerguntas.length}',
                                style: TextStyle(
                                    color: const Color(0xFF6cabb0),
                                    fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (_contador >= 1 && _contador <= 3)
                    Column(
                      children: [
                        _balaoDeTexto(_texto),
                        const SizedBox(
                          height: 12,
                        ),
                        _addImagem(Imagens.professor, () {}, screenWidth * 0.75,
                            screenWidth * 0.75),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),

                  //Escolha da dificuldade de jogo
                  if (_contador == 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () => dificuldade(5),
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            child: Text(
                              "Fácil",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                        ElevatedButton(
                            onPressed: () => dificuldade(10),
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            child: Text(
                              "Médio",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                        ElevatedButton(
                            onPressed: () => dificuldade(20),
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            child: Text(
                              "Difícil",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                      ],
                    ),
                  if (_contador < 3)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
                      child: ElevatedButton(
                          onPressed: _avancar,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF6cabb0))),
                          child: Text(
                            "Próximo",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white),
                          )),
                    ),

                  //Questões
                  if (_contador > 3 && _contador <= listaDePerguntas.length + 3)
                    Column(
                      children: [
                        _textoFixo(_questao["q"]),
                        const SizedBox(
                          height: 12,
                        ),
                        GroupButton(
                            key: UniqueKey(),
                            options: GroupButtonOptions(
                                buttonWidth: screenWidth * 0.6,
                                selectedColor: Color(0xFF6cabb0),
                                unselectedColor:
                                    const Color.fromARGB(255, 235, 247, 248),
                                textPadding: EdgeInsets.all(3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            isRadio: true,
                            onSelected: (value, index, True) {
                              resposta = value;
                            },
                            buttons: _perguntas),
                        const SizedBox(
                          height: 12,
                        ),
                        if (semResposta)
                          Text(
                            "Selecione uma alternativa",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: screenWidth * 0.04),
                          )
                      ],
                    ),

                  if (_contador > 3 && !questaoFinalizada)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
                      child: ElevatedButton(
                          onPressed: verificarResposta,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF6cabb0))),
                          child: Text(
                            "Verificar",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white),
                          )),
                    ),
                  //Interação quando a questão é respondida
                  if (_contador > 3 &&
                      questaoFinalizada &&
                      _contador <= listaDePerguntas.length + 3)
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 0, horizontal: screenWidth * 0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Sua resposta: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth * 0.04),
                                ),
                                TextSpan(
                                  text: '$resposta',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: screenWidth * 0.04),
                                ),
                              ],
                            ),
                          ),
                          if (certaResposta)
                            Text(
                              "Resultado: certa reposta!",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: screenWidth * 0.04),
                              textAlign: TextAlign.start,
                            ),
                          if (!certaResposta)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Resultado: que pena, você errou.\n',
                                    style: TextStyle(
                                        color: Colors.red[600],
                                        fontSize: screenWidth * 0.04),
                                  ),
                                  TextSpan(
                                    text: 'Resposta correta: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenWidth * 0.04),
                                  ),
                                  TextSpan(
                                    text: '${_questao["r"]}',
                                    style: TextStyle(
                                        color: Color(0xFF6cabb0),
                                        fontSize: screenWidth * 0.04),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  if (_contador > 3 &&
                      questaoFinalizada &&
                      _contador <= listaDePerguntas.length + 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            onPressed: () => _abrirModal(
                                context, _questao["e"], screenWidth * 0.04),
                            child: Text(
                              "Explicação",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                        if (questaoFinalizada &&
                            _contador == listaDePerguntas.length + 3)
                          ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF6cabb0))),
                              onPressed: questao,
                              child: Text(
                                "Classificação",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04),
                              )),
                        if (_contador != listaDePerguntas.length + 3)
                          ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF6cabb0))),
                              onPressed: questao,
                              child: Text("Próximo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.04))),
                      ],
                    ),

                  //Interação quando o jogo é finalizado
                  if (jogoFinalizado)
                    Column(
                      children: [
                        Text(
                          "Você acertou $pontuacao de ${listaDePerguntas.length} questões",
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (classificacao == 1)
                          Column(
                            children: [
                              Image.asset(
                                Imagens.turista,
                                width: screenWidth * 0.75,
                                height: screenWidth * 0.75,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Seu nível de classificação é de Turista.",
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              )
                            ],
                          ),
                        if (classificacao == 2)
                          Column(
                            children: [
                              Image.asset(
                                Imagens.explorador,
                                width: screenWidth * 0.75,
                                height: screenWidth * 0.75,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Seu nível de classificação é de Explorador",
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        if (classificacao == 3)
                          Column(
                            children: [
                              Image.asset(
                                Imagens.nativo,
                                width: screenWidth * 0.75,
                                height: screenWidth * 0.75,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Muito bem! Seu nível de classificação é de Nativo.",
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        if (classificacao == 4)
                          Column(
                            children: [
                              Image.asset(
                                Imagens.expert,
                                width: screenWidth * 0.75,
                                height: screenWidth * 0.75,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Excelente!!! Seu nível de classificação é de Expert.",
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 6,
                        ),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            onPressed: () {
                              reiniciarJogo();
                            },
                            child: Text(
                              "Jogar novamente",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Histórico de questões",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: screenWidth * 0.06),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ..._historicoQuestoes(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _balaoDeTexto(String texto) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: AnimatedTextKit(
      key: UniqueKey(),
      animatedTexts: [
        TypewriterAnimatedText(
          texto,
          textStyle: const TextStyle(color: Colors.white),
          speed: const Duration(milliseconds: 30),
        )
      ],
      totalRepeatCount: 1,
    ),
  );
}

Widget _textoFixo(String texto) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: Text(
      texto,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Widget _addImagem(String imagem, Function onTap, double width, double height) {
  return GestureDetector(
    onTap: () {
      onTap;
    },
    child: Image.asset(
      imagem,
      width: width,
      height: height,
      fit: BoxFit.contain,
    ),
  );
}

void _abrirModal(BuildContext context, String explicacao, double tamanho) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          color: Colors.blue[50],
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Text(
                explicacao,
                style: TextStyle(fontSize: tamanho),
              ),
            ],
          ),
        ),
      );
    },
  );
}
