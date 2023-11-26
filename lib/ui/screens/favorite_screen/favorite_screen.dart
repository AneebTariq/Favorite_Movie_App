import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/constents/size_config.dart';
import 'package:movie_app/config/styles/app_colors.dart';
import 'package:movie_app/data/models/movie_model.dart';
import '../../../data/controller/favorite_controller.dart';
import '../../../data/share_pref/shareprefrence.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  final SharedPrefClient sharedPrefClient = SharedPrefClient();

  FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text(
          'Favorite Movies',
          style: TextStyle(color: AppColors.white, fontSize: getFont(20)),
        ),
      ),
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          return controller.favoriteMovies.isEmpty
              ? const Center(child: Text('No favorite movies yet'))
              : ListView.builder(
                  itemCount: controller.favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = controller.favoriteMovies[index];
                    return FavoriteMovieList(
                      movie: movie,
                      controller: controller,
                    );
                  },
                );
        },
      ),
    );
  }
}

class FavoriteMovieList extends StatelessWidget {
  const FavoriteMovieList({
    super.key,
    required this.movie,
    required this.controller,
  });
  final FavoriteController controller;
  final SharePrefMovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(20), vertical: getHeight(10)),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
                height: getHeight(200),
                padding: EdgeInsets.only(top: getHeight(20)),
                // width: getWidth(100),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //         'https://images.unsplash.com${controller.model!.results[index].posterPath}'),
                  //     fit: BoxFit.cover)
                ),
                child: InkWell(
                  onTap: () {
                    controller.removeat(movie.id);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      SizedBox(
                        width: getWidth(20),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: getHeight(10),
            ),
            Text(
              movie.title,
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: getFont(18)),
            ),
            Text('${movie.releaseDate.month} / ${movie.releaseDate.year}'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
              child: Text(
                movie.overview,
              ),
            )
          ],
        ),
      ),
    );
  }
}
