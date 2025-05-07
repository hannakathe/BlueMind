import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  Future<void> _loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingresa correo y contraseña.';
      });
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        _errorMessage = '';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Error al iniciar sesión.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado. Intenta de nuevo.';
      });
    }
  }

  void _resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingresa tu correo electrónico.';
      });
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Correo enviado'),
              content: const Text(
                'Revisa tu bandeja de entrada para restablecer la contraseña.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'No se pudo enviar el correo.';
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Ocurrió un error al intentar restablecer la contraseña.';
      });
    }
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithPopup(googleAuthProvider);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _user != null
              ? HomeView(auth: _auth)
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
                              'assets/logoW-invert.png',
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 15),
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
                            label: 'Correo electrónico',
                            obscureText: false,
                            controller: emailController,
                          ),
                          const SizedBox(height: 15),

                          // Campo de contraseña
                          _buildTextField(
                            label: 'Contraseña',
                            obscureText: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 15),

                          // Mensaje de error
                          if (_errorMessage.isNotEmpty)
                            Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.redAccent),
                            ),

                          const SizedBox(height: 10),

                          // Botón de Continuar
                          SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _loginUser,
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

                          // Botón Olvidó contraseña
                          TextButton(
                            onPressed: _resetPassword,
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

                          // Botón Google
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

  Widget _buildTextField({
    required String label,
    required bool obscureText,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 400,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
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
          backgroundColor: Colors.white.withOpacity(0.3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
