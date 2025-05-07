import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Campos vacíos',
        'Por favor ingresa tu correo y contraseña.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Contraseña débil',
        'La contraseña debe tener al menos 6 caracteres.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'correo': email,
        'notificaciones': true,
        'favoritos': [],
        'rol': ['usuario'],
        'nombre': '',
        'apellido': '',
        'username': '',
        'telefono': '',
      });

      Get.offAllNamed(AppRoutes.home);
      Get.snackbar(
        'Registro exitoso',
        'Has sido registrado correctamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error de registro',
        e.message ?? 'Error desconocido',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1475372674317-8003c861cb6a?q=80&w=1974&auto=format&fit=crop',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth > 500 ? 400 : screenWidth * 0.9,
                ),
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
                    _buildTextField(
                      label: 'Ingresar correo electrónico',
                      obscureText: false,
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Ingresar contraseña',
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator(color: Colors.white))
                          : ElevatedButton(
                              onPressed: registerUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF150578),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Continuar', style: TextStyle(fontSize: 16)),
                            ),
                    ),
                    const SizedBox(height: 20),
                    const Text('o', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 15),
                    _buildSocialButton(
                      icon: FontAwesomeIcons.google,
                      text: 'Registrarse con Google',
                      onPressed: () {
                        // Aquí puedes implementar signInWithGoogle()
                      },
                    ),
                  ],
                ),
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
      height: 50,
      width: double.infinity,
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
