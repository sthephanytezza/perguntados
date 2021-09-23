import 'package:flutter/material.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

const Color primaryColor = Color(0xFF758cff);
const Color secondaryColor = Color(0xFFe5e9ff);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perguntas e Respotas',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
