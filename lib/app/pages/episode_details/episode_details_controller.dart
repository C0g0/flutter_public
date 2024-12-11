import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/data/models/episode.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';

class EpisodeDetailsController extends GetxController {
  final ApiRepository _repository = Get.find<ApiRepository>();

  final RxBool _loadingEpisode = false.obs;
  final RxString _episodeId = ''.obs;
  final Rx<Episode> _episode = Episode(
      id: '',
      name: '',
      episode: '',
      created: '',
      characters: <Character>[]).obs;

  bool get loadingEpisode => _loadingEpisode.value;
  String get episodeId => _episodeId.value;
  Episode get episode => _episode.value;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  _init() async {
    try {
      _loadingEpisode.value = true;
      _episodeId.value = Get.arguments;
      _episode.value = await _repository.getEpisodeById(id: _episodeId.value);
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _loadingEpisode.value = false;
    }
  }

  String selectImageSeason({required String string}) {
    final String season = string[2];
    if (season == '1') {
      return 'assets/seasons/season_1.jpeg';
    }
    if (season == '2') {
      return 'assets/seasons/season_2.jpg';
    }
    if (season == '3') {
      return 'assets/seasons/season_3.jpeg';
    }
    if (season == '4') {
      return 'assets/seasons/season_4.jpeg';
    } else {
      return 'assets/seasons/season_5.jpeg';
    }
  }
}
