import 'package:dio/dio.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/data/models/episode.dart';
import 'package:rickymorty_app/app/data/models/location.dart';

class ApiProvider {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/graphql'));

  Future<List<Character>> getCharacters(
      {String? filterBy = 'name',
      String? filterWord = '',
      int? page = 1}) async {
    final String query = '''
        query {
          characters(page: $page, filter: {$filterBy: "$filterWord"}) {
            results {
             id
             name
             status
             species
             image
           }
          }
        }
    ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseResults = response.data['data']['characters']['results'];
    List<Character> characters = (responseResults as List)
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();

    return characters;
  }

  Future<Character> getCharacterById({required String id}) async {
    final String query = '''
                          query {
	                          character(id:$id){
                              id
                              name
                              status
                              species
                              type
                              gender
                              origin{
                                id
                                name
                              }
                              location{
                                id
                                name
                              }
                              image
                              created
                            }
                          }
    ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseCharacter = response.data['data']['character'];
    Character character = Character.fromJson(responseCharacter);
    return character;
  }

  Future<List<Episode>> getEpisodes({
    String? filterBy = 'name',
    String? filterWord = '',
    int? page = 1,
  }) async {
    final String query = '''
                              query {
                              	episodes(page: $page, filter:{$filterBy: "$filterWord"}){
                                  results{
                                    id
                                    name
                                    episode
                                  }
                                }
                              }

                            ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseResults = response.data['data']['episodes']['results'];
    List<Episode> episodes = (responseResults as List)
        .map((e) => Episode.fromJson(e as Map<String, dynamic>))
        .toList();

    return episodes;
  }

  Future<Episode> getEpisodeById({required String id}) async {
    final String query = '''
      query {
	      episode(id: $id){
          id
          name
          episode
          characters{
            id
            name
            image
          }
          created
        }
      }
    ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseEpisode = response.data['data']['episode'];
    Episode episode = Episode.fromJson(responseEpisode);
    return episode;
  }

  Future<List<Location>> getLocations({
    String? filterBy = 'name',
    String? filterWord = '',
    int? page = 1,
  }) async {
    final String query = '''
                              query {
                              	locations(page:$page,filter:{$filterBy:"$filterWord"}){
                                  results{
                                    id
                                    name
                                    type
                                    dimension
                                  }
                                }
                              }

                            ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseResults = response.data['data']['locations']['results'];
    List<Location> locations = (responseResults as List)
        .map((e) => Location.fromJson(e as Map<String, dynamic>))
        .toList();

    return locations;
  }

  Future<Location> getLocationById({required String id}) async {
    final String query = '''
                          query {
	                          location(id:$id){
                              id
                              name
                              type
                              dimension
                              created
                              residents{
                                id
                                name
                                image
                              }
                            }
                          }
    ''';
    final Response response = await _dio.post('', data: {
      'query': query, // La consulta GraphQL
    });
    final responseLocation = response.data['data']['location'];
    Location location = Location.fromJson(responseLocation);
    return location;
  }
}
