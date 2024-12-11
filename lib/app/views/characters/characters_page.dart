import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/pages/home/home_controller.dart';
import 'package:rickymorty_app/app/routes/app_routes.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ScrollController scrollController = ScrollController();
    return GetBuilder<HomeController>(builder: (control) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !control.isLoading) {
          control.getMoreCharacters(
            filterBy: control.filterCharacter,
            filterWord: control.queryCharacter,
          );
        }
      });
      return Scaffold(
          appBar: AppBar(
            title: const Text('Characters'),
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
                    color: Theme.of(context).appBarTheme.backgroundColor, //tema
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
                                  value: control.filterCharacter,
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
                                        value: 'species',
                                        child: Text(
                                          'species',
                                          style: TextStyle(
                                              color: theme.primaryColor),
                                        )),
                                  ],
                                  onChanged: (value) {
                                    control.onFilterCharacterChanged(value!);
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
                                control.onQueryCharacterChanged(e);
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  'Search',
                                  style: TextStyle(color: theme.primaryColor),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: theme.primaryColor),
                                ),
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
                                  control.searchCharacters(
                                      filterBy: control.filterCharacter,
                                      filterWord: control.queryCharacter);
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
                    child: Obx(() {
                      return control.searchingCharacters
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                              ),
                              controller: scrollController,
                              itemCount: control.characters.length,
                              itemBuilder: (context, index) {
                                final Character character =
                                    control.characters[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () => Get.toNamed(
                                          AppRoutes.characterDetails,
                                          arguments: character.id),
                                      child: Card(
                                        color:
                                            theme.primaryColor.withOpacity(0.5),
                                        child: IntrinsicHeight(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  character.image,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress !=
                                                        null) {
                                                      return SizedBox(
                                                        width: 300,
                                                        height: 300,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: theme
                                                                .appBarTheme
                                                                .backgroundColor,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return child;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                character.name,
                                                style:
                                                    theme.textTheme.titleLarge,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${character.status} - ${character.species}',
                                                style:
                                                    theme.textTheme.titleSmall,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    }),
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
                  })
                ],
              ),
            ],
          ));
    });
  }
}
