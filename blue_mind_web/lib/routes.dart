import 'package:get/get.dart';
import 'pages/album_view.dart';
import 'pages/blog_view.dart';
import 'pages/library_view.dart';
import 'pages/pre_home_view.dart';
import 'pages/home_view.dart';
import 'pages/login_view.dart';
import 'pages/profile_view.dart';
import 'pages/register_view.dart';

class AppRoutes {
  static const String preHome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String blog = '/blog';
  static const String library = '/library';
  static const String album = '/album';
  


  static List<GetPage> routes = [
    GetPage(name: preHome, page: () => PreHomeScreen()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: register, page: () => RegisterView()),

    GetPage(name: home, page: () => HomeView(auth: Get.arguments['auth'])),
    GetPage(name: profile, page: () => ProfileView(auth: Get.arguments['auth'])),
    GetPage(name: blog, page: () => BlogView()),
    GetPage(name: library, page: () => LibraryView()),
    GetPage(name: album, page: () => AlbumView()),
    
  ];
}


//ademas revisar logica de inicio de sesion facebook y google al iniciar la app debe ir al home 
