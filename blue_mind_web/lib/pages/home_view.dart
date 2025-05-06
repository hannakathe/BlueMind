import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeView extends StatelessWidget {
  final FirebaseAuth auth;

  const HomeView({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(),
      body: Center(child: Text('Usuario: ${auth.currentUser?.email ?? 'No identificado'}')),
    );
  }
}
