import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/episode_details/episode_details_controller.dart';

class EpisodeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EpisodeDetailsController());
  }
}
