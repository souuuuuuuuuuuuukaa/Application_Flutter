import 'package:application_firebase1/Myapp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Importer le fichier firebase_options.dart


void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Utiliser les options générées

);
  runApp(const MyApp());
}
    