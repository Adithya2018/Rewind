import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/app_data/app_data_state.dart';
import 'package:rewind_app/common_screens/message_scaffold.dart';
import 'package:rewind_app/home/home.dart';

class LocalDBWrapper extends StatefulWidget {
  const LocalDBWrapper({Key key}) : super(key: key);

  @override
  _LocalDBWrapperState createState() => _LocalDBWrapperState();
}

class _LocalDBWrapperState extends State<LocalDBWrapper> {
  String get nameSuffix => AppDataCommon.of(context).appData.userdata.uid;
  Future<void> openBoxes() async {

    print("opening boxes");
    await Hive.openBox('$journalBoxName');
    await Hive.openBox('$goalBoxName');
    await Hive.openBox('$routineBoxName');
  }

  String get journalBoxName => '${nameSuffix}journal';
  String get goalBoxName => '${nameSuffix}goals';
  String get routineBoxName => '${nameSuffix}routine';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: openBoxes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SimpleMessageScaffold(
              message:"Cannot load",
              iconData:MaterialCommunityIcons.robot,
            );
          } else
            return Home();
        }
        return SimpleMessageScaffold(
          message:"Loading...",
          iconData:FontAwesome5Solid.hourglass_half,
        );
      },
    );
  }
}
