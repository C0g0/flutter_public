import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
