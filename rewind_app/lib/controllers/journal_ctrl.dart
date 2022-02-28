import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/journal/journal_data.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';

class JournalController extends GetxController {
  late String? boxNameSuffix;

  late JournalData journalData;
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
    String boxNameSuffix = '';
    journalBoxName = boxNameSuffix + journalBoxName;
  }

  @override
  void onInit() {
    super.onInit();
    boxNameSuffix = '';
    journalBoxName = boxNameSuffix! + journalBoxName;
    print(journalBoxName);
    journalData = JournalData(
      pages: List<JournalPage>.from(Hive.box(journalBoxName).values),
      selected: {},
      sortByOption: 0,
      ascendingOrder: true,
    );
    journalData.pages.forEach((element) {
      print("regular task: ${element.toString()}");
    });
  }

  @override
  void dispose() {
    journalData.pages.forEach((task) {
      saveToBox(task.created, task, journalBoxName);
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

  void deleteFromBox(DateTime created) {
    String key = dateTimeToKey(created);
    Hive.box(journalBoxName).delete(
      key,
    );
  }

  void addPage(JournalPage page) {
    List<JournalPage> newList = [page, ...journalData.pages];
    journalData.pages.value = newList;
    saveToBox(
      page.created,
      page,
      journalBoxName,
    );
  }

  /// Sorts the pages with the current sort by (compareTo) method.
  void sortPages() {
    journalData.pages.sort(
      journalData.currentSortByFunction as int Function(
        JournalPage?,
        JournalPage?,
      )?,
    );
  }

  void deletePage(JournalPage? page) {
    journalData.pages.removeWhere((element) {
      return element.created == page!.created;
    });
    deleteFromBox(page!.created);
  }

  void switchListOrder() {
    journalData.ascendingOrder.value = !journalData.ascendingOrder.value;
    sortPages();
  }
}
