// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:geograpp/blocos/BlocoHome.dart";
import "package:geograpp/quiz/ConhecendoTocantins.dart";
import "package:geograpp/memoria/MemoriaHome.dart";
import "package:geograpp/utilitarios/Imagens.dart";

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geograpp",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6081DB),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 4,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(
                child: Row(
                  children: [
                    Text(
                      "Quiz Tocantins",
                      style: TextStyle(fontSize: 12),
                    ),
                    Image.asset(
                      Imagens.question,
                      height: 15,
                      width: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Text(
                      "Jogo da memória",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Image.asset(
                      Imagens.brain,
                      height: 15,
                      width: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Text(
                      "Blocos Deslizantes",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Image.asset(
                      Imagens.puzzle,
                      height: 15,
                      width: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ConhecendoTocantins(), MemoriaHome(), BlocoHome()],
      ),
    );
  }
}
