import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rewind_app/common_screens/message_scaffold.dart';
import 'package:rewind_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_data.dart';

class AppDataWrapper extends StatefulWidget {
  final Widget child;
  const AppDataWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _AppDataWrapperState createState() => _AppDataWrapperState();
}

class _AppDataWrapperState extends State<AppDataWrapper> {
  AppData appData;

  @override
  void initState() {
    print("_AppDataWrapperState init");
    appData = AppData(userName: "");
    super.initState();
  }

  void setUserData(UserData userdata) {
    appData = appData.copy(userdata: userdata);
  }

  Future<void> initializeGameInfo() async {
    print("initializing preferences");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = !prefs.containsKey("userID") ? "" : prefs.getString("userID");
    print("initializing preferences");
    print("keys=${prefs.getKeys()}");
    await prefs.setString("userID", userID).then((bool success) {
      print("userID set? success=$success");
      return userID;
    }).onError((error, stackTrace) {
      print("initializing userID unsuccessful");
      return "userID";
    });
    print("initializing finished");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeGameInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SimpleMessageScaffold(
              message: "Cannot load",
              iconData: MaterialCommunityIcons.robot,
            );
          } else
            return AppDataCommon(
              child: widget.child,
              appData: appData,
              stateWidget: this,
            );
        }
        return SimpleMessageScaffold(
          message: "Loading...",
          iconData: FontAwesome5Solid.hourglass_half,
        );
      },
    );
  }
}

class AppDataCommon extends InheritedWidget {
  final AppData appData;
  final _AppDataWrapperState stateWidget;

  const AppDataCommon({
    Key key,
    @required Widget child,
    @required this.appData,
    @required this.stateWidget,
  }) : super(child: child);

  static _AppDataWrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataCommon>().stateWidget;

  @override
  bool updateShouldNotify(AppDataCommon oldWidget) {
    return true; //oldWidget.gldState != gldState;
  }
}
