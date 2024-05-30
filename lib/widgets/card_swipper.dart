import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwipper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: size.width * 0.6,
        height: size.height * 0.4,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      child: CarouselSlider.builder(
          itemCount: movies.length,
          itemBuilder: (_, index, __) => MoviePosterImage(movie: movies[index]),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            viewportFraction: 0.45,
          )
      ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'swipper-${movie.id}';

    return Hero(
      tag: movie.heroId!,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
