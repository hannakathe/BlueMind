import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'profile_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null
          ? ProfileView(
              auth:
                  _auth) // Muestra la vista de perfil si el usuario está autenticado
          : Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1475372674317-8003c861cb6a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/logo.jpg', // Ruta corregida
                            height: 100, // Ajusta el tamaño
                            width: 100, // Ajusta el tamaño
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 45),
                        Text(
                          'BlueMind',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Campo de correo
                        _buildTextField(
                            label: 'Correo electrónico', obscureText: false),
                        const SizedBox(height: 15),

                        // Campo de contraseña
                        _buildTextField(label: 'Contraseña', obscureText: true),
                        const SizedBox(height: 15),

                        // Botón de Continuar
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF150578),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Continuar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '¿Olvidó su contraseña?',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'o',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 15),

                        // Botón de Facebook
                        _buildSocialButton(
                          icon: FontAwesomeIcons.facebook,
                          text: 'Iniciar sesión con Facebook',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),

                        // Botón de Google
                        _buildSocialButton(
                          icon: FontAwesomeIcons.google,
                          text: 'Iniciar sesión con Google',
                          onPressed: _handleGoogleSignIn,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Widget para los campos de texto
  Widget _buildTextField({required String label, required bool obscureText}) {
    return SizedBox(
      width: 400,
      height: 50,
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          // ignore: deprecated_member_use
          fillColor: Colors.white.withOpacity(0.2),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Widget para los botones de redes sociales
  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          backgroundColor: Colors.white.withOpacity(0.3), // Botón translúcido
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, color: Colors.white), // Ícono en blanco
        label: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithPopup(_googleAuthProvider);
    } catch (e) {}
  }
}
