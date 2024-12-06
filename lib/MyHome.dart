import 'package:application_firebase1/mydrower.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      drawer: const DrawrApp(), // Utilisation de votre widget personnalisé
      body: const Center(
        child: Text(
          'Bienvenue sur la page principale !',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}