import 'package:flutter/material.dart';
import 'package:thanaphat_app_cs/src/pages/home/home_page.dart';
import 'package:thanaphat_app_cs/src/pages/info/info_page.dart';
import 'package:thanaphat_app_cs/src/pages/movie/movie_detail_page.dart';
import 'package:thanaphat_app_cs/src/pages/movie/upcoming_movie_page.dart';
import 'package:thanaphat_app_cs/src/pages/home/my_widget.dart';
import 'package:thanaphat_app_cs/src/pages/movie/video_page.dart';

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
