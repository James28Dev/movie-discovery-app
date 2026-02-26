import 'package:flutter/material.dart';
import 'package:thanaphat_app_cs/src/model/video_model.dart';
import 'package:thanaphat_app_cs/src/service/network.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Future<VideoModel>? _vidoeModel;
  String? _id;

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    _id = args.toString();
    _vidoeModel = NetworkService().getVideoDio(_id ?? '');

    return Scaffold(
      appBar: AppBar(title: Text('Video')),
      body: FutureBuilder(
        future: _vidoeModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.results?.length,
              itemBuilder: (context, index) {
                var video = snapshot.data?.results?[index];
                YoutubePlayerController controller = YoutubePlayerController(
                  initialVideoId: video?.key ?? '',
                  flags: YoutubePlayerFlags(autoPlay: true, mute: false),
                );
                return Card(
                  child: Column(
                    children: [
                      Text(video?.name ?? ''),
                      YoutubePlayer(
                        controller: controller,
                        liveUIColor: Colors.amber,
                      ),
                    ],
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
