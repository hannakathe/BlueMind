import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isSmallScreen ? 20 : 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              'Explora, aprende y actúa. Porque el futuro del planeta está en nuestras manos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Menús
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _menuColumn('Menú', {
                      'Inicio': AppRoutes.home,
                      'Blog': AppRoutes.blog,
                      'Recursos Educativos': AppRoutes.library,
                      'Álbum de Especies': AppRoutes.album,
                      'Mapa Interactivo': AppRoutes.map,
                    }, isAuthRequired: true),
                    const SizedBox(height: 20),
                    _menuColumn('Perfil', {
                      'Perfil': AppRoutes.profile,
                    }, isAuthRequired: true),
                    const SizedBox(height: 20),
                    _menuColumn('Síguenos', {
                      'Facebook': '',
                      'Twitter': '',
                      'Instagram': '',
                      'LinkedIn': '',
                    }, isSocial: true),
                    const SizedBox(height: 20),
                    _menuColumn('Contáctanos', {
                      '📧 Hello@BlueMind.com': '',
                    }),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _menuColumn('Menú', {
                      'Inicio': AppRoutes.home,
                      'Blog': AppRoutes.blog,
                      'Recursos Educativos': AppRoutes.library,
                      'Álbum de Especies': AppRoutes.album,
                      'Mapa Interactivo': AppRoutes.map,
                    }, isAuthRequired: true),
                    _menuColumn('Perfil', {
                      'Perfil': AppRoutes.profile,
                    }, isAuthRequired: true),
                    _menuColumn('Síguenos', {
                      'Facebook': '',
                      'Twitter': '',
                      'Instagram': '',
                      'LinkedIn': '',
                    }, isSocial: true),
                    _menuColumn('Contáctanos', {
                      'Hello@BlueMind.com': '',
                    }),
                  ],
                ),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          // Footer inferior responsivo
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('ALLRIGHT RESERVED – BLUEMIND'),
                    SizedBox(height: 8),
                    Text('POLÍTICA DE PRIVACIDAD    |    CONDICIONES DE USO'),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('ALLRIGHT RESERVED – BLUEMIND'),
                    Text('POLÍTICA DE PRIVACIDAD    |    CONDICIONES DE USO'),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _menuColumn(String title, Map<String, String> items,
      {bool isSocial = false, bool isAuthRequired = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            for (var entry in items.entries)
              HoverLink(
                text: entry.key,
                route: entry.value,
                isAuthRequired: isAuthRequired,
              ),
          ],
        ),
      ),
    );
  }
}

class HoverLink extends StatefulWidget {
  final String text;
  final String route;
  final bool isAuthRequired;

  const HoverLink({
    super.key,
    required this.text,
    required this.route,
    required this.isAuthRequired,
  });

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
      decoration:
          isHovered ? TextDecoration.underline : TextDecoration.none,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.route.isNotEmpty) {
            if (widget.isAuthRequired) {
              final auth = FirebaseAuth.instance;
              Get.toNamed(widget.route, arguments: {'auth': auth});
            } else {
              Get.toNamed(widget.route);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              const Text('› ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.text, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
