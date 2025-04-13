import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_navbar.dart';

class ProfileView extends StatefulWidget {
  final FirebaseAuth auth;

  const ProfileView({Key? key, required this.auth}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? get user => widget.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      appBar: AppNavbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar y datos básicos
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.photo_camera, size: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.displayName ?? 'Usuario',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user?.email ?? 'usuario@email.com'),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Acción de eliminar cuenta
                      },
                      child: const Text('Eliminar Cuenta', style: TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      color: Colors.blueAccent,
                      child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await widget.auth.signOut();
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                // Formulario
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Información personal', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Nombres',
                                border: outlineBorder,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Apellidos',
                                border: outlineBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          border: outlineBorder,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.flag),
                                SizedBox(width: 5),
                                Text('+57'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Teléfono',
                                border: outlineBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Sitio web personal',
                          border: outlineBorder,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: outlineBorder,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Anterior contraseña',
                                border: outlineBorder,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Nueva contraseña',
                                border: outlineBorder,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

