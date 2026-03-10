import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../home/my_widget.dart';
import '../info/info_page.dart';
import '../movie/movie_detail_page.dart';
import '../movie/upcoming_movie_page.dart';
import '../movie/video_page.dart';

class AppRoute {
  static const homeRoute = 'home';
  static const infoRoute = 'info';
  static const upcomingMovieRoute = 'movie';
  static const myWidgetRoute = 'widget';
  static const movieDetailRoute = 'moviedetail';
  static const videoRoute = 'video';

  final _route = <String, WidgetBuilder>{
    homeRoute: (context) => HomePage(),
    infoRoute: (context) => InfoPage(),
    upcomingMovieRoute: (context) => UpcomingMoviePage(),
    myWidgetRoute: (context) => MyWidget(),
    movieDetailRoute: (context) => MovieDetailPage(),
    videoRoute: (context) => VideoPage(),
  };

  get getAll => _route;
}
