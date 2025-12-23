import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
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
  String? viewCount;
  String? timeAgoAt;
  String? likeCount;
  String? commentCount;
  @override
  void initState() {
    viewCount = youtubeViewCount(widget.video.engagement.viewCount.toString());
    timeAgoAt = timeAgo(widget.video.uploadDate);
    likeCount = youtubeViewCount(widget.video.engagement.likeCount.toString());
    // commentCount = youtubeViewCount(widget.video.engagement.commentCount.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log("video suggetions ${widget.video.suggestions.toString()}");
    return Scaffold(
      body: Column(
        crossAxisAlignment: .start,
        children: [
          VideoWidget(videoId: widget.video.id.toString()),

          FutureBuilder<List<yt.Video>>(
            future: fetchRelatedVideos(widget.video.id.toString()),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          widget.video.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "@${"channel name"} ${viewCount ?? "Unknown"}Views ${timeAgoAt ?? "Unknown"}",
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppPalette.grey,
                          ),
                        ),
                        SizedBox(height: 14),
                        //Subscribe session----------------
                        Row(
                          spacing: 12,
                          children: [
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                widget.video.thumbnails.highResUrl,
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
                                  color: AppPalette.black.withValues(
                                    alpha: 0.6,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.thumb_up, color: AppPalette.grey),
                            Text(likeCount ?? "0"),
                            Icon(Icons.thumb_down, color: AppPalette.grey),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    commentCount ?? "0",
                                    style: TextStyle(color: AppPalette.grey),
                                  ),
                                ],
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    widget.video.thumbnails.highResUrl,
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
                            final video = snapshot.data![index];
                            return VideoCardWidget(video: video);
                          },
                          itemCount: 10,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<yt.Video>> fetchRelatedVideos(String videoId) async {
    final yt.YoutubeExplode _yt = yt.YoutubeExplode();
    var relatedVideos = await _yt.videos.getRelatedVideos(widget.video);
    return relatedVideos!.toList();
  }

  String youtubeViewCount(String? viewCount) {
    if (viewCount == null) return "No views";

    final count = int.tryParse(viewCount);
    if (count == null) return "No views";

    if (count < 1000) {
      return count.toString();
    }

    if (count < 10_000) {
      // 1.2K, 9.8K
      return "${(count / 1000).toStringAsFixed(1)}K".replaceAll(".0", "");
    }

    if (count < 1_000_000) {
      // 26K, 999K
      return "${(count ~/ 1000)}K";
    }

    if (count < 10_000_000) {
      // 1.2M, 9.9M
      return "${(count / 1_000_000).toStringAsFixed(1)}M".replaceAll(".0", "");
    }

    if (count < 1_000_000_000) {
      // 12M, 999M
      return "${(count ~/ 1_000_000)}M";
    }

    return "${(count / 1_000_000_000).toStringAsFixed(1)}B".replaceAll(
      ".0",
      "",
    );
  }

  String timeAgo(DateTime? publishedAt) {
    if (publishedAt == null) return "Unknown";

    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else {
      return "${(difference.inDays / 365).floor()} years ago";
    }
  }
}
