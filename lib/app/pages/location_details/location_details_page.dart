import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/data/models/character.dart';
import 'package:rickymorty_app/app/pages/location_details/location_details_controller.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<LocationDetailsController>(builder: (control) {
      return control.loadingLocation
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
                title: Text(control.location.name),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.primaryColor.withOpacity(0.5)),
                        child: Column(
                          children: [
                            Text(
                              'Dimension:',
                              style: theme.textTheme.titleLarge,
                            ),
                            Text(
                              control.location.dimension!,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Created:',
                              style: theme.textTheme.titleLarge,
                            ),
                            Text(
                              control.location.created!,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Type:',
                              style: theme.textTheme.titleLarge,
                            ),
                            Text(
                              control.location.type!,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Residents:',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: control.location.residents!.length,
                            itemBuilder: (context, index) {
                              final Character character =
                                  control.location.residents![index];
                              return Card(
                                color: theme.primaryColor.withOpacity(0.5),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        character.image,
                                        width: 200,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
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
                                    Text(
                                      character.name,
                                      style: theme.textTheme.titleSmall,
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ));
    });
  }
}
