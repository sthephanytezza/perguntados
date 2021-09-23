import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perguntados/ui/pages/question_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pontos = 0;

  void incrementPontos() {
    pontos++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe5e9ff),
      appBar: AppBar(
        title: const Text(
          'Perguntas e respostas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF758cff),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerHome(incrementPontos: incrementPontos),
          ],
        ),
      ),
    );
  }
}

class ContainerHome extends StatelessWidget {
  final Function() incrementPontos;

  const ContainerHome({
    Key? key,
    required this.incrementPontos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            'Perguntas e repostas',
            style: TextStyle(
                color: Color(0xFF758cff),
                fontSize: 26,
                fontWeight: FontWeight.w800),
          )),
          const SizedBox(height: 14),
          const Expanded(
            child: Text(
              'Responda 10 perguntas e veja sua pontuação no fim!',
              maxLines: 2,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    QuestionPage(incrementPontos: incrementPontos))),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF758cff),
              onPrimary: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: const Text(
              'Start!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
