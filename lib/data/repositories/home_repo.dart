import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/services/home_service.dart';

class MovieRepo {
  MoviesServices service = MoviesServices();
  Future<MoviesModel> getMoviesList(String token) async {
    MoviesModel model = await service.getMoviesList(token);
    return model;
  }
}
