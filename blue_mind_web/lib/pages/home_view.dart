import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart'; // Importa AppFooter
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  final FirebaseAuth auth;

  const HomeView({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 125.0;
    final verticalPadding = 50.0;

    return Scaffold(
      appBar: const AppNavbar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: AppHeader(
              imagePath: 'https://via.placeholder.com/600x250',
              title: '¡Hola!',
              subtitle: 'Bienvenida, ${auth.currentUser?.email ?? 'Usuario'}',
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Usuario: ${auth.currentUser?.email ?? 'No identificado'}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const Expanded(child: SizedBox()), // Esto asegura que el footer quede al final
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const AppFooter(), // Ahora con el padding aplicado
          ),
        ],
      ),
    );
  }
}
