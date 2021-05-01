import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import 'package:rewind_app/todo_list/todo_list_state/todo_list_state.dart';

class RegularTasksList extends StatefulWidget {
  @override
  _RegularTasksListState createState() => _RegularTasksListState();
}

class _RegularTasksListState extends State<RegularTasksList>
    with AutomaticKeepAliveClientMixin<RegularTasksList> {
  List<RegularTask> listOfRegularTask = [];
  List<Container> listOfTasksTiles = [];
  bool ascendingOrder = true;
  int sortByOption = 0;
  List<Function> sortByFunction = [
    //(RegularTask a, RegularTask b) => a.created.compareTo(b.created),
    (RegularTask a, RegularTask b) => a.deadline.compareTo(b.deadline),
    (RegularTask a, RegularTask b) => a.level.compareTo(b.level),
  ];
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    //from https://stackoverflow.com/questions/53674092/preserve-widget-state-in-pageview-while-enabling-navigation/53702330#53702330
    super.build(context);

    //final counter = StateInheritedWidget.of(context).state.counter;

    /**/final provider = TodoListCommon.of(context);
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: List.generate(
              provider.state.numbers.length,
              (index) => Text(
                "${provider.state.numbers[index]}",
              ),
            ),
          ),
          Text("data = $count"),
          IconButton(
            onPressed: () {
              provider.addToList();
              setState(() {
                ++count;
              });
            },
            icon: Icon(
              MaterialCommunityIcons.pi,
            ),
          ),
        ],
      ),
    );
  }
}
