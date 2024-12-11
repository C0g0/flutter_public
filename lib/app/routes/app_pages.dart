import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/character_details/character_details_binding.dart';
import 'package:rickymorty_app/app/pages/character_details/character_details_page.dart';
import 'package:rickymorty_app/app/pages/episode_details/episode_details_binding.dart';
import 'package:rickymorty_app/app/pages/episode_details/episode_details_page.dart';
import 'package:rickymorty_app/app/pages/home/home_binding.dart';
import 'package:rickymorty_app/app/pages/home/home_page.dart';
import 'package:rickymorty_app/app/pages/location_details/location_details_binding.dart';
import 'package:rickymorty_app/app/pages/location_details/location_details_page.dart';
import 'package:rickymorty_app/app/pages/splash/splash_binding.dart';
import 'package:rickymorty_app/app/pages/splash/splash_page.dart';
import 'package:rickymorty_app/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.locationDetails,
      page: () => const LocationDetailsPage(),
      binding: LocationDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.characterDetails,
      page: () => const CharacterDetailsPage(),
      binding: CharacterDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.episodeDetails,
      page: () => const EpisodeDetailsPage(),
      binding: EpisodeDetailsBinding(),
    ),
  ];
}
