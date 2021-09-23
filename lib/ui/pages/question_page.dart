import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perguntados/class/question.dart';
import 'package:perguntados/ui/pages/final_page.dart';
import 'package:perguntados/main.dart';

import '../../data.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedQuestion = 0;
  bool checkQuestion = false;
  int pontos = 0;

  late List<Question> questions;

  @override
  void initState() {
    questions = questionsData;

    super.initState();
  }

  void incrementPontos() {
    setState(() {
      pontos++;
    });
  }

  int returnPontos() {
    return pontos;
  }

  void incrementQuestion() {
    setState(() {
      selectedQuestion++;
    });
  }

  void updateCheckQuestion() {
    setState(() {
      checkQuestion = !checkQuestion;
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
          checkQuestion: checkQuestion,
          incrementQuestion: incrementQuestion,
          updateCheckQuestion: updateCheckQuestion,
          incrementPontos: incrementPontos,
          selectedQuestion: selectedQuestion,
          returnPontos: returnPontos,
        ),
      ),
    );
  }
}

class ContainerQuestion extends StatefulWidget {
  final Question question;
  final bool checkQuestion;
  final Function() incrementQuestion;
  final Function() updateCheckQuestion;
  final Function() incrementPontos;
  final int selectedQuestion;
  final Function() returnPontos;

  const ContainerQuestion({
    Key? key,
    required this.question,
    required this.checkQuestion,
    required this.incrementQuestion,
    required this.updateCheckQuestion,
    required this.incrementPontos,
    required this.selectedQuestion,
    required this.returnPontos,
  }) : super(key: key);

  @override
  State<ContainerQuestion> createState() => _ContainerQuestionState();
}

Color borderColor = primaryColor;
late Color principal;
Color backgroundColor = const Color(0xFFb6c2ff);
Color green = const Color(0xFF47c94c);
Color red = const Color(0xFFfc5e5e);

void changeColors(
    bool selected, int index, Question question, bool checkQuestion) {
  if (checkQuestion) {
    if (index == question.correct) {
      backgroundColor = const Color(0xFFe5ffe6);
      principal = const Color(0xFF47c94c);
    } else if (selected) {
      backgroundColor = const Color(0xFFffd6d6);
      principal = const Color(0xFFfc5e5e);
    }
  } else {
    if (selected) {
      backgroundColor = const Color(0xFFb6c2ff);
      principal = primaryColor;
    } else {
      backgroundColor = Colors.transparent;
      principal = const Color(0xFFf7f7f7);
    }
  }
}

BoxDecoration containerDetails(bool selected, int chosen, int index,
    Question question, bool checkQuestion) {
  if (checkQuestion) {
    if (index == question.correct) {
      return BoxDecoration(
          color: const Color(0xFFe5ffe6),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            width: 1.8,
            color: green,
          ));
    } else if (selected) {
      return BoxDecoration(
          color: const Color(0xFFffd6d6),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            width: 1.8,
            color: red,
          ));
    }
  }

  if (selected) {
    return BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          width: 1.8,
          color: primaryColor,
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

BoxDecoration containerCheckbox(
    bool selected, int index, Question question, bool checkQuestion) {
  if (checkQuestion) {
    if (index == question.correct) {
      return BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: green,
            width: 2.0,
          ));
    } else if (selected) {
      return BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: red,
            width: 2.0,
          ));
    }
  }
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

Color colorText(
    bool selected, int index, Question question, bool checkQuestion) {
  if (checkQuestion) {
    if (index == question.correct) {
      return green;
    } else if (selected) {
      return red;
    }
  }
  if (selected) {
    return primaryColor;
  }
  return Colors.black;
}

Widget containerOption(int _selected, int index, Function() onTap,
    Question question, bool checkQuestion) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 4.0),
      padding: const EdgeInsets.all(20.0),
      decoration: containerDetails(
          _selected == index, _selected, index, question, checkQuestion),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 20.0,
            width: 20.0,
            decoration: containerCheckbox(
                _selected == index, index, question, checkQuestion),
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
              color:
                  colorText(_selected == index, index, question, checkQuestion),
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
  String textButton = 'Responder';

  void changeIndex(int index) {
    setState(() {
      _selected = index;
    });
  }

  void computeQuestion(
      bool checkQuestion, int _selected, int correct, int selectedQuestion) {
    if (_selected > -1 && checkQuestion) {
      widget.updateCheckQuestion();
      textButton = 'Responder';
      if (_selected == correct) {
        widget.incrementPontos();
      }
      changeIndex(-1);

      if (selectedQuestion < 9) {
        widget.incrementQuestion();
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const FinalPage(),
          settings: RouteSettings(
            arguments: widget.returnPontos(),
          ),
        ));
      }
    } else {
      widget.updateCheckQuestion();
      textButton = 'Próxima pergunta';
    }
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
          containerOption(_selected, 0, () => changeIndex(0), widget.question,
              widget.checkQuestion),
          containerOption(_selected, 1, () => changeIndex(1), widget.question,
              widget.checkQuestion),
          containerOption(_selected, 2, () => changeIndex(2), widget.question,
              widget.checkQuestion),
          containerOption(_selected, 3, () => changeIndex(3), widget.question,
              widget.checkQuestion),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => computeQuestion(
              widget.checkQuestion,
              _selected,
              widget.question.correct,
              widget.selectedQuestion,
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF758cff),
              onPrimary: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: Text(
              textButton,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
