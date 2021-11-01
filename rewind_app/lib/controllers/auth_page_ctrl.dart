import 'package:get/get.dart';

class SignInPageController extends GetxController {
  var showSignInPage = true.obs;

  void toggleView() {
    showSignInPage.value = !showSignInPage.value;
  }
}
