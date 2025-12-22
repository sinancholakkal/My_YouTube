import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/core/colors/app_palette.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/search_screen/search_screen.dart';
import 'package:my_youtube/presentation/page/video_player_screen.dart/video_player_screen.dart';
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // fetchVideos();
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.gif_box)),
              Text("YouTube"),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<yt.Video>>(
              future: fetchVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No Data"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return VideoCardWidget(video: snapshot.data![index]);
                    },
                  );
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<yt.Video>> fetchVideos() async {
    List<yt.Video> videos = [];
    final api = await di.sl<GetApiUseCase>().call();
    try {
      if (api != null) {
        final response = await api.videos.list(
          ['snippet', 'statistics', 'contentDetails'],
          chart: 'mostPopular',
          regionCode: 'IN',
          maxResults: 20,
        );
        videos = response.items ?? [];
      }
    } catch (e) {
      log(e.toString());
    }
    log(videos[0].id.toString());
    return videos;
  }
}
