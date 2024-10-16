import 'package:flutter/material.dart';
import 'package:geograpp/utilitarios/Imagens.dart';
import 'package:geograpp/memoria/SobreIndigenas.dart';

class SaibaMaisIndigenas extends StatefulWidget {
  const SaibaMaisIndigenas({super.key});

  @override
  State<SaibaMaisIndigenas> createState() => _SaibaMaisIndigenasState();
}

class _SaibaMaisIndigenasState extends State<SaibaMaisIndigenas> {
  _navegacaoSobreIndigenas(int numero) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SobreIndigenas(numeroImagem: numero)));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final imageSize = screenWidth * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saiba Mais",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            children: [
              Text(
                "Você sabia? Na capital de Palmas-TO as 6 estações de ônibus da capital levam o nome de 6 diferentes etnias indígenas presentes no estado. São elas: Javaé - localizada em Taquaralto, Karajá - localizada no Aureny 1, Xerente - localizada no Aureny 3, Krahô - localizada na Av. Rodoviária, Xambioá - localizada próxima ao fórum e Apinajé - lozalizada próxima ao palácio Araguaia. Ao todo estão presentes 8 etnias indígenas no estado do Tocantins, elas estão listadas abaixo, clique em alguma delas para saber mais detalhes.",
                style: TextStyle(fontSize: screenWidth * 0.03),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(1),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.apinaje,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Apinajé",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(2),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.avaCanoeiro,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Avá Canoeiro",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(3),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.javae,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Javaé",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(4),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.karaja,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Karajá",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(5),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.kraho,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Krahô",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(6),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.krahoKanela,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Krahô Kanela",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(7),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.xambioa,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text("Xambioa",
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _navegacaoSobreIndigenas(8),
                          child: SizedBox(
                            height: imageSize,
                            width: imageSize,
                            child: Image.asset(
                              Imagens.xerente,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Xerente",
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
