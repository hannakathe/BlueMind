import 'package:get/get.dart';
import 'pages/pre_home_view.dart';
import 'pages/home_view.dart';
import 'pages/login_view.dart';
import 'pages/profile_view.dart';
import 'pages/register_view.dart';

class AppRoutes {
  static const String preHome = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';


  static List<GetPage> routes = [
    GetPage(name: preHome, page: () => PreHomeScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: register, page: () => RegisterView()),
    GetPage(name: profile, page: () => ProfileView()),
  ];
}
