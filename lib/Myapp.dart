import 'package:application_firebase1/MyHome.dart';
import 'package:application_firebase1/form.dart';
import 'package:application_firebase1/signIn.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (context) => const RegisterForm(),
        '/': (context) => const SignInForm(),
        '/home': (context) => const MyHomePage(title: 'Home',), // Ensure you have a HomeScreen widget

      },
      initialRoute: '/',  // Set SignInForm as the initial screen
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}


