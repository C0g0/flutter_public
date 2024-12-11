import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/character_details/character_details_controller.dart';

class CharacterDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CharacterDetailsController());
  }
}
