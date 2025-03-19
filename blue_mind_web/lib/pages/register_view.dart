import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'BlueMind',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildSocialButton(
                icon: Icons.g_translate,
                text: 'Continuar con Google',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              _buildSocialButton(
                icon: Icons.facebook,
                text: 'Continuar con Facebook',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
                ),
                onPressed: () {},
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String text, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        minimumSize: const Size(double.infinity, 50),
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: onPressed,
    );
  }
}
