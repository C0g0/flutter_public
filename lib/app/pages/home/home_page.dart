import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (control) {
      return Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: control.pageIndex,
            children: control.views,
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: control.pageIndex,
          onTap: (index) => control.changePage(index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_search_sharp), label: 'Characters'),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_creation_outlined), label: 'Episodes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city_outlined), label: 'Locations'),
          ],
        ),
      );
    });
  }
}
