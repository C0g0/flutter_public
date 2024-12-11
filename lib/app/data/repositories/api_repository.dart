import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/data/models/episode.dart';
import 'package:rickymorty_app/app/data/models/location.dart';
import 'package:rickymorty_app/app/data/providers/api_provider.dart';

class ApiRepository {
  final ApiProvider _api = Get.find<ApiProvider>();

  Future<List<Character>> getCharacters(
          {String? filterBy, String? filterWord, int? page}) =>
      _api.getCharacters(
          filterBy: filterBy, filterWord: filterWord, page: page);

  Future<List<Episode>> getEpisodes(
          {String? filterBy, String? filterWord, int? page}) =>
      _api.getEpisodes(filterBy: filterBy, filterWord: filterWord, page: page);

  Future<List<Location>> getLocations(
          {String? filterBy, String? filterWord, int? page}) =>
      _api.getLocations(filterBy: filterBy, filterWord: filterWord, page: page);

  Future<Character> getCharacterById({required String id}) =>
      _api.getCharacterById(id: id);

  Future<Episode> getEpisodeById({required String id}) =>
      _api.getEpisodeById(id: id);

  Future<Location> getLocationById({required String id}) =>
      _api.getLocationById(id: id);
}
