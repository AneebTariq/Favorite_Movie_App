import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/constents/size_config.dart';
import 'package:movie_app/config/styles/app_colors.dart';
import 'package:movie_app/data/controller/favorite_controller.dart';
import '../favorite_screen/favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColors.blue,
        title: Text(
          'Movies',
          style: TextStyle(color: AppColors.white, fontSize: getFont(25)),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => FavoriteMoviesScreen(),
                  transition: Transition.leftToRight);
            },
            child: Icon(
              Icons.favorite_border_outlined,
              color: AppColors.white,
              size: getHeight(30),
            ),
          ),
          SizedBox(
            width: getWidth(20),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          Future<void>.delayed(const Duration(seconds: 3));
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.blue,
            ),
          );
          return controller.getMoviesList();
        },
        child: FutureBuilder(
          future: controller.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.blue));
            }
            return controller.model == null
                ? Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: getFont(20),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.model!.results.length,
                    itemBuilder: ((BuildContext context, index) {
                      // Build your list items using controller.model
                      return MovieItem(
                        controller: controller,
                        index: index,
                      );
                    }),
                  );
          },
        ),
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.controller,
    required this.index,
  });
  final int index;
  final FavoriteController controller;

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
                    controller.toggleFunction(
                        controller.model!.results[index].id,
                        controller.model!.results[index]);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      controller.addToFavorite == true
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border,
                              color: Colors.red),
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
              controller.model!.results[index].title,
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: getFont(18)),
            ),
            Text(
                '${controller.model!.results[index].releaseDate.month} / ${controller.model!.results[index].releaseDate.year}'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
              child: Text(
                controller.model!.results[index].overview,
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
          ],
        ),
      ),
    );
  }
}
