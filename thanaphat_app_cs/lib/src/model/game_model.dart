// To parse this JSON data, do
//
//     final gameModel = gameModelFromJson(jsonString);

import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
  List<Game>? games;

  GameModel({
    this.games,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    games: json["games"] == null ? [] : List<Game>.from(json["games"]!.map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "games": games == null ? [] : List<dynamic>.from(games!.map((x) => x.toJson())),
  };
}

class Game {
  String? id;
  String? gameId;
  String? gameName;
  String? gamePrice;
  String? gameDetail;
  String? gameImg;
  String? gameStock;

  Game({
    this.id,
    this.gameId,
    this.gameName,
    this.gamePrice,
    this.gameDetail,
    this.gameImg,
    this.gameStock,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    gameId: json["game_id"],
    gameName: json["game_name"],
    gamePrice: json["game_price"],
    gameDetail: json["game_detail"],
    gameImg: json["game_img"],
    gameStock: json["game_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game_id": gameId,
    "game_name": gameName,
    "game_price": gamePrice,
    "game_detail": gameDetail,
    "game_img": gameImg,
    "game_stock": gameStock,
  };
}
