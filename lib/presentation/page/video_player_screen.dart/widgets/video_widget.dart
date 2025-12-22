import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omni_video_player/omni_video_player/controllers/omni_playback_controller.dart';
import 'package:omni_video_player/omni_video_player/models/custom_player_widgets.dart';
import 'package:omni_video_player/omni_video_player/models/omni_video_quality.dart';
import 'package:omni_video_player/omni_video_player/models/player_ui_visibility_options.dart';
import 'package:omni_video_player/omni_video_player/models/video_player_callbacks.dart';
import 'package:omni_video_player/omni_video_player/models/video_player_configuration.dart';
import 'package:omni_video_player/omni_video_player/models/video_source_configuration.dart';
import 'package:omni_video_player/omni_video_player/theme/omni_video_player_theme.dart';
import 'package:omni_video_player/omni_video_player/widgets/omni_video_player.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  const VideoWidget({super.key, required this.videoId});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  OmniPlaybackController? _controller;

  void _update() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: OmniVideoPlayer(
        // Callbacks
        callbacks: VideoPlayerCallbacks(
          onControllerCreated: (controller) {
            _controller?.removeListener(_update);
            _controller = controller..addListener(_update);
          },
          onFullScreenToggled: (isFullScreen) {},
          onOverlayControlsVisibilityChanged: (areVisible) {},
          onCenterControlsVisibilityChanged: (areVisible) {},
          onMuteToggled: (isMute) {},
          onSeekStart: (pos) {},
          onSeekEnd: (pos) {},
          onSeekRequest: (target) => true,
          onFinished: () {},
          onReplay: () {},
        ),

        configuration: VideoPlayerConfiguration(
          videoSourceConfiguration:
              VideoSourceConfiguration.youtube(
                videoUrl: Uri.parse(
                  'https://www.youtube.com/watch?v=${widget.videoId}',
                ),
                preferredQualities: [
                  OmniVideoQuality.high720,
                  OmniVideoQuality.low144,
                ],
                availableQualities: [
                  OmniVideoQuality.high1080,
                  OmniVideoQuality.high720,
                  OmniVideoQuality.low144,
                ],
                enableYoutubeWebViewFallback: true,
                forceYoutubeWebViewOnly: false,
              ).copyWith(
                autoPlay: false,
                initialPosition: Duration.zero,
                initialVolume: 1.0,
                initialPlaybackSpeed: 1.0,
                availablePlaybackSpeed: [0.5, 1.0, 1.25, 1.5, 2.0],
                autoMuteOnStart: false,
                allowSeeking: true,
                synchronizeMuteAcrossPlayers: true,
                timeoutDuration: const Duration(seconds: 30),
              ),
          playerTheme: OmniVideoPlayerThemeData().copyWith(
            icons: VideoPlayerIconTheme().copyWith(
              error: Icons.warning,
              playbackSpeedButton: Icons.speed,
            ),
            overlays: VideoPlayerOverlayTheme().copyWith(
              backgroundColor: Colors.white,
              alpha: 25,
            ),
          ),
          playerUIVisibilityOptions: PlayerUIVisibilityOptions().copyWith(
            showSeekBar: true,
            showCurrentTime: true,
            showDurationTime: true,
            showRemainingTime: true,
            showLiveIndicator: true,
            showLoadingWidget: true,
            showErrorPlaceholder: true,
            showReplayButton: true,
            showThumbnailAtStart: true,
            showVideoBottomControlsBar: true,
            showBottomControlsBarOnEndedFullscreen: true,
            showFullScreenButton: true,
            showSwitchVideoQuality: true,
            showSwitchWhenOnlyAuto: true,
            showPlaybackSpeedButton: true,
            showMuteUnMuteButton: true,
            showPlayPauseReplayButton: true,
            useSafeAreaForBottomControls: true,
            showGradientBottomControl: true,
            enableForwardGesture: true,
            enableBackwardGesture: true,
            enableExitFullscreenOnVerticalSwipe: true,
            enableOrientationLock: true,
            controlsPersistenceDuration: const Duration(seconds: 3),
            customAspectRatioNormal: null,
            customAspectRatioFullScreen: null,
            fullscreenOrientation: null,
          ),
          customPlayerWidgets: CustomPlayerWidgets().copyWith(
            loadingWidget: const Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
            errorPlaceholder: null,
            bottomControlsBar: null,
            leadingBottomButtons: null,
            trailingBottomButtons: null,
            customSeekBar: null,
            customDurationDisplay: null,
            customRemainingTimeDisplay: null,
            thumbnail: null,
            thumbnailFit: null,
            customOverlayLayers: null,
            fullscreenWrapper: null,
          ),
          liveLabel: "LIVE",
          enableBackgroundOverlayClip: true,
        ),
      ),
    );
  }
}
