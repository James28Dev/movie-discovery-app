import 'package:flutter/material.dart';

import '../../model/upcoming_movie_model.dart';
import '../../service/network.dart';
import '../config/app_route.dart';

class UpcomingMoviePage extends StatefulWidget {
  const UpcomingMoviePage({super.key});

  @override
  State<UpcomingMoviePage> createState() => _UpcomingMoviePageState();
}

class _UpcomingMoviePageState extends State<UpcomingMoviePage> {
  Future<UpcomingMovieModel>? _upcomingMovieModel;

  @override
  void initState() {
    _upcomingMovieModel = NetworkService().getUpcomingMovieDio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: FutureBuilder(
        future: _upcomingMovieModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.results?.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data?.results?[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.movieDetailRoute,
                        arguments: movie,
                      );
                    },
                    trailing: Icon(Icons.more),
                    tileColor: index.isEven
                        ? Colors.green.shade100
                        : Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    title: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500' +
                                  (movie?.posterPath ?? ''),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(movie?.title ?? ''),
                                Text(movie?.releaseDate?.year.toString() ?? ''),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
