import 'package:get/get.dart';
import 'package:rewind_app/controllers/auth_controller.dart';
import 'package:rewind_app/database_provider/local_db.dart';
import 'package:flutter/material.dart';

import 'authenticate.dart';

class AuthWrapper extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    if (controller.user != null) {
      print("${controller.user!.uid} is signed in");
      //AppDataCommon.of(context).setUserData(user);
      return LocalDBWrapper();
    } else {
      return Authenticate();
    }
  }
}
