// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'screens/contact_list.dart'; // Importe a tela de adicionar contatos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactList(), // Defina a rota
    );
  }
}
