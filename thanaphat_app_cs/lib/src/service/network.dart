import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../model/game_model.dart';
import '../model/upcoming_movie_model.dart';
import '../model/video_model.dart';
import '../pages/config/api.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instace = NetworkService._internal();

  factory NetworkService() => _instace;
  static final Dio _dio = Dio();

  Future<UpcomingMovieModel> getUpcomingMovieDio() async {
    final response = await _dio.get(API.MOVIE_URL);
    if (response.statusCode == 200) {
      // print(response.data);
      return upcomingMovieModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<VideoModel> getVideoDio(String id) async {
    String url = API.VIDEO_URL + id + API.MOVIE_API_KEY;
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      return videoModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
}
