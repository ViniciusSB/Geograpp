// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/utilitarios/Textos.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreIndigenas extends StatefulWidget {
  final int numeroImagem;
  const SobreIndigenas({super.key, required this.numeroImagem});

  @override
  State<SobreIndigenas> createState() => _SobreIndigenasState();
}

class _SobreIndigenasState extends State<SobreIndigenas> {
  late int numeroImagem;
  late HashMap dados;
  late Uri _url;
  late String urlString;

  @override
  void initState() {
    super.initState();
    numeroImagem = widget.numeroImagem;
    dados = converterNumero(numeroImagem);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
        backgroundColor: const Color(0xFF6081DB),
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
              Text(
                "Fonte: ${dados["fonte"]}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                dados["texto"],
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: screenWidth * 0.035),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: _launchUrl,
                  child: Text(
                    urlString,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
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
        dados["fonte"] = Imagens.fonteApinaje;
        urlString = Textos.urlApinaje;
        _url = Uri.parse(Textos.urlApinaje);

        break;
      case 2:
        dados["nome"] = "Avá Canoeiro";
        dados["texto"] = Textos.textoAvaCanoeiro;
        dados["caminho"] = Imagens.avaCanoeiro;
        dados["fonte"] = Imagens.fonteAvaCanoeiro;
        urlString = Textos.urlAvaCanoeiro;
        _url = Uri.parse(Textos.urlAvaCanoeiro);
        break;
      case 3:
        dados["nome"] = "Javaé";
        dados["texto"] = Textos.textoJavae;
        dados["caminho"] = Imagens.javae;
        dados["fonte"] = Imagens.fonteJavae;
        urlString = Textos.urlJavae;
        _url = Uri.parse(Textos.urlJavae);
        break;
      case 4:
        dados["nome"] = "Karajá";
        dados["texto"] = Textos.textoKaraja;
        dados["caminho"] = Imagens.karaja;
        dados["fonte"] = Imagens.fonteKaraja;
        urlString = Textos.urlKaraja;
        _url = Uri.parse(Textos.urlKaraja);
        break;
      case 5:
        dados["nome"] = "Krahô";
        dados["texto"] = Textos.textoKraho;
        dados["caminho"] = Imagens.kraho;
        dados["fonte"] = Imagens.fonteKraho;
        urlString = Textos.urlKraho;
        _url = Uri.parse(Textos.urlKraho);
        break;
      case 6:
        dados["nome"] = "Krahô Kanela";
        dados["texto"] = Textos.textoKrahoKanela;
        dados["caminho"] = Imagens.krahoKanela;
        dados["fonte"] = Imagens.fonteKrahoKanela;
        urlString = Textos.urlKrahoKanela;
        _url = Uri.parse(Textos.urlKrahoKanela);
        break;
      case 7:
        dados["nome"] = "Xambioá";
        dados["texto"] = Textos.textoXambioa;
        dados["caminho"] = Imagens.xambioa;
        dados["fonte"] = Imagens.fonteXambioa;
        urlString = Textos.urlXambioa;
        _url = Uri.parse(Textos.urlXambioa);
        break;
      case 8:
        dados["nome"] = "Xerente";
        dados["texto"] = Textos.textoXerente;
        dados["caminho"] = Imagens.xerente;
        dados["fonte"] = Imagens.fonteXerente;
        urlString = Textos.urlXerente;
        _url = Uri.parse(Textos.urlXerente);
        break;
    }
    return dados;
  }
}
