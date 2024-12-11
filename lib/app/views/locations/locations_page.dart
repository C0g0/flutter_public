import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/location.dart';
import 'package:rickymorty_app/app/pages/home/home_controller.dart';
import 'package:rickymorty_app/app/routes/app_routes.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final theme = Theme.of(context);
    return GetBuilder<HomeController>(
      builder: (control) {
        scrollController.addListener(() {
          if (scrollController.position.pixels >=
                  scrollController.position.maxScrollExtent &&
              !control.isLoading) {
            control.getMoreLocations(
              filterBy: control.filterLocation,
              filterWord: control.queryLocation,
            );
          }
        });
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Locations'),
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/background.jpeg"), // Ruta de la imagen en assets
                        fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        color: theme.appBarTheme.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Text(
                                  'Filter by: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Obx(() {
                                  return DropdownButton(
                                      dropdownColor:
                                          theme.appBarTheme.backgroundColor,
                                      value: control.filterLocation,
                                      items: [
                                        DropdownMenuItem(
                                            value: 'name',
                                            child: Text(
                                              'name',
                                              style: TextStyle(
                                                  color: theme.primaryColor),
                                            )),
                                        DropdownMenuItem(
                                            value: 'type',
                                            child: Text(
                                              'type',
                                              style: TextStyle(
                                                  color: theme.primaryColor),
                                            )),
                                        DropdownMenuItem(
                                            value: 'dimension',
                                            child: Text(
                                              'dimension',
                                              style: TextStyle(
                                                  color: theme.primaryColor),
                                            )),
                                      ],
                                      onChanged: (value) {
                                        control.onFilterLocationChanged(value!);
                                      });
                                }),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  style: TextStyle(color: theme.primaryColor),
                                  cursorColor: theme.primaryColor,
                                  onChanged: (e) {
                                    control.onQueryLocationChanged(e);
                                  },
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Search',
                                      style:
                                          TextStyle(color: theme.primaryColor),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: theme.primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: theme.primaryColor)),
                                  ),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    color: theme.primaryColor,
                                    onPressed: () {
                                      control.searchLocations(
                                          filterBy: control.filterLocation,
                                          filterWord: control.queryLocation);
                                      scrollController.animateTo(
                                        0.0, // Posición inicial
                                        duration: const Duration(
                                            milliseconds:
                                                500), // Duración de la animación
                                        curve: Curves.easeInOut,
                                      );
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: const Icon(Icons.search))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        return control.searchingLocations
                            ? const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 4 / 3,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    controller: scrollController,
                                    itemCount: control.locations.length,
                                    itemBuilder: (context, index) {
                                      final Location location =
                                          control.locations[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.locationDetails,
                                              arguments: location.id);
                                        },
                                        child: Card(
                                            color: theme.primaryColor
                                                .withOpacity(0.5),
                                            child: Column(
                                              children: [
                                                const Expanded(
                                                    child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Icon(
                                                    Icons.location_on_outlined,
                                                  ),
                                                )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Text(
                                                    location.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: theme
                                                        .textTheme.titleMedium,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    }));
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() {
                        return control.isLoading
                            ? Container(
                                color: theme.appBarTheme.backgroundColor,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                )))
                            : const SizedBox.shrink();
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
