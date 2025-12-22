import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/bloc/search/fetc_search/fetch_search_bloc.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  List<yt.Video> videos = [];
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9 &&
          !isLoading) {
        log("Next page loading");
        context.read<FetchSearchBloc>().add(SearchNextPageEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<FetchSearchBloc, FetchSearchState>(
          listener: (context, state) {
            if (state is FetchSearchNextPageLoading) {
              isLoading = true;
            } else if (state is FetchSearchSuccess) {
              isLoading = false;
              videos.clear();
              videos.addAll(state.videos);
            }
          },
          builder: (context, state) {
            if (state is FetchSearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index == videos.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return VideoCardWidget(video: videos[index]);
              },
              itemCount: isLoading ? videos.length + 1 : videos.length,
            );
          },
        ),
      ),
    );
  }
}
