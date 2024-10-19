import 'package:demo_interview/screen/home_screen.dart';
import 'package:demo_interview/screen/login_screen.dart';
import 'package:demo_interview/screen/signup_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
    ),
  ];
}
