import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/credits_response.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/now_playing_response.dart';
import 'package:movies_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(
      _baseUrl, 
      endpoint,
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
      }
    );
    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {
    final nowPlaying = NowPlayingResponse.fromRawJson(
      await _getJsonData('3/movie/now_playing')
    );
    onDisplayMovies = nowPlaying.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final popular = PopularResponse.fromRawJson(
      await _getJsonData('3/movie/popular', _popularPage)
    );
    popularMovies = [...popularMovies, ...popular.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    final credits = CreditsResponse.fromRawJson(
      await _getJsonData('3/movie/$movieId/credits')
    );

    moviesCast[movieId] = credits.cast;

    return credits.cast;
  }
}
