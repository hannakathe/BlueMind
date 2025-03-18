import 'package:flutter/material.dart';
import 'pages/login_view.dart'; // Asegúrate de que el archivo login_view.dart está en la misma carpeta

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlueMind Login',
      home: LoginView(),
    );
  }
}