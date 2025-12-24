import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

part 'get_comments_event.dart';
part 'get_comments_state.dart';

class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState> {
  String nextPageToken = "";
  final List<String> servers = [
    "https://pipedapi.kavin.rocks", // Main (often busy)
    "https://api.piped.io", // Backup 1
    "https://pipedapi.drgns.space", // Backup 2
    "https://pipedapi.adminforge.de", // Backup 3
  ];
  GetCommentsBloc() : super(GetCommentsInitial()) {
    on<GetComments>((event, emit) async {
      emit(GetCommentsLoadingState());
      log("Loading state emited of comments");
      bool isSuccess = false;
      for (var baseUrl in servers) {
        try {
          //final String baseUrl = "https://pipedapi.kavin.rocks";
          final response = await http.get(
            Uri.parse(
              "$baseUrl/comments/${event.video.id}?page=$nextPageToken",
            ),
          );
          if (response.statusCode == 200) {
            final comments = JsonCodec().decode(response.body);
            nextPageToken = comments['nextpage'].toString();
            emit(
              GetCommentsLoadedState(
                comments: comments['comments'] as List<dynamic>,
                commentCount: comments['commentCount'] as int,
                disabled: comments['disabled'] as bool,
              ),
            );
            // log(comments['comments'][0].toString());
            isSuccess = true;
            break;
          }
        } catch (e) {
          log("something issue while fetch comments $e");
          //emit(GetCommentsErrorState(message: e.toString()));
        }
      }
      if (!isSuccess) {
        emit(
          GetCommentsErrorState(
            message: "Something issue while fetch comments",
          ),
        );
      }
    });
  }
}
