import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/common_screens/message_scaffold.dart';
import 'package:rewind_app/controllers/bindings/auth_bindings.dart';
import 'package:rewind_app/journal/journal.dart';
import 'package:rewind_app/models/interval/interval.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';
import 'package:rewind_app/todo_list/edit_task.dart';
import 'package:rewind_app/todo_list/todo_list.dart';
import 'package:rewind_app/authentication/authentication_wrapper.dart';
import 'package:path_provider/path_provider.dart' as ppr;
import 'achievements/achievements.dart';
import 'controllers/bindings/journal_bindings.dart';
import 'controllers/bindings/todo_list_bindings.dart';
import 'models/regular_task/regular_task.dart';
import 'models/task/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final appDocDirectory = await ppr.getApplicationDocumentsDirectory();
  appDocDirectory.list(recursive: true).forEach((element) {
    print("${element.uri}");
    print("${element.uri}");
  });
  Hive.init(appDocDirectory.path);
  Hive.registerAdapter(JournalPageAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(RegularTaskAdapter());
  Hive.registerAdapter(TimeIntervalAdapter());
  runApp(RewindApp());
}

class RewindApp extends StatefulWidget {
  const RewindApp({Key? key}) : super(key: key);

  @override
  _RewindAppState createState() => _RewindAppState();
}

class _RewindAppState extends State<RewindApp> {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return /*AppDataWrapper(
      child: ,
    )*/
        GetMaterialApp(
      title: 'Rewind App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: AuthBindings(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SimpleMessageScaffold(
              message: "Cannot load",
              iconData: CommunityMaterialIcons.robot,
            );
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            print("ConnectionState.done");
            return AuthWrapper();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return SimpleMessageScaffold(
            message: "Loading...",
            iconData: Icons.info,
          );
        },
      ),
      getPages: [
        GetPage(
          name: '/jou',
          binding: JournalBindings(),
          page: () => Journal(),
        ),
        GetPage(
          name: '/tdl',
          binding: TodoListBindings(),
          page: () => TodoList(),
        ),
      ],
      routes: <String, WidgetBuilder>{
        '/ach': (BuildContext context) => Achievements(),
        '/vt': (BuildContext context) => EditTask(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void dispose() {
    print("closing app");
    Hive.close();
    super.dispose();
  }
}
