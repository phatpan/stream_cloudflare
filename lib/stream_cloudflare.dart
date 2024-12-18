import 'package:flutter/services.dart';
import 'stream_cloudflare_platform_interface.dart';

class StreamCloudflare {
  static const MethodChannel _channel = MethodChannel('stream_cloudflare');

  Future<void> play(String videoId) async {
    await _channel.invokeMethod('play', {'videoId': videoId});
  }

  Future<void> setAudioTrack(int trackId) async {
    await _channel.invokeMethod('setAudioTrack', {'trackId': trackId});
  }

  Future<void> setSubtitleTrack(int trackId) async {
    await _channel.invokeMethod('setSubtitleTrack', {'trackId': trackId});
  }

  Future<String?> getPlatformVersion() {
    return StreamCloudflarePlatform.instance.getPlatformVersion();
  }
}
