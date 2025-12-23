import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

part 'get_channel_details_event.dart';
part 'get_channel_details_state.dart';

class GetChannelDetailsBloc
    extends Bloc<GetChannelDetailsEvent, GetChannelDetailsState> {
  GetChannelDetailsBloc() : super(GetChannelDetailsInitial()) {
    final yt.YoutubeExplode _yt = yt.YoutubeExplode();
    on<GetChannelDetailsEvent>((event, emit) async {
      emit(GetChannelDetailsLoading());
      try {
        final channel = await _yt.channels.get(event.channelId);

        emit(GetChannelDetailsLoaded(channel: channel));
      } catch (e) {
        emit(GetChannelDetailsError(message: e.toString()));
      }
    });
  }
}
