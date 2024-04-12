import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  MoviesProvider() {
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(
      _baseUrl, 
      '3/movie/now_playing', 
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'
      }
    );

    final response = await http.get(url);

    return NowPlayingResponse.fromRawJson(response.body);
  }
}
