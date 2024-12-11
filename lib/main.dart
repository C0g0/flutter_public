import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/splash/splash_binding.dart';
import 'package:rickymorty_app/app/pages/splash/splash_page.dart';
import 'package:rickymorty_app/app/routes/app_pages.dart';
import 'package:rickymorty_app/app/utils/dependency_injection.dart';

void main() {
  DependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick y Morty',
        home: const SplashPage(),
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
        theme: Theme.of(context).copyWith(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey),
        ));
  }
}
