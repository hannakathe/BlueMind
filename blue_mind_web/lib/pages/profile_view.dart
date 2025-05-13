import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';

class ProfileView extends StatefulWidget {
  final FirebaseAuth auth;

  const ProfileView({super.key, required this.auth});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? get user => widget.auth.currentUser;

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

    return Scaffold(
      appBar: AppNavbar(),
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
                            _buildProfileColumn(),
                            const SizedBox(height: 30),
                            _buildFormColumn(isMobile),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProfileColumn(),
                            const SizedBox(width: 30),
                            Expanded(child: _buildFormColumn(isMobile)),
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
  }

  Widget _buildProfileColumn() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey,
          child: Icon(Icons.photo_camera, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(user?.displayName ?? 'Usuario',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(user?.email ?? 'usuario@email.com'),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: const Text('Eliminar Cuenta', style: TextStyle(color: Colors.red)),
        ),
        const SizedBox(height: 10),
        MaterialButton(
          color: Colors.blueAccent,
          child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
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

  Widget _buildFormColumn(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Información personal',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        isMobile
            ? Column(
                children: [
                  _buildTextField(label: 'Nombres', controller: nameController),
                  const SizedBox(height: 10),
                  _buildTextField(label: 'Apellidos', controller: lastNameController),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        label: 'Nombres', controller: nameController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                        label: 'Apellidos', controller: lastNameController),
                  ),
                ],
              ),
        const SizedBox(height: 10),
        _buildTextField(label: 'Usuario', controller: usernameController),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCode,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country['code'],
                      child: Row(
                        children: [
                          Image.asset(country['flag']!, width: 24, height: 24),
                          const SizedBox(width: 8),
                          Text('${country['name']} ${country['code']}'),
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
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTextField(label: 'Teléfono', controller: phoneController),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildTextField(label: 'Email', controller: emailController),
        const SizedBox(height: 10),
        isMobile
            ? Column(
                children: [
                  _buildTextField(
                    label: 'Anterior contraseña',
                    controller: oldPasswordController,
                    obscureText: obscureOldPassword,
                    suffixIcon: _buildVisibilityIcon(
                      isObscure: obscureOldPassword,
                      toggle: () => setState(() => obscureOldPassword = !obscureOldPassword),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Nueva contraseña',
                    controller: newPasswordController,
                    obscureText: obscureNewPassword,
                    suffixIcon: _buildVisibilityIcon(
                      isObscure: obscureNewPassword,
                      toggle: () => setState(() => obscureNewPassword = !obscureNewPassword),
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
                      suffixIcon: _buildVisibilityIcon(
                        isObscure: obscureOldPassword,
                        toggle: () =>
                            setState(() => obscureOldPassword = !obscureOldPassword),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: 'Nueva contraseña',
                      controller: newPasswordController,
                      obscureText: obscureNewPassword,
                      suffixIcon: _buildVisibilityIcon(
                        isObscure: obscureNewPassword,
                        toggle: () =>
                            setState(() => obscureNewPassword = !obscureNewPassword),
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
  }) {
    return IconButton(
      icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
      onPressed: toggle,
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    TextEditingController? controller,
    Widget? suffixIcon,
    Color textColor = Colors.black,
    Color backgroundColor = Colors.white,
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
          fillColor: backgroundColor.withOpacity(0.1),
          labelText: label,
          labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
