import 'package:flutter/services.dart';
import 'stream_cloudflare_platform_interface.dart';

class MethodChannelStreamCloudflare extends StreamCloudflarePlatform {
  static const MethodChannel _channel = MethodChannel('stream_cloudflare');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
