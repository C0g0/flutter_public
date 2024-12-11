import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';

class CharacterDetailsController extends GetxController {
  final ApiRepository _repository = Get.find<ApiRepository>();

  final Rx<Character> _character = Character(id: '', image: '', name: '').obs;
  final RxBool _loadingCharacter = false.obs;

  Character get character => _character.value;
  bool get loadingCharacter => _loadingCharacter.value;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  _init() async {
    try {
      _loadingCharacter.value = true;
      final characterId = Get.arguments;
      _character.value = await _repository.getCharacterById(id: characterId);
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _loadingCharacter.value = false;
    }
  }
}
