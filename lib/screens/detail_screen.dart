import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/casting_cards.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(movie: movie),
              CastingCards(movieId: movie.id),
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
   final Movie movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: FadeIn(
            delay: Durations.medium2,
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                width: 100,
              ),
            ),
          ),

          const SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  delay: Durations.medium2,
                  child: Text(
                    movie.title,
                    style: textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                FadeIn(
                  delay: Durations.long2,
                  child: Text(
                    movie.originalTitle,
                    style: textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                FadeIn(
                  delay: Durations.extralong1,
                  child: Row(
                    children: [
                      const Icon(Icons.star_outline, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${movie.voteAverage}', style: textTheme.bodySmall)
                    ],
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FadeIn(
        delay: Durations.extralong2,
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
