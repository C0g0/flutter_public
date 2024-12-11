import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/episode.dart';
import 'package:rickymorty_app/app/pages/home/home_controller.dart';
import 'package:rickymorty_app/app/routes/app_routes.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final theme = Theme.of(context);
    return GetBuilder<HomeController>(builder: (control) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !control.isLoading) {
          control.getMoreEpisodes(
            filterBy: control.filterEpisode,
            filterWord: control.queryEpisode,
          );
        }
      });
      return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Episodes')),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background.jpeg', // Ruta de la imagen
                  fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                ),
              ),
              Column(
                children: [
                  Container(
                    color: Theme.of(context).appBarTheme.backgroundColor,
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
                                  value: control.filterEpisode,
                                  items: [
                                    DropdownMenuItem(
                                        value: 'name',
                                        child: Text(
                                          'name',
                                          style: TextStyle(
                                              color: theme.primaryColor),
                                        )),
                                    DropdownMenuItem(
                                        value: 'episode',
                                        child: Text(
                                          'episode',
                                          style: TextStyle(
                                              color: theme.primaryColor),
                                        )),
                                  ],
                                  onChanged: (value) {
                                    control.onFilterEpisodeChanged(value!);
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
                                control.onQueryEpisodeChanged(e);
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  'Search',
                                  style: TextStyle(color: theme.primaryColor),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: theme.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: theme.primaryColor)),
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                color: theme.primaryColor,
                                onPressed: () {
                                  control.searchEpisodes(
                                      filterBy: control.filterEpisode,
                                      filterWord: control.queryEpisode);
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
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: control.episodes.length,
                          itemBuilder: (context, index) {
                            final Episode episode = control.episodes[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.episodeDetails,
                                    arguments: episode.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          theme.primaryColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          control.selectImageSeason(
                                              string: episode.episode),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    title: Text(episode.name),
                                    subtitle: Text(episode.episode),
                                  ),
                                ),
                              ),
                            );
                          })),
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
          ));
    });
  }
}
