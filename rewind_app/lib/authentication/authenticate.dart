import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewind_app/authentication/register.dart';
import 'package:rewind_app/authentication/sign_in.dart';
import 'package:rewind_app/controllers/auth_page_ctrl.dart';

class Authenticate extends GetWidget<SignInPageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.showSignInPage.value
          ? SignInWithEmail()
          : CreateAccWithEmail();
    });
  }
}
