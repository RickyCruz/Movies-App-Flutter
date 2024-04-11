import 'package:flutter/material.dart';
import 'package:movies_app/widgets/card_swipper.dart';
import 'package:movies_app/widgets/movie_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Movies in theaters'),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              CardSwipper(),
              MovieSlider(),
            ],
          ),
        )
      );
    }
}
