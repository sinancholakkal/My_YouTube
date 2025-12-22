import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/presentation/page/video_player_screen.dart/video_player_screen.dart';

class VideoCardWidget extends StatelessWidget {
  final yt.Video video;
  const VideoCardWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoScreen(video: video)),
          );
        },
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(video.snippet!.thumbnails!.high!.url!),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  video.snippet!.thumbnails!.high!.url!,
                ),
              ),
              title: Text(
                video.snippet!.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: Text(video.snippet!.channelTitle!, maxLines: 1),
                  ),
                  Expanded(
                    child: Text(
                      video.statistics!.viewCount!.toString(),
                      maxLines: 1,
                    ),
                  ),
                  // Text(
                  //   snapshot.data![index].snippet!.publishedAt!
                  //       .toString(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
