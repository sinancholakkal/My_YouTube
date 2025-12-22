import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/bloc/search/fetc_search/fetch_search_bloc.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/widgets/video_card_widget.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FetchSearchBloc, FetchSearchState>(
          builder: (context, state) {
            if (state is FetchSearchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchSearchSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return VideoCardWidget(video: state.videos[index]);
                },
                itemCount: state.videos.length,
              );
            } else if (state is FetchSearchFailure) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }
}
