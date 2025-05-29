import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';
import '../widgets/app_navbar_prehome.dart';
import '../widgets/app_header.dart';
import '../widgets/app_pre_footer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PreHomeScreen extends StatelessWidget {
  PreHomeScreen({super.key});

  final ThemeController themeController = Get.find();

  void _navigateToLogin() {
    Get.toNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        MediaQuery.of(context).size.width > 1200
            ? 125.0
            : MediaQuery.of(context).size.width > 800
            ? 50.0
            : 20.0;
    final verticalPadding = 50.0;

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor:
            isDarkMode
                ? AppColors.backgroundColorDark
                : AppColors.backgroundColorLight,
        appBar: const AppNavbarPreHome(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              AppHeader(
                imagePaths: [
                  'https://images.unsplash.com/photo-1568430462989-44163eb1752f?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'https://images.unsplash.com/photo-1618578906891-86e569eefe7e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'https://images.unsplash.com/photo-1596952687581-9bd164398339?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'https://images.unsplash.com/photo-1695231054363-f149bb54841e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'https://images.unsplash.com/photo-1665150922942-9f48fc21005f?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  'https://images.unsplash.com/photo-1650633908245-f0b552e8f240?q=80&w=1933&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ],
                title: 'Bienvenido a BlueMind',
                subtitle:
                    'Explora nuestro contenido educativo y descubre la biodiversidad',
                height: 250,
              ),

              // Content with padding
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Nature images
                    SectionTitle(title: 'Blog'),
                    const SizedBox(height: 12),
                    _previewImages(
                      [
                        {
                          'url':
                              'assets/blog/13.jpg',
                          'title': 'Ballenas Jorobadas: Gigantes del Cambio Climático',
                          'description':
                              'Las ballenas jorobadas no solo son iconos de la vida marina, sino también aliadas contra el cambio climático. Cada ejemplar captura hasta 33 toneladas de CO₂ en su vida y fertiliza el fitoplancton, que absorbe el 40% del CO₂ global. Este artículo revela su rol ecológico y las amenazas que enfrentan.',
                        },
                        {
                          'url':
                              'assets/blog/4.jpg',
                          'title': 'La Importancia de los Manglares en la Protección Costera',
                          'description': 'Los manglares son ecosistemas costeros únicos que actúan como barreras naturales contra tormentas, tsunamis y erosión, además de ser criaderos esenciales para especies marinas. Sin embargo, su destrucción debido a la urbanización, la acuicultura y el cambio climático amenaza su supervivencia. Este artículo analiza su rol ecológico, las causas de su degradación y las estrategias para su conservación.',
                        },
                        {
                          'url':
                              'assets/blog/7.jpg',
                          'title': 'El Misterio de las Zonas Muertas del Océano',
                          'description': 'Las "zonas muertas" son áreas marinas con niveles de oxígeno tan bajos que la vida acuática no puede sobrevivir. Causadas por la contaminación humana y el cambio climático, su número se ha cuadruplicado desde 1950. Este artículo explora su formación, impactos y cómo revertir su expansión.',
                        },
                        {
                          'url':
                              'assets/blog/1.jpg',
                          'title': 'El Impacto del Cambio Climático en los Arrecifes de Coral',
                          'description': 'Los arrecifes de coral son ecosistemas marinos vitales que albergan una gran biodiversidad y proporcionan servicios esenciales para el ser humano, como protección costera, recursos pesqueros y turismo. Sin embargo, el cambio climático está provocando su deterioro acelerado debido al aumento de la temperatura del mar, la acidificación oceánica, el blanqueamiento de coral y los fenómenos meteorológicos extremos. ',
                        },
                      ],
                      onTap: _navigateToLogin,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 50),

                    // Section 2: Education images
                    SectionTitle(title: 'Recursos Educativos'),
                    const SizedBox(height: 12),
                    _previewImages(
                      [
                        {
                          'url':
                              'https://cdn.pixabay.com/photo/2014/07/08/12/39/dolphin-386744_1280.jpg',
                          'title': 'Delfín Nariz de Botella. ',
                          'description':
                              'El delfín nariz de botella es una de las especies más conocidas y estudiadas del mundo marino. Su nombre proviene de su hocico alargado y curvado que se asemeja a la boquilla de una botella. Es inteligente, sociable y altamente adaptable, lo que le permite habitar una gran variedad de ambientes marinos. Su presencia es común tanto en aguas costeras como en alta mar.',
                        },
                        {
                          'url':
                              'assets/album/En peligro crítico (CR)/caballitoMarKnysna2.jpg',
                          'title': 'Caballito de mar de Knysna',
                          'description': 'El caballito de mar de Knysna es el único representante del género *Hippocampus* endémico de África. Debido a su limitada distribución y pérdida de hábitat, es una de las especies más vulnerables del grupo.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/eubalaenaGlacialis1.jpg',
                          'title': 'Ballena franca del Atlántico Norte',
                          'description': 'La ballena franca del Atlántico Norte es una de las ballenas más amenazadas del mundo. Fue cazada casi hasta la extinción por su grasa y aceite. Hoy enfrenta nuevas amenazas como colisiones con barcos y enredos en redes.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/calamarVampiro3.jpg',
                          'title': 'Calamar vampiro',
                          'description': 'El calamar vampiro no es realmente un pulpo ni un calamar, sino una especie única que representa un linaje evolutivo aparte. Vive en condiciones extremas y tiene adaptaciones únicas para sobrevivir en ambientes con muy poco oxígeno.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/medusaCajaAustraliana2.jpg',
                          'title': 'Medusa caja australiana',
                          'description': 'La medusa caja australiana es considerada una de las criaturas más venenosas del mundo. Tiene una estructura en forma de campana transparente y tentáculos extremadamente largos y potentes. A pesar de su peligrosidad, cumple un rol importante en los ecosistemas marinos.',
                        },
                      ],
                      onTap: _navigateToLogin,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 50),

                    // Section 3: Wildlife images
                    SectionTitle(title: 'Álbum de Especies'),
                    const SizedBox(height: 12),
                    _previewImages(
                      [
                        {
                          'url':
                              'https://cdn.pixabay.com/photo/2014/07/08/12/39/dolphin-386744_1280.jpg',
                          'title': 'Delfín Nariz de Botella. ',
                          'description':
                              'El delfín nariz de botella es una de las especies más conocidas y estudiadas del mundo marino. Su nombre proviene de su hocico alargado y curvado que se asemeja a la boquilla de una botella. Es inteligente, sociable y altamente adaptable, lo que le permite habitar una gran variedad de ambientes marinos. Su presencia es común tanto en aguas costeras como en alta mar.',
                        },
                        {
                          'url':
                              'assets/album/En peligro crítico (CR)/caballitoMarKnysna2.jpg',
                          'title': 'Caballito de mar de Knysna',
                          'description': 'El caballito de mar de Knysna es el único representante del género *Hippocampus* endémico de África. Debido a su limitada distribución y pérdida de hábitat, es una de las especies más vulnerables del grupo.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/eubalaenaGlacialis1.jpg',
                          'title': 'Ballena franca del Atlántico Norte',
                          'description': 'La ballena franca del Atlántico Norte es una de las ballenas más amenazadas del mundo. Fue cazada casi hasta la extinción por su grasa y aceite. Hoy enfrenta nuevas amenazas como colisiones con barcos y enredos en redes.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/calamarVampiro3.jpg',
                          'title': 'Calamar vampiro',
                          'description': 'El calamar vampiro no es realmente un pulpo ni un calamar, sino una especie única que representa un linaje evolutivo aparte. Vive en condiciones extremas y tiene adaptaciones únicas para sobrevivir en ambientes con muy poco oxígeno.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/medusaCajaAustraliana2.jpg',
                          'title': 'Medusa caja australiana',
                          'description': 'La medusa caja australiana es considerada una de las criaturas más venenosas del mundo. Tiene una estructura en forma de campana transparente y tentáculos extremadamente largos y potentes. A pesar de su peligrosidad, cumple un rol importante en los ecosistemas marinos.',
                        },
                        {
                          'url':
                              'assets/album/En peligro (EN)/orcinusOrca2.jpg',
                          'title': 'Orca residente del sur',
                          'description': 'Las orcas residentes del sur son un grupo culturalmente único de cetáceos que se alimentan principalmente de salmón chinook. Su población ha disminuido drásticamente debido a la reducción de presas y contaminación.',
                        },
                        {
                          'url':'assets/album/Extinta(EX)/chelonoidisAbingdoniiMain.jpg',
                          'title': 'Tortuga gigante de la isla Pinta',
                          'description': 'Esta tortuga gigante era una subespecie endémica de Galápagos. Fue famosa mundialmente por Lonesome George, último individuo conocido, símbolo global de la conservación.',
                        },
                        {
                          'url':'assets/album/En peligro (EN)/pingüinoGalápagosMain.jpg',
                          'title': 'Pingüino de Galápagos',
                          'description': 'El pingüino de Galápagos es el único pingüino que vive en el hemisferio norte. Adaptado al calor, busca refugio en cuevas y utiliza corrientes frías para alimentarse. Es vulnerable al cambio climático y eventos El Niño.',
                        },
                        {
                          'url':'assets/album/En peligro (EN)/tiburonMartilloMain.jpg',
                          'title': 'Tiburón martillo',
                          'description': 'El tiburón martillo tiene una cabeza ancha y aplanada que le permite tener una visión panorámica y detectar presas enterradas. Es objeto de pesca intensiva para aletas y carne, lo que ha reducido sus poblaciones.',
                        },
                        {
                          'url':'assets/album/En peligro crítico (CR)/tridacnaGigasMain.jpg',
                          'title': 'Almeja gigante del Pacífico Occidental',
                          'description': 'La almeja gigante es el mayor molusco bivalvo del mundo. Vive en simbiosis con algas zooxantelas y filtra el agua constantemente. Su sobreexplotación la ha llevado al borde de la extinción.',
                        },
                        {
                          'url':'assets/album/En peligro crítico (CR)/coralPilarMain.jpg',
                          'title': 'Coral pilar',
                          'description': 'El coral pilar forma columnas gruesas verticales que pueden alcanzar varios metros de altura. Es resistente a tormentas pero vulnerable al blanqueamiento y enfermedades.',
                        },
                        {
                          'url':'assets/album/En peligro crítico (CR)/pezSierraDientesGrandes2.jpg',
                          'title': 'Pez sierra de dientes grandes',
                          'description': 'El pez sierra de dientes grandes es un elasmobranquio reconocible por su hocico largo y dentado que utiliza para cazar y defenderse. Ha sufrido disminuciones dramáticas debido a la pesca incidental y pérdida de hábitats.',
                        },
                      ],
                      onTap: _navigateToLogin,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),

              // Footer
              const AppPreFooter(),
            ],
          ),
        ),
      );
    });
  }

  Widget _previewImages(
    List<Map<String, String>> images, {
    VoidCallback? onTap,
    required bool isDarkMode,
    double imageHeight = 550,
  }) {
    return CarouselSlider(
      options: CarouselOptions(
        height: imageHeight,
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 0.6,
      ),
      items:
          images.map((imageData) {
            final imageUrl = imageData['url']!;
            final title = imageData['title'] ?? '';
            final description = imageData['description'] ?? '';

            return GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDarkMode
                                ? Colors.black45
                                : Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Stack(
                      children: [
                        // Imagen de fondo
                        Positioned.fill(
                          child:
                              imageUrl.startsWith('http')
                                  ? Image.network(imageUrl, fit: BoxFit.cover)
                                  : Image.asset(imageUrl, fit: BoxFit.cover),
                        ),

                        // Contenedor de textos en el lado izquierdo
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          width: 350, // Ajusta el ancho según necesites
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: AppTypography.h2SubtitulosImportantes
                                      .copyWith(
                                        color:
                                            Colors
                                                .white, // Sobrescribes el color si quieres
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  description,
                                  style: AppTypography.parrafos.copyWith(
                                    color:
                                        Colors
                                            .white70, // Sobrescribes el color si quieres
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final bool isDarkMode = themeController.isDarkMode.value;

    return Text(
      title,
      style: AppTypography.h2SubtitulosImportantes.copyWith(
        color: isDarkMode ? AppColors.textColorDark : AppColors.textColorLight,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//CORRECTO1
