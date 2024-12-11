import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/providers/api_provider.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut(
        () => Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/graphql')));
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => ApiRepository());
  }
}
