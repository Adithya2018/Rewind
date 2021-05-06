import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/todo_list/todo_list.dart';

class TodoListDBWrapper extends StatefulWidget {
  const TodoListDBWrapper({Key key}) : super(key: key);

  @override
  _TodoListDBWrapperState createState() => _TodoListDBWrapperState();
}

class _TodoListDBWrapperState extends State<TodoListDBWrapper> {
  @override
  void initState() {
    print("initializing todo DB");
    super.initState();
  }
  @override
  void dispose() {
    print("closing and deleting");
    Hive.close();
    Hive.deleteBoxFromDisk('todo');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('todo'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("DB error");
          } else
            return TodoList();
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesome5Solid.hourglass_half,
                  color: Colors.yellow,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Loading...",
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
