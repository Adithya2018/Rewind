import 'package:get/get.dart';
import '../journal_ctrl.dart';

class JournalBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalController>(() => JournalController());
  }
}
