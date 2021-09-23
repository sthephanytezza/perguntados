import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({Key? key}) : super(key: key);

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
          children: const [
            ContainerFinal(),
          ],
        ),
      ),
    );
  }
}

class ContainerFinal extends StatefulWidget {
  const ContainerFinal({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerFinal> createState() => _ContainerFinalState();
}

class _ContainerFinalState extends State<ContainerFinal> {
  int _pontos = 0;

  void _incrementPontos() {
    setState(() {
      _pontos++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
              'Sua pontuação foi de:',
              maxLines: 2,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
              child: Text(
            '$_pontos/10 Acertos',
            style: const TextStyle(
              fontSize: 28,
            ),
          )),
          const SizedBox(height: 24),
          Center(
              child: GestureDetector(
            child: const Text(
              'Tentar novamente',
              style: TextStyle(
                  color: Color(0xFF758cff),
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline),
            ),
            onTap: () {
              _incrementPontos();
              debugPrint('Apertou');
            },
          ))
        ],
      ),
    );
  }
}