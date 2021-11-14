import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/journal/journal_data.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';

class JournalController extends GetxController {
  late String? boxNameSuffix;
  /*const JournalController({
    Key? key,
    required this.child,
    required this.boxNameSuffix,
  }) : super(key: key);
  @override
  _JournalControllerState createState() => _JournalControllerState();*/

  Rxn<JournalData> journalData = Rxn<JournalData>();
  static String journalBoxName = 'journal';

  String dateTimeToKey(DateTime date) {
    String result = "";
    result += date.year.toString();
    result += date.month.toString();
    result += date.day.toString();
    result += date.hour.toString();
    result += date.second.toString();
    result += date.millisecond.toString();
    return result;
  }

  void setBoxName() {
    String boxNameSuffix = ''; //Provider.of<UserData>(context).uid!;
    journalBoxName = boxNameSuffix + journalBoxName;
  }

  @override
  void onInit() {
    super.onInit();
    print("todo list state initState()");
    boxNameSuffix = '';
    journalBoxName = boxNameSuffix! + journalBoxName;
    print(journalBoxName);
    journalData.value = JournalData(
      pages: List<JournalPage>.from(Hive.box(journalBoxName).values),
      selected: {},
      sortByOption: 0,
      ascendingOrder: true,
    );
    journalData.value!.pages.forEach((element) {
      print("regular task: ${element.toString()}");
    });
    /*print("goals=${gldState.tasks.length}");
    gldState.tasks.forEach((element) {
      print("goal: ${element.toString()}");
    });*/
    /*rldState = RoutineListData(
      regularTasks: List<RegularTask>.from(Hive.box(ROUTINE_BOX_NAME).values),
      ascendingOrder: true,
    );*/
    /*print("regular tasks=${rldState.regularTasks.length}");
    */
  }

  @override
  void dispose() {
    //Created: 2021-05-07 05:04:04.204453
    journalData.value!.pages.forEach((task) {
      saveToBox(task!.created, task, journalBoxName);
    });
    print('dispose journal controller');
    super.dispose();
  }

  void saveToBox(DateTime created, Object? value, String boxName) {
    String key = dateTimeToKey(created);
    Hive.box(boxName).put(
      key,
      value,
    );
  }

  void addPage(JournalPage page) {
    List<JournalPage?> newList = [page, ...journalData.value!.pages];
    journalData.value!.pages = newList;
    saveToBox(
      page.created,
      page,
      journalBoxName,
    );
    print('saved to box');
    // = journalData.value!.copy(pages: newList,);
  }

  /*void sortPages() {
    List<Task> tasks = List<Task>.from(gldState.tasks);
    tasks.sort(gldState.currentSortByFunction);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: tasks));
  }*/

  /*void addTask(Task task) {
    List<Task> newList = [task] + gldState.tasks;
    //newList.sort(gldState.currentSortByFunction);
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: newList));
  }*/

  void removePage(JournalPage? page) {
    List<JournalPage?> pages = journalData.value!.pages;
    print("journal page ${pages.remove(page) ? 'removed' : 'not found'}");
    journalData.value = journalData.value!.copy(
      pages: pages,
    );
  }

  void switchListOrder() {
    journalData.value!.ascendingOrder = !journalData.value!.ascendingOrder!;
  }

  /*@override
  Widget build(BuildContext context) => JournalCommon(
    child: widget.child,
    jnlState: jnlState,
    stateWidget: this,
  );*/
}
