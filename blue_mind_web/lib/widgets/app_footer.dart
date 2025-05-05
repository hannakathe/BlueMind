import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Primera columna
              _footerColumn('Navigation', [
                'Inicio',
                'Blog',
                'Foro',
              ]),
              // Segunda columna
              _footerColumn('Navigation', [
                'Recursos Educativos',
                'Álbum de Especies',
                'Mapa Interactivo',
              ]),
              // Tercera columna
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Síguenos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.facebook, size: 18),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.twitter, size: 18),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.instagram, size: 18),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.linkedin, size: 18),
                    ],
                  )
                ],
              ),
              // Cuarta columna
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Contactanos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('📧 Hello@BlueMind.com'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('ALLRIGHT RESERVED – BLUEMIND'),
              Text('POLÍTICA DE PRIVACIDAD    |    CONDICIONES DE USO'),
            ],
          )
        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              children: [
                const Text('› ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item),
              ],
            ),
          ),
      ],
    );
  }
}
