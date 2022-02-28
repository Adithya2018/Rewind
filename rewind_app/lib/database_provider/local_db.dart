import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/common_screens/message_scaffold.dart';
import 'package:rewind_app/views/home/home.dart';

class LocalDBWrapper extends StatefulWidget {
  const LocalDBWrapper({Key? key}) : super(key: key);

  @override
  _LocalDBWrapperState createState() => _LocalDBWrapperState();
}

class _LocalDBWrapperState extends State<LocalDBWrapper> {
  String? nameSuffix;
  String? journalBoxName;
  String? goalBoxName;
  String? routineBoxName;

  Future<void> openBoxes() async {
    nameSuffix = ''; // AppDataCommon.of(context).appData!.userdata!.uid;
    journalBoxName = '${nameSuffix}journal';
    goalBoxName = '${nameSuffix}goals';
    routineBoxName = '${nameSuffix}routine';
    print("opening boxes");
    await Hive.openBox('$journalBoxName');
    await Hive.openBox('$goalBoxName');
    await Hive.openBox('$routineBoxName');
  }

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
              message: "Cannot load",
              iconData: CommunityMaterialIcons.robot,
            );
          } else {
            print('Home()');
            return Home();
          }
        }
        return SimpleMessageScaffold(
          message: "Loading...",
          iconData: Icons.not_interested,
        );
      },
    );
  }
}
