import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<yt.Video>>(
          future: fetchVideos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isEmpty) {
                return Center(child: Text("No search result"));
              }
              final videos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return VideoCardWidget(video: videos[index]);
                },
                itemCount: videos!.length,
              );
            }
            return Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }

  Future<List<yt.Video>> fetchVideos() async {
    log("Fetch search result");
    List<yt.Video> videos = [];
    List<String> videoIds = [];
    final api = await di.sl<GetApiUseCase>().call();
    try {
      final searchResponse = await api!.search.list(
        ['id'], // We only strictly need the ID here
        q: query, // The user's search text
        maxResults: 20,
        type: ['video'], // Ensure we don't get channels/playlists
      );
      if (searchResponse.items == null || searchResponse.items!.isEmpty) {
        return [];
      }

      String videoIds = searchResponse.items!
          .map((item) => item.id?.videoId)
          .where((id) => id != null)
          .join(',');

      final videoDetailsResponse = await api.videos.list(
        ['snippet', 'statistics', 'contentDetails'],
        id: [videoIds],
      );

      return videoDetailsResponse.items ?? [];
    } catch (e) {
      log(e.toString());
    }
    log(videos[0].id.toString());
    return videos;
  }
}
