import 'package:flutter/material.dart';

import '../../model/game_model.dart';
import '../../service/network.dart';
import '../config/api.dart';
import '../config/app_route.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Future<GameModel>? _gameModel;

  @override
  void initState() {
    _gameModel = NetworkService().getALLGameDio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: FutureBuilder(
        future: _gameModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: snapshot.data?.games?.length,
              itemBuilder: (context, index) {
                var game = snapshot.data?.games?[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.movieDetailRoute,
                        arguments: game,
                      );
                    },
                    tileColor: index.isEven
                        ? Colors.green.shade100
                        : Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    title: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: game?.gameImg != ""
                                ? Image.network(
                                    API.gameApiImage + (game?.gameImg ?? ''),
                                    height: 150,
                                  )
                                : Image.asset(
                                    'assets/images/no_photo.png',
                                    height: 150,
                                  ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "${game?.gameId ?? ''} ${game?.gameName ?? ''}",
                                ),
                                game?.gameStock == '0'
                                    ? Text(
                                        '฿${game?.gamePrice?.toString() ?? ''}out of stock',
                                      )
                                    : Text(
                                        '฿${game?.gamePrice?.toString() ?? ''}  ${game?.gameStock?.toString() ?? ''}items',
                                      ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _showMyDialog(
                                          game?.id.toString() ?? '',
                                        );
                                      },
                                      icon: Icon(Icons.delete_forever),
                                    ),
                                  ],
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.gameManagementRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Would you like to delete?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  final message = await NetworkService().deleteGameDio(id);
                  print(message);
                  if (message == 'Delete Successfully') {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("ลบสำเร็จ")));
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("ลบไม่สำเร็จ")));
                  }
                  setState(() {});
                  initState();
                } catch (ex) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("ลบไม่สำเร็จ")));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
