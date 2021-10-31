import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rewind_app/app_data/app_data_state.dart';
import 'package:rewind_app/common_screens/message_scaffold.dart';
import 'package:rewind_app/controllers/journal_ctrl.dart';
import 'package:rewind_app/journal/journal.dart';
import 'package:rewind_app/journal/journal_state.dart';
import 'package:rewind_app/models/interval/interval.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';
import 'package:rewind_app/services/auth_ctrl.dart';
import 'package:rewind_app/todo_list/edit_task.dart';
import 'package:rewind_app/todo_list/todo_list.dart';
import 'package:rewind_app/todo_list/todo_list_state/todo_list_state.dart';
import 'package:rewind_app/authentication/authentication_wrapper.dart';
import 'package:path_provider/path_provider.dart' as ppr;
import 'achievements/achievements.dart';
import 'controllers/bindings/journal_bindings.dart';
import 'controllers/bindings/todo_list_bindings.dart';
import 'models/regular_task/regular_task.dart';
import 'models/task/task.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /**/ await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final appDocDirectory = await ppr.getApplicationDocumentsDirectory();
  appDocDirectory
      .list(
    recursive: true,
  )
      .forEach((element) {
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
    return AppDataWrapper(
      child: GetMaterialApp(
        title: 'Rewind App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SimpleMessageScaffold(
                message: "Cannot load",
                iconData: Icons.info, // MaterialCommunityIcons.robot,
              );
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              print("ConnectionState.done");
              return StreamProvider<UserData?>.value(
                value: AuthService().user,
                initialData: null,
                child: AuthenticationWrapper(),
              );
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
            name: '/ach',
            binding: TodoListBindings(),
            page: () => TodoList(),
          ),
        ],
        routes: <String, WidgetBuilder>{
          '/ach': (BuildContext context) => Achievements(),
          '/jou': (BuildContext context) => JournalWrapper(
                boxNameSuffix:
                    '', //AppDataCommon.of(context).appData!.userdata!.uid,
                child: Journal(),
              ),
          '/tdl': (BuildContext context) => TodoListWrapper(
                boxNameSuffix:
                    '', //AppDataCommon.of(context).appData!.userdata!.uid,
                child: TodoList(),
              ),
          '/vt': (BuildContext context) => EditTask(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  void dispose() {
    print("closing app");
    Hive.close();
    super.dispose();
  }
}

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the views.home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
/*class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      views.home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  //SharedPreferencesDemo({Key? key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  /*late*/ Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Center(
          child: FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                            'This should persist across restarts.',
                      );
                    }
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
