import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickymorty_app/app/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (control) {
      return Scaffold(
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
      ));
    });
  }
}
