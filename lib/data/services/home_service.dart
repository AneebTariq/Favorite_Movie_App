import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/config/constents/api_constants.dart';
import 'package:movie_app/data/http_client/http_client.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MoviesServices {
  Future<MoviesModel> getMoviesList(String token) async {
    http.Response response = (await HttpClient.instance.getRequest(
        endPoint: ApiConstants.movies,
        header: ApiConstants.getRequestHeadersToken(token),));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      MoviesModel model = MoviesModel.fromJson(json);
      return model;
    } else {
      throw Exception("ApiConstants.apiExceptions(response)");
    }
  }
}
