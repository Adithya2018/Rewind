import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/todo_list/todo_list.dart';
import 'package:rewind_app/todo_list/todo_list_state/todo_list_state.dart';

class TodoListDBWrapper extends StatefulWidget {
  const TodoListDBWrapper({Key key}) : super(key: key);

  @override
  _TodoListDBWrapperState createState() => _TodoListDBWrapperState();
}

class _TodoListDBWrapperState extends State<TodoListDBWrapper> {
  List<Box> boxList = []; //might be required to use sometime
  Future<void> openBoxes() async {
    await Hive.openBox('goals');
    await Hive.openBox('routine');
  }

  final notifier = ValueNotifier(
    DateTime.now().second,
  );

  @override
  void initState() {
    super.initState();
    notifier.addListener(() {
      print("${notifier.value}");
    });
  }

  @override
  void dispose() {
    Hive.deleteFromDisk();
    Hive.close();
    super.dispose();
  }

  Scaffold messageScaffold(String message, IconData iconData) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.yellow,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              message,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: openBoxes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return messageScaffold(
              "Cannot load",
              MaterialCommunityIcons.robot,
            );
          } else
            return TodoListWrapper(
              child: TodoList(),
            );
        }
        return messageScaffold(
          "Loading...",
          FontAwesome5Solid.hourglass_half,
        );
      },
    );
  }
}
