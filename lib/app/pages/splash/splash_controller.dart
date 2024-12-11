import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/data/models/episode.dart';
import 'package:rickymorty_app/app/data/models/location.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';
import 'package:rickymorty_app/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final ApiRepository _repository = Get.find<ApiRepository>();

  @override
  void onReady() {
    _init();
    super.onReady();
  }

  _init() async {
    try {
      List<Character> characters = await _repository.getCharacters(
          filterBy: 'name', filterWord: '', page: 1);
      List<Episode> episodes = await _repository.getEpisodes(
          filterBy: 'name', filterWord: '', page: 1);
      List<Location> locations = await _repository.getLocations(
          filterBy: 'name', filterWord: '', page: 1);

      Get.offNamed(AppRoutes.home,
          arguments: [characters, episodes, locations]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
