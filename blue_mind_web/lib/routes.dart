import 'package:get/get.dart';
import 'pages/login_view.dart';
import 'pages/pre_home_view.dart';
import 'pages/register_view.dart';

class AppRoutes {
  static const String preHome = '/';
  static const String login = '/login';
  static const String register = '/register';

  static List<GetPage> routes = [
    GetPage(name: preHome, page: () => PreHomeScreen()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: register, page: () => RegisterView()),
  ];
}
