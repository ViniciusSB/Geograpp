import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/utilitarios/Textos.dart';

class SobreIndigenas extends StatefulWidget {
  final int numeroImagem;
  const SobreIndigenas({super.key, required this.numeroImagem});

  @override
  State<SobreIndigenas> createState() => _SobreIndigenasState();
}

class _SobreIndigenasState extends State<SobreIndigenas> {
  late int numeroImagem;
  late HashMap dados;

  @override
  void initState() {
    super.initState();
    numeroImagem = widget.numeroImagem;
    dados = converterNumero(numeroImagem);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sobre - ${dados['nome']}",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.06),
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                dados["caminho"],
                width: screenWidth * 0.75,
                height: screenWidth * 0.75,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                dados["texto"],
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: screenWidth * 0.035),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => atualizarStatus(0),
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: () => atualizarStatus(1),
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  atualizarStatus(int opcao) {
    //opcao 0 voltar 1 avancar3
    if (opcao == 0 && numeroImagem > 1) {
      setState(() {
        numeroImagem -= 1;
        dados = converterNumero(numeroImagem);
      });
    } else if (opcao == 1 && numeroImagem < 8) {
      setState(() {
        numeroImagem += 1;
        dados = converterNumero(numeroImagem);
      });
    }
  }

  HashMap<String, String> converterNumero(int numeroImagem) {
    HashMap<String, String> dados = HashMap();
    switch (numeroImagem) {
      case 1:
        dados["nome"] = "Apinajé";
        dados["texto"] = Textos.textoApinaje;
        dados["caminho"] = Imagens.apinaje;
        break;
      case 2:
        dados["nome"] = "Avá Canoeiro";
        dados["texto"] = Textos.textoAvaCanoeiro;
        dados["caminho"] = Imagens.avaCanoeiro;
        break;
      case 3:
        dados["nome"] = "Javaé";
        dados["texto"] = Textos.textoJavae;
        dados["caminho"] = Imagens.javae;
        break;
      case 4:
        dados["nome"] = "Karajá";
        dados["texto"] = Textos.textoKaraja;
        dados["caminho"] = Imagens.karaja;
        break;
      case 5:
        dados["nome"] = "Krahô";
        dados["texto"] = Textos.textoKraho;
        dados["caminho"] = Imagens.kraho;
        break;
      case 6:
        dados["nome"] = "Krahô Kanela";
        dados["texto"] = Textos.textoKrahoKanela;
        dados["caminho"] = Imagens.krahoKanela;
        break;
      case 7:
        dados["nome"] = "Xambioá";
        dados["texto"] = Textos.textoXambioa;
        dados["caminho"] = Imagens.xambioa;
        break;
      case 8:
        dados["nome"] = "Xerente";
        dados["texto"] = Textos.textoXerente;
        dados["caminho"] = Imagens.xerente;
        break;
    }
    return dados;
  }
}
