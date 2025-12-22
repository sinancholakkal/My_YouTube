import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/presentation/core/colors/app_palette.dart';
import 'package:my_youtube/presentation/page/video_player_screen.dart/widgets/video_widget.dart';
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

/// A simple screen showing a YouTube video player with a play/pause button.
class VideoScreen extends StatefulWidget {
  final yt.Video video;
  const VideoScreen({super.key, required this.video});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: .start,
        children: [
          VideoWidget(videoId: widget.video.id!),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Text(
                    "Jananayagan vijay movie trailer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "@apimalayalam 2M view 2years ago",
                    style: TextStyle(fontSize: 12.5, color: AppPalette.grey),
                  ),
                  SizedBox(height: 14),
                  //Subscribe session----------------
                  Row(
                    spacing: 12,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          widget.video.snippet!.thumbnails!.high!.url!,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.white,
                        ),
                        child: Text(
                          "Subscribe",
                          style: TextStyle(
                            color: AppPalette.black.withValues(alpha: 0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.thumb_up, color: AppPalette.grey),
                      Text("1M"),
                      Icon(Icons.thumb_down, color: AppPalette.grey),
                      Text("100"),
                    ],
                  ),
                  SizedBox(height: 14),
                  //Comments session----------------
                  Container(
                    width: double.infinity,
                    padding: .symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: .circular(12),
                      color: AppPalette.black2,
                    ),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Text(
                              "Comments",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "231",
                              style: TextStyle(color: AppPalette.grey),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              widget.video.snippet!.thumbnails!.high!.url!,
                            ),
                          ),
                          title: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            "Ith vijayiyude last padam aayirikkum. orupad sankadam und. Ith kathhum. Njan first show kanum",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return VideoCardWidget(video: widget.video);
                    },
                    itemCount: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
