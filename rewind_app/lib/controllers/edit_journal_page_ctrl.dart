import 'package:get/get.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';

class EditJournalPageController extends GetxController {
  Rxn<JournalPage> journalPage = Rxn<JournalPage>();
  RxBool fav = RxBool(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}