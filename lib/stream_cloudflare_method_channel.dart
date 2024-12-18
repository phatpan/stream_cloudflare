import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stream_cloudflare_platform_interface.dart';

/// An implementation of [StreamCloudflarePlatform] that uses method channels.
class MethodChannelStreamCloudflare extends StreamCloudflarePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('stream_cloudflare');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
