import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';

class RevisarQuestao extends StatefulWidget {
  final List<Map<String, String>> dadosQuestao;
  final int index;

  const RevisarQuestao(
      {super.key, required this.dadosQuestao, required this.index});

  @override
  State<RevisarQuestao> createState() => _RevisarQuestaoState();
}

class _RevisarQuestaoState extends State<RevisarQuestao> {
  late List<Map<String, String>> dadosQuestao;
  late int index;

  @override
  void initState() {
    super.initState();
    dadosQuestao = widget.dadosQuestao;
    index = widget.index;
  }

  List<Widget> _botoesQuestao() {
    List<Widget> leb = [];
    final mediaQuery = MediaQuery.of(context);
    bool acerto = dadosQuestao[index]["rd"] == dadosQuestao[index]["r"];
    List<String> questoes = [];
    questoes.add(dadosQuestao[index]["p1"]!);
    questoes.add(dadosQuestao[index]["p2"]!);
    questoes.add(dadosQuestao[index]["p3"]!);
    questoes.add(dadosQuestao[index]["p4"]!);

    for (int i = 0; i < questoes.length; i++) {
      Color corBotao;
      if (questoes[i] == dadosQuestao[index]["r"]) {
        corBotao = Colors.green;
      } else if (questoes[i] == dadosQuestao[index]["rd"] && !acerto) {
        corBotao = Colors.red[600]!;
      } else {
        corBotao = Colors.white;
      }

      ElevatedButton eb = ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all<Size>(
            Size.fromWidth(mediaQuery.size.width * 0.60),
          ),
          backgroundColor: MaterialStateProperty.all(corBotao),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            questoes[i],
            textAlign: TextAlign.center,
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Histórico questão ${dadosQuestao[index]["nq"]}",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6081DB),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              retornarImagemDeFundo(dadosQuestao[index]["c"]!),
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(screenWidth * 0.06),
              alignment: Alignment.center,
              child: Column(
                children: [
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
                          text: '${dadosQuestao[index]["c"]}',
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
                  _textoFixo(dadosQuestao[index]["q"]!),
                  const SizedBox(
                    height: 12,
                  ),
                  ..._botoesQuestao(),
                  const SizedBox(
                    height: 12,
                  ),
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
                                text: '${dadosQuestao[index]["rd"]}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                        ),
                        if (dadosQuestao[index]["rd"] ==
                            dadosQuestao[index]["r"])
                          Text(
                            "Resultado: certa reposta!",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: screenWidth * 0.04),
                            textAlign: TextAlign.start,
                          ),
                        if (dadosQuestao[index]["rd"] !=
                            dadosQuestao[index]["r"])
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
                                  text: '${dadosQuestao[index]["r"]}',
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
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF6cabb0))),
                            onPressed: () => _abrirModal(context,
                                dadosQuestao[index]["e"]!, screenWidth * 0.04),
                            child: Text(
                              "Explicação",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
}
