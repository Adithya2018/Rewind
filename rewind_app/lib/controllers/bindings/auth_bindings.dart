import 'package:get/get.dart';
import 'package:rewind_app/controllers/auth_page_ctrl.dart';
import '../auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<SignInPageController>(
      () => SignInPageController(),
    );
  }
}
