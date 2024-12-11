import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/location_details/location_details_controller.dart';

class LocationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationDetailsController());
  }
}
