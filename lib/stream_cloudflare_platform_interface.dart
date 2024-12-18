import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'stream_cloudflare_method_channel.dart';

abstract class StreamCloudflarePlatform extends PlatformInterface {
  StreamCloudflarePlatform() : super(token: _token);

  static final Object _token = Object();

  static StreamCloudflarePlatform _instance = MethodChannelStreamCloudflare();

  static StreamCloudflarePlatform get instance => _instance;

  static set instance(StreamCloudflarePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();
}
