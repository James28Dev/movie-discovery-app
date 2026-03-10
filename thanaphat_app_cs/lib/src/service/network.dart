// ignore_for_file: unnecessary_null_comparison

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
    final response = await _dio.get(API.movieUrl);
    if (response.statusCode == 200) {
      // print(response.data);
      return upcomingMovieModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<VideoModel> getVideoDio(String id) async {
    String url = API.videoUrl + id + API.movieApiUrl;
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      return videoModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<GameModel> getALLGameDio() async {
    final response = await _dio.get(API.gameApi);
    if (response.statusCode == 200) {
      // print(response.data);
      return gameModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<String> deleteGameDio(String id) async {
    print('${API.gameApi}/$id');
    final response = await _dio.delete('${API.gameApi}/$id');

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  } //end

  Future<String> addGameDio(File imageFile, Game game) async {
    FormData data = FormData.fromMap({
      'game_id': game.gameId,
      'game_name': game.gameName,
      'game_price': int.parse(game.gamePrice.toString()),
      'game_detail': game.gameDetail,
      'game_stock': int.parse(game.gameStock.toString()),
      if (imageFile != null)
        'game_img': 'has_image'
      else
        'game_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.gameApi + API.gameApi, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (dioError) {
      print('Exception --> response is nulllllll');
      print(dioError.toString());
    }
    throw Exception('Network failed');
  }

  Future<String> addGameDioNoImage(Game game) async {
    FormData data = FormData.fromMap({
      'game_id': game.gameId,
      'game_name': game.gameName,
      'game_price': int.parse(game.gamePrice.toString()),
      'game_detail': game.gameDetail,
      'game_stock': int.parse(game.gameStock.toString()),
      'game_img': 'no_image',
    });
    try {
      final response = await _dio.post(API.gameApi + API.gameApi, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (dioError) {
      print('Exception --> response is nulllllll');
      print(dioError.toString());
    }
    throw Exception('Network failed');
  }

  Future<String> editGameDio(File imageFile, Game game) async {
    FormData data = FormData.fromMap({
      'game_name': game.gameName,
      'game_price': game.gamePrice,
      'game_detail': game.gameDetail,
      'game_img': game.gameImg,
      'game_stock': game.gameStock,
      if (imageFile != null)
        'game_img': game.gameImg
      else
        'game_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response = await _dio.post(
      '${API.gameApi}${API.gameApi}/${game.id}',
      data: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }

  Future<String> editGameDioNoImage(Game game) async {
    FormData data = FormData.fromMap({
      'game_name': game.gameName,
      'game_price': game.gamePrice,
      'game_detail': game.gameDetail,
      'game_img': 'no_image',
      'game_stock': game.gameStock,
    });

    final response = await _dio.post(
      '${API.gameApi}${API.gameApi}/${game.id}',
      data: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
}
