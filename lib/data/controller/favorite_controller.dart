// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:get/get.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    getMoviesList();
    loadFavoriteMovies();
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

  void loadFavoriteMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Iterable<String> keys =
        prefs.getKeys().where((key) => key.startsWith('favorite_'));
    for (String key in keys) {
      String? value = prefs.getString(key);
      final movieMap = jsonDecode(value!);
      SharePrefMovieModel favoriteMovie =
          SharePrefMovieModel.fromJson(movieMap);
      favoriteMovies.add(favoriteMovie);
      print(favoriteMovies);
    }
  }

  Future<bool> toggleFunction(int id, SharePrefMovieModel favoriteMovie) async {
    final bool isFavorite = favoriteMovies.contains(favoriteMovie);
    addToFavorite = !addToFavorite;
    if (!isFavorite) {
      favoriteMovies.add(favoriteMovie);
      await sharedPrefClient.saveMovieToPrefs('favorite_$id', favoriteMovie);
      print("Added to favorites: $favoriteMovie");
    } else {
      favoriteMovies.remove(favoriteMovie);
      await sharedPrefClient.removeFromFavorites(id);
      print("Removed from favorites: $favoriteMovie");
    }
    loadFavoriteMovies();
    !isFavorite;
    return addToFavorite; // Return updated favorite status
  }

  Future<MoviesModel> getData() {
    return Future.delayed(const Duration(seconds: 4), () {
      return model!;
      // throw Exception("Custom Error");
    });
  }
}
//vhsdiojodcpok