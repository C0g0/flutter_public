import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/pages/episode_details/episode_details_controller.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<EpisodeDetailsController>(builder: (control) {
      return control.loadingEpisode
          ? Scaffold(
              body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/background.jpeg"), // Ruta de la imagen en assets
                      fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                    ),
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ))
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(control.episode.episode),
              ),
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/background.jpeg"), // Ruta de la imagen en assets
                        fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: theme.primaryColor.withOpacity(0.5)),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(control.selectImageSeason(
                                    string: control.episode.episode)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                control.episode.name,
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Created:',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                control.episode.created ?? '',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Characters: ',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: control.episode.characters!.length,
                              itemBuilder: (context, index) {
                                final Character character =
                                    control.episode.characters![index];
                                return Card(
                                  color: theme.primaryColor.withOpacity(0.5),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          character.image,
                                          width: 200,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress != null) {
                                              return SizedBox(
                                                width: 200,
                                                height: 200,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: theme.appBarTheme
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
                                      Text(character.name,
                                          style: theme.textTheme.titleMedium)
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ));
    });
  }
}
