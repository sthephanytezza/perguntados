import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perguntados/class/question.dart';
import 'package:perguntados/main.dart';

import '../../data.dart';

class QuestionPage extends StatefulWidget {
  final Function() incrementPontos;

  const QuestionPage({Key? key, required this.incrementPontos})
      : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedQuestion = 0;
  late List<Question> questions;

  @override
  void initState() {
    questions = questionsData;

    super.initState();
  }

  void incrementQuestion() {
    setState(() {
      selectedQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            'Perguntas e respostas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: primaryColor),
      body: SafeArea(
        child: ContainerQuestion(
            question: questions[selectedQuestion],
            incrementQuestion: incrementQuestion),
      ),
    );
  }
}

class ContainerQuestion extends StatefulWidget {
  final Question question;
  final Function() incrementQuestion;

  const ContainerQuestion({
    Key? key,
    required this.question,
    required this.incrementQuestion,
  }) : super(key: key);

  @override
  State<ContainerQuestion> createState() => _ContainerQuestionState();
}

Color borderColor = primaryColor;
Color backgroundColor = const Color(0xFFb6c2ff);
Widget checkboxContent = const SizedBox();
Color colorText = Colors.white;

BoxDecoration containerDetails(bool selected) {
  if (selected) {
    return BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          width: 1.8,
          color: backgroundColor,
        ));
  }

  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(
        width: 1.8,
        color: const Color(0xFFf7f7f7),
      ));
}

BoxDecoration containerCheckbox(bool selected) {
  if (selected) {
    return BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ));
  }

  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
        color: borderColor,
        width: 2.0,
      ));
}

Widget containerOption(
    int _selected, int index, Function() onTap, Question question) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 4.0),
      padding: const EdgeInsets.all(20.0),
      decoration: containerDetails(_selected == index),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 20.0,
            width: 20.0,
            decoration: containerCheckbox(_selected == index),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 15.0,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            question.options[index],
            maxLines: 4,
            style: TextStyle(
              color: _selected == index ? primaryColor : Colors.black,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}

class _ContainerQuestionState extends State<ContainerQuestion> {
  int _selected = -1;

  void changeIndex(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.question.question,
          ),
          const SizedBox(height: 80),
          const Text('Respostas',
              style: TextStyle(
                color: primaryColor,
              )),
          const SizedBox(height: 10),
          containerOption(_selected, 0, () => changeIndex(0), widget.question),
          containerOption(_selected, 1, () => changeIndex(1), widget.question),
          containerOption(_selected, 2, () => changeIndex(2), widget.question),
          containerOption(_selected, 3, () => changeIndex(3), widget.question),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => debugPrint('pressionado'),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF758cff),
              onPrimary: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: const Text(
              'Responder',
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
