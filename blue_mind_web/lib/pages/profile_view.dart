import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class ProfileView extends StatefulWidget {
  final FirebaseAuth auth;

  const ProfileView({super.key, required this.auth});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? get user => widget.auth.currentUser;
  final ThemeController themeController = Get.find<ThemeController>();

  final List<Map<String, String>> countries = [
    {'name': 'Colombia', 'code': '+57', 'flag': 'assets/flags/co.png'},
    {'name': 'México', 'code': '+52', 'flag': 'assets/flags/mx.png'},
    {'name': 'Argentina', 'code': '+54', 'flag': 'assets/flags/ar.png'},
    {'name': 'Perú', 'code': '+51', 'flag': 'assets/flags/pe.png'},
    {'name': 'Chile', 'code': '+56', 'flag': 'assets/flags/cl.png'},
  ];

  String selectedCode = '+57';
  String selectedFlag = 'assets/flags/co.png';
  String selectedCountry = 'Colombia';
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final horizontalPadding = isMobile ? 20.0 : 125.0;
    final verticalPadding = 50.0;

    return Obx(() {
      final bool isDarkMode = themeController.isDarkMode.value;
      final textColor = isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;
      final cardColor = isDarkMode ? AppColors.inputFieldDark : AppColors.backgroundColorLight;

      return Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.backgroundColorDark
            : AppColors.backgroundColorLight,
        appBar: const AppNavbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppHeader(
                imagePath:
                    'https://images.unsplash.com/photo-1650633908245-f0b552e8f240?q=80&w=1933&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                title: 'Perfil',
                subtitle: 'Gestiona tu información',
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    isMobile
                        ? Column(
                            children: [
                              _buildProfileColumn(isDarkMode, textColor),
                              const SizedBox(height: 30),
                              _buildFormColumn(isMobile, isDarkMode, textColor, cardColor),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileColumn(isDarkMode, textColor),
                              const SizedBox(width: 30),
                              Expanded(
                                child: _buildFormColumn(isMobile, isDarkMode, textColor, cardColor),
                              ),
                            ],
                          ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              const AppFooter(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProfileColumn(bool isDarkMode, Color textColor) {
  return Column(
    children: [
      CircleAvatar(
        radius: 70,
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey,
        child: Icon(
          Icons.photo_camera, 
          size: 30, 
          color: isDarkMode ? Colors.white70 : Colors.white,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        user?.displayName ?? 'Usuario',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      Text(
        user?.email ?? 'usuario@email.com',
        style: TextStyle(color: textColor.withOpacity(0.8)),
      ),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () {},
        child: Text(
          'Eliminar Cuenta', 
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      ),
      const SizedBox(height: 10),
      MaterialButton(
        color: isDarkMode ? Colors.blue[800] : Colors.blueAccent,
        child: Text(
          'Cerrar Sesión', 
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await widget.auth.signOut();
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.preHome,
              (route) => false,
            );
          }
        },
      ),
    ],
  );
}

  Widget _buildFormColumn(bool isMobile, bool isDarkMode, Color textColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información personal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        isMobile
            ? Column(
                children: [
                  _buildTextField(
                    label: 'Nombres', 
                    controller: nameController,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    cardColor: cardColor,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Apellidos', 
                    controller: lastNameController,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    cardColor: cardColor,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Nombres', 
                      controller: nameController,
                      isDarkMode: isDarkMode,
                      textColor: textColor,
                      cardColor: cardColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: 'Apellidos', 
                      controller: lastNameController,
                      isDarkMode: isDarkMode,
                      textColor: textColor,
                      cardColor: cardColor,
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 10),
        _buildTextField(
          label: 'Usuario', 
          controller: usernameController,
          isDarkMode: isDarkMode,
          textColor: textColor,
          cardColor: cardColor,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: cardColor.withOpacity(0.1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
                  value: selectedCode,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country['code'],
                      child: Row(
                        children: [
                          Image.asset(country['flag']!, width: 24, height: 24),
                          const SizedBox(width: 8),
                          Text(
                            '${country['name']} ${country['code']}',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    final country =
                        countries.firstWhere((c) => c['code'] == value);
                    setState(() {
                      selectedCode = value!;
                      selectedFlag = country['flag']!;
                      selectedCountry = country['name']!;
                    });
                  },
                  style: TextStyle(color: textColor),
                  icon: Icon(Icons.arrow_drop_down, color: textColor),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTextField(
                label: 'Teléfono', 
                controller: phoneController,
                isDarkMode: isDarkMode,
                textColor: textColor,
                cardColor: cardColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Cuenta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        _buildTextField(
          label: 'Email', 
          controller: emailController,
          isDarkMode: isDarkMode,
          textColor: textColor,
          cardColor: cardColor,
        ),
        const SizedBox(height: 10),
        isMobile
            ? Column(
                children: [
                  _buildTextField(
                    label: 'Anterior contraseña',
                    controller: oldPasswordController,
                    obscureText: obscureOldPassword,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    cardColor: cardColor,
                    suffixIcon: _buildVisibilityIcon(
                      isObscure: obscureOldPassword,
                      toggle: () => setState(() => obscureOldPassword = !obscureOldPassword),
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Nueva contraseña',
                    controller: newPasswordController,
                    obscureText: obscureNewPassword,
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                    cardColor: cardColor,
                    suffixIcon: _buildVisibilityIcon(
                      isObscure: obscureNewPassword,
                      toggle: () => setState(() => obscureNewPassword = !obscureNewPassword),
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Anterior contraseña',
                      controller: oldPasswordController,
                      obscureText: obscureOldPassword,
                      isDarkMode: isDarkMode,
                      textColor: textColor,
                      cardColor: cardColor,
                      suffixIcon: _buildVisibilityIcon(
                        isObscure: obscureOldPassword,
                        toggle: () =>
                            setState(() => obscureOldPassword = !obscureOldPassword),
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: 'Nueva contraseña',
                      controller: newPasswordController,
                      obscureText: obscureNewPassword,
                      isDarkMode: isDarkMode,
                      textColor: textColor,
                      cardColor: cardColor,
                      suffixIcon: _buildVisibilityIcon(
                        isObscure: obscureNewPassword,
                        toggle: () =>
                            setState(() => obscureNewPassword = !obscureNewPassword),
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  IconButton _buildVisibilityIcon({
    required bool isObscure,
    required VoidCallback toggle,
    required bool isDarkMode,
  }) {
    return IconButton(
      icon: Icon(
        isObscure ? Icons.visibility : Icons.visibility_off,
        color: isDarkMode ? Colors.white70 : Colors.black54,
      ),
      onPressed: toggle,
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    TextEditingController? controller,
    Widget? suffixIcon,
    required bool isDarkMode,
    required Color textColor,
    required Color cardColor,
    double width = double.infinity,
    double height = 60,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: textColor),
        cursorColor: textColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? cardColor.withOpacity(0.2) : cardColor.withOpacity(0.1),
          labelText: label,
          labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.blue[400]! : Colors.blueAccent,
            ),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}