import 'package:flutter/material.dart';
import 'package:rewind_app/todo_list/todo_list_data/todo_list_data.dart';

class TodoListWrapper extends StatefulWidget {
  final Widget child;
  const TodoListWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _TodoListWrapperState createState() => _TodoListWrapperState();
}

class _TodoListWrapperState extends State<TodoListWrapper> {
  TodoListData state = TodoListData();

  @override
  Widget build(BuildContext context) => TodoListCommon(
        child: widget.child,
        state: state,
        stateWidget: this,
      );

  void addToList() {
    List<int> newList = state.numbers + [-1];
    final numbers = newList;
    final newState = state.copy(numbers: numbers);
    setState(() => state = newState);
  }
}

class TodoListCommon extends InheritedWidget {
  final TodoListData state;
  final _TodoListWrapperState stateWidget;

  const TodoListCommon({
    Key key,
    @required Widget child,
    @required this.state,
    @required this.stateWidget,
  }) : super(child: child);

  static _TodoListWrapperState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<TodoListCommon>()
      .stateWidget;

  @override
  bool updateShouldNotify(TodoListCommon oldWidget) {
    return oldWidget.state != state;
  }
}
