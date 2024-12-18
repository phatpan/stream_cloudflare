import 'package:flutter/services.dart';

class StreamCloudflare {
  static const MethodChannel _channel = MethodChannel('stream_cloudflare');

  /// Play video using Cloudflare Stream
  Future<void> play(String videoId) async {
    await _channel.invokeMethod('play', {'videoId': videoId});
  }

  /// Set audio track
  Future<void> setAudioTrack(int trackId) async {
    await _channel.invokeMethod('setAudioTrack', {'trackId': trackId});
  }

  /// Set subtitle track
  Future<void> setSubtitleTrack(int trackId) async {
    await _channel.invokeMethod('setSubtitleTrack', {'trackId': trackId});
  }
}
