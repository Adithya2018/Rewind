import 'package:get/get.dart';
import '../home_ctrl.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
