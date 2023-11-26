// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/home_repo.dart';
import '../models/sharepref_movie_model.dart';
import '../share_pref/shareprefrence.dart';

class FavoriteController extends GetxController {
  final SharedPrefClient sharedPrefClient = SharedPrefClient();
  MovieRepo movieRepo = MovieRepo();
  MoviesModel? model;
  bool addToFavorite = false;
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MTI2ODQwNTUyYmIwODUzNmFkMTliM2FiOTFlYWQ5ZCIsInN1YiI6IjY1NjBhNzc4NzA2ZTU2MDExYjQ5NDFhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6UoKmnifHVMX77wjEs9Mp5CrSDRKMsOFBetPkgF6Zm0';

  final RxList<SharePrefMovieModel> favoriteMovies =
      <SharePrefMovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteMovies();
    getMoviesList();
  }

  // Fetch movies list and handle null safety with Rx
  Future<MoviesModel?> getMoviesList() async {
    try {
      model = await movieRepo.getMoviesList(token);

      return model;
    } catch (e) {
      // Handle exceptions here, perhaps show an error message or log the error
      print('Error at controller: $e');
    }
    return model;
  }

  Future<void> loadFavoriteMovies() async {
    try {
      final favoriteMovieIds = await sharedPrefClient.getFavoriteMovieIds();
      if (favoriteMovieIds != null) {
        List<SharePrefMovieModel?> fetchedMovies = await Future.wait(
          favoriteMovieIds.map((id) async {
            return await sharedPrefClient.getMovieFromPrefs('favorite_$id');
          }),
        );

        fetchedMovies.removeWhere((movie) => movie == null);
        favoriteMovies.assignAll(fetchedMovies
            .cast<SharePrefMovieModel>()
            .whereType<SharePrefMovieModel>());
      }
    } catch (e) {
      print('Error loading favorite movies: $e');
      // Handle error, show error message, log, etc.
    }
  }

  Future<void> toggleFunction(int id, SharePrefMovieModel movieItem) async {
    addToFavorite = !addToFavorite;

    if (addToFavorite) {
      await sharedPrefClient.saveMovieToPrefs('favorite_$id', movieItem);
    } else {
      await sharedPrefClient.removeFromFavorites(id);
    }
    loadFavoriteMovies(); // Refresh favorite movies after adding/removing
  }

  Future<MoviesModel> getData() {
    return Future.delayed(const Duration(seconds: 3), () {
      return model!;
      // throw Exception("Custom Error");
    });
  }
}
