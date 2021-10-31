import 'package:get/get.dart';
import '../todo_list_ctrl.dart';

class TodoListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoListController>(() => TodoListController());
  }
}
