import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/location.dart';
import 'package:rickymorty_app/app/data/repositories/api_repository.dart';

class LocationDetailsController extends GetxController {
  final ApiRepository _repository = Get.find<ApiRepository>();

  final Rx<Location> _location = Location(id: '', name: '').obs;
  final RxBool _loadingLocation = false.obs;

  Location get location => _location.value;
  bool get loadingLocation => _loadingLocation.value;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  _init() async {
    try {
      _loadingLocation.value = true;
      final String locationId = Get.arguments;
      _location.value = await _repository.getLocationById(id: locationId);
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      _loadingLocation.value = false;
    }
  }
}
