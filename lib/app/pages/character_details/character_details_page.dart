import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/character_details/character_details_controller.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<CharacterDetailsController>(builder: (control) {
      return control.loadingCharacter
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
                title: Text(control.character.name),
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme.primaryColor.withOpacity(0.5),
                      ),
                      height: 600,
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(control.character.image)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gender: ${control.character.gender}",
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Specie: ${control.character.species}',
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Status: ${control.character.status}',
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Last location known:',
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            control.character.location!.name,
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'First seen in:',
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            control.character.origin!.name,
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
    });
  }
}
