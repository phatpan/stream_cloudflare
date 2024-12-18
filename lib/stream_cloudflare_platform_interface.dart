import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'stream_cloudflare_method_channel.dart';

abstract class StreamCloudflarePlatform extends PlatformInterface {
  /// Constructs a StreamCloudflarePlatform.
  StreamCloudflarePlatform() : super(token: _token);

  static final Object _token = Object();

  static StreamCloudflarePlatform _instance = MethodChannelStreamCloudflare();

  /// The default instance of [StreamCloudflarePlatform] to use.
  ///
  /// Defaults to [MethodChannelStreamCloudflare].
  static StreamCloudflarePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StreamCloudflarePlatform] when
  /// they register themselves.
  static set instance(StreamCloudflarePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
