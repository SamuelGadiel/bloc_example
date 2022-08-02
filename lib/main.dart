// ------------------------------
// Desenvolvido por Samuel Gadiel de Ávila
// @samuelgadiel
// Desenvolvido em 01/08/2022
// ------------------------------

import 'package:flutter/material.dart';

import 'home_page.dart';
import 'old_home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      // Se você desejar ver a tela antiga, sem bloc, basta usar esse widget OldHomePage()
      // home: OldHomePage(),
      home: HomePage(),
    );
  }
}
