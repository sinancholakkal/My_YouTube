part of 'get_channel_details_bloc.dart';

@immutable
sealed class GetChannelDetailsState {}

final class GetChannelDetailsInitial extends GetChannelDetailsState {}

class GetChannelDetailsLoading extends GetChannelDetailsState {}

class GetChannelDetailsLoaded extends GetChannelDetailsState {
  final yt.Channel channel;
  GetChannelDetailsLoaded({required this.channel});
}

class GetChannelDetailsError extends GetChannelDetailsState {
  final String message;
  GetChannelDetailsError({required this.message});
}
