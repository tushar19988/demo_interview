import 'package:demo_interview/utils/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  login() async {
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> signup(String email, String password) async {
    Get.offAllNamed(AppRoutes.home);
  }
}
