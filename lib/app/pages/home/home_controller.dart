import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/models.dart';
import 'package:rickymorty_app/app/views/views.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';

class HomeController extends GetxController {
  final ApiRepository _repository = Get.find<ApiRepository>();

  final RxInt _pageIndex = 0.obs;

  final RxList<Character> _characters = <Character>[].obs;
  final RxList<Episode> _episodes = <Episode>[].obs;
  final RxList<Location> _locations = <Location>[].obs;

  final RxString _queryCharacter = ''.obs;
  final RxString _queryEpisode = ''.obs;
  final RxString _queryLocation = ''.obs;

  final RxString _filterCharacter = 'name'.obs;
  final RxString _filterEpisode = 'name'.obs;
  final RxString _filterLocation = 'name'.obs;

  final RxBool _searchingCharacters = false.obs;
  final RxBool _searchingEpisodes = false.obs;
  final RxBool _searchingLocations = false.obs;

  final RxBool _isLoading = false.obs;

  int get pageIndex => _pageIndex.value;

  List<Character> get characters => _characters;
  List<Episode> get episodes => _episodes;
  List<Location> get locations => _locations;

  String get queryCharacter => _queryCharacter.value;
  String get queryEpisode => _queryEpisode.value;
  String get queryLocation => _queryLocation.value;

  String get filterCharacter => _filterCharacter.value;
  String get filterEpisode => _filterEpisode.value;
  String get filterLocation => _filterLocation.value;

  bool get searchingCharacters => _searchingCharacters.value;
  bool get searchingEpisodes => _searchingEpisodes.value;
  bool get searchingLocations => _searchingLocations.value;

  bool get isLoading => _isLoading.value;

  int currentPage = 2;

  final views = [
    const CharactersPage(),
    const EpisodesPage(),
    const LocationsPage(),
  ];

  @override
  void onInit() {
    final List<Character> characters = Get.arguments[0];
    _characters.assignAll(characters);
    final List<Episode> episodes = Get.arguments[1];
    _episodes.assignAll(episodes);
    final List<Location> locations = Get.arguments[2];
    _locations.assignAll(locations);
    super.onInit();
  }

  void changePage(int index) {
    _pageIndex.value = index;
    update();
  }

  void onQueryCharacterChanged(String query) {
    _queryCharacter.value = query;
  }

  void onQueryEpisodeChanged(String query) {
    _queryEpisode.value = query;
  }

  void onQueryLocationChanged(String query) {
    _queryLocation.value = query;
  }

  void onFilterCharacterChanged(String filterBy) {
    _filterCharacter.value = filterBy;
  }

  void onFilterEpisodeChanged(String filterBy) {
    _filterEpisode.value = filterBy;
  }

  void onFilterLocationChanged(String filterBy) {
    _filterLocation.value = filterBy;
  }

  Future<void> searchCharacters({String? filterWord, String? filterBy}) async {
    if (_isLoading.value) return;
    _searchingCharacters.value = true;
    currentPage = 2;
    try {
      List<Character> characters = await _repository.getCharacters(
          filterBy: filterBy, filterWord: filterWord ?? '', page: 1);
      _characters.value = characters;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _searchingCharacters.value = false;
    }
  }

  Future<void> searchEpisodes({String? filterWord, String? filterBy}) async {
    if (_isLoading.value) return;
    _searchingEpisodes.value = true;
    currentPage = 2;
    try {
      List<Episode> episodes = await _repository.getEpisodes(
          filterBy: filterBy, filterWord: filterWord ?? '', page: 1);
      _episodes.value = episodes;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _searchingEpisodes.value = false;
    }
  }

  Future<void> searchLocations({String? filterWord, String? filterBy}) async {
    if (_isLoading.value) return;
    _searchingLocations.value = true;
    currentPage = 2;
    try {
      List<Location> locations = await _repository.getLocations(
          filterBy: filterBy, filterWord: filterWord ?? '', page: 1);
      _locations.value = locations;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _searchingLocations.value = false;
    }
  }

  Future<void> getMoreCharacters({String? filterBy, String? filterWord}) async {
    if (_isLoading.value) return;
    _isLoading.value = true;
    try {
      List<Character> characters = await _repository.getCharacters(
          filterBy: filterBy, filterWord: filterWord ?? '', page: currentPage);
      _characters.value = [..._characters, ...characters];
      currentPage++;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getMoreEpisodes({String? filterBy, String? filterWord}) async {
    if (_isLoading.value) return;
    _isLoading.value = true;
    try {
      List<Episode> episodes = await _repository.getEpisodes(
          filterBy: filterBy, filterWord: filterWord, page: currentPage);
      _episodes.value = [..._episodes, ...episodes];
      currentPage++;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getMoreLocations({String? filterBy, String? filterWord}) async {
    if (_isLoading.value) return;
    _isLoading.value = true;
    try {
      List<Location> locations = await _repository.getLocations(
          filterBy: filterBy, filterWord: filterWord, page: currentPage);
      _locations.value = [..._locations, ...locations];
      currentPage++;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _isLoading.value = false;
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
