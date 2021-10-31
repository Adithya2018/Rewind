import 'package:rewind_app/app_data/app_data.dart';
import 'package:rewind_app/app_data/app_data_state.dart';
import 'package:rewind_app/database_provider/local_db.dart';
import 'package:rewind_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    return LocalDBWrapper();
    if (user != null) {
      print("${user.uid} is signed in");
      AppDataCommon.of(context).setUserData(user);
      return LocalDBWrapper();
    } else {
      print("$user was signed out");
      AppDataCommon.of(context).setUserData(user);
      return Authenticate();
    }
  }
}
