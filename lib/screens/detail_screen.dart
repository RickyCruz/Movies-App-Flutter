import 'package:flutter/material.dart';
import 'package:movies_app/widgets/casting_cards.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: This must be an instance of movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              const CastingCards(),
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
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
          padding: const EdgeInsets.only(bottom: 10),
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title', 
                style: textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.originalTitle', 
                style: textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 18, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text('movie.average', style: textTheme.bodySmall)
                ],
              )
            ]
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer condimentum ante ut ante posuere pharetra. Cras odio quam, malesuada sed interdum quis, pulvinar sit amet dolor. Etiam sit amet rhoncus arcu. Duis consequat nulla ac dignissim elementum. Maecenas at nisi ipsum. Pellentesque non orci ex. Maecenas gravida, nunc nec euismod eleifend, sem sapien imperdiet est, vitae aliquet odio eros in magna. Morbi nec felis vehicula ante egestas dignissim. Phasellus a velit diam. Praesent faucibus odio ac dolor finibus ornare. In tempus lorem felis, id tempor ligula porttitor non.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
