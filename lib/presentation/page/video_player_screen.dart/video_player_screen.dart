import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_youtube/presentation/bloc/fetch_related_video/fetch_related_video_bloc.dart';
import 'package:my_youtube/presentation/bloc/get_channel_details/get_channel_details_bloc.dart';
import 'package:my_youtube/presentation/bloc/get_comments/get_comments_bloc.dart';
import 'package:my_youtube/presentation/bloc/video_details/video_details_bloc.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:my_youtube/presentation/core/colors/app_palette.dart';
import 'package:my_youtube/presentation/page/video_player_screen.dart/widgets/video_widget.dart';
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

class VideoScreen extends StatefulWidget {
  final yt.Video video;
  const VideoScreen({super.key, required this.video});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // String? viewCount;
  // String? timeAgoAt;
  // String? likeCount;
  // String? commentCount;
  // String channel = "";
  @override
  void initState() {
    context.read<VideoDetailsBloc>().add(
      FetchVideoDetailsevent(videoId: widget.video.id.toString()),
    );
    context.read<GetChannelDetailsBloc>().add(
      GetChannelDetailsEvent(channelId: widget.video.channelId.toString()),
    );
    context.read<FetchRelatedVideoBloc>().add(
      FetchRelatedVideo(videoId: widget.video.id.toString()),
    );
    log("====================================================get comments");
    context.read<GetCommentsBloc>().add(GetComments(video: widget.video));
    // viewCount = youtubeViewCount(widget.video.engagement.viewCount.toString());
    // timeAgoAt = timeAgo(widget.video.uploadDate);
    // likeCount = youtubeViewCount(widget.video.engagement.likeCount.toString());
    // commentCount = youtubeViewCount(widget.video.engagement.commentCount.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log("video suggetions ${widget.video.suggestions.toString()}");
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: .start,
        children: [
          VideoWidget(
            videoId: widget.video.id.toString(),
            height: screenHeight * 0.32,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
                builder: (context, state) {
                  if (state is VideoLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is VideoErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is VideoLoadedState) {
                    return Column(
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
                          "@${state.video.author} ${state.view}Views ${state.date}",
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
                            BlocSelector<
                              GetChannelDetailsBloc,
                              GetChannelDetailsState,
                              yt.Channel?
                            >(
                              selector: (state) {
                                return state is GetChannelDetailsLoaded
                                    ? state.channel
                                    : null;
                              },
                              builder: (context, state) {
                                return CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    state != null ? state.logoUrl : "s",
                                  ),
                                );
                              },
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
                            Text(state.like),
                            Icon(Icons.thumb_down, color: AppPalette.grey),
                          ],
                        ),
                        SizedBox(height: 14),
                        //Comments session----------------
                        InkWell(
                          onTap: () => showBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: screenHeight - screenHeight * .32,
                                color: Colors.red,
                              );
                            },
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: .symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: .circular(12),
                              color: AppPalette.black2,
                            ),

                            child: BlocBuilder<GetCommentsBloc, GetCommentsState>(
                              builder: (context, state) {
                                if (state is GetCommentsLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetCommentsErrorState) {
                                  return Center(child: Text(state.message));
                                } else if (state is GetCommentsLoadedState) {
                                  final String thumbnailUrl = fixThumbnailUrl(
                                    state.comments[0]['thumbnail'] ?? "",
                                  );
                                  log(thumbnailUrl);
                                  return Column(
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
                                            state.commentCount.toString(),
                                            style: TextStyle(
                                              color: AppPalette.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                thumbnailUrl,
                                                headers: const {
                                                  "User-Agent":
                                                      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
                                                },
                                              ),
                                        ),
                                        title: Text(
                                          maxLines: 2,
                                          state.comments[0]['commentText']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ),
                        BlocBuilder<
                          FetchRelatedVideoBloc,
                          FetchRelatedVideoState
                        >(
                          builder: (context, state) {
                            if (state is FetchRelatedVideoLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is FetchRelatedVideoError) {
                              return Center(child: Text(state.message));
                            } else if (state is FetchRelatedVideoLoaded) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final video = state.videos[index];
                                  return VideoCardWidget(video: video);
                                },
                                itemCount: 10,
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String fixThumbnailUrl(String proxyUrl) {
    try {
      // 1. If it's empty or null, return empty
      if (proxyUrl.isEmpty) return "";

      // 2. Parse the URL
      Uri uri = Uri.parse(proxyUrl);

      // 3. Check if it has the "host" parameter (which Piped adds)
      if (uri.queryParameters.containsKey('host')) {
        String originalHost =
            uri.queryParameters['host']!; // e.g., yt3.ggpht.com
        String path = uri.path; // e.g., /ytc/AIdro_m6k...

        // 4. Reconstruct the direct Google URL
        return "https://$originalHost$path";
      }

      // If it's already a normal URL, just return it
      return proxyUrl;
    } catch (e) {
      return proxyUrl;
    }
  }
}
