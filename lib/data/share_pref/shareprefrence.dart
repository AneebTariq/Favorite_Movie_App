import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class SharedPrefClient {
  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveMovieToPrefs(String key, SharePrefMovieModel movie) async {
    final prefs = await _getPrefs();
    final movieMap = movie.toJson();
    await prefs.setString(key, jsonEncode(movieMap));
  }

  Future<void> removeFromFavorites(int movieId) async {
    final prefs = await _getPrefs();
    final keys = prefs.getKeys();

    for (String key in keys) {
      if (key.startsWith('favorite_')) {
        final storedMovieId = key.split('_')[1]; // Extract the ID from the key
        if (storedMovieId == movieId.toString()) {
          await prefs.remove(key);
          break; // Stop after removing the matched movie ID
        }
      }
    }
  }

  Future<SharePrefMovieModel?> getMovieFromPrefs(String key) async {
    final prefs = await _getPrefs();
    final movieString = prefs.getString(key);
    if (movieString != null) {
      final movieMap = jsonDecode(movieString);
      return SharePrefMovieModel.fromJson(movieMap);
    }
    return null;
  }

  Future<List<int>?> getFavoriteMovieIds() async {
    final prefs = await _getPrefs();
    final keys = prefs.getKeys();
    List<int> favoriteMovieIds = [];
    for (String key in keys) {
      if (key.startsWith('favorite_') && prefs.getBool(key) == true) {
        int movieId = int.tryParse(key.substring(9)) ?? 0; // Extract movie ID
        if (movieId != 0) {
          favoriteMovieIds.add(movieId);
        }
      }
    }
    return favoriteMovieIds.isNotEmpty ? favoriteMovieIds : null;
  }
}
