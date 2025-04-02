import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Importa las pantallas de Login y Registro
import 'login_view.dart';
import 'register_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 8),
            const Text(
              "BlueMind",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Get.to(() => const RegisterView()), // Navega a RegisterView
            child: const Text(
              "Registrarse",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () =>
                Get.to(() => const LoginView()), // Navega a LoginView
            child: const Text(
              "Iniciar Sesión",
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
