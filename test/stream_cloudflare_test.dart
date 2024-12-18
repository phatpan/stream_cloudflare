import 'package:flutter_test/flutter_test.dart';
import 'package:stream_cloudflare/stream_cloudflare.dart';
import 'package:stream_cloudflare/stream_cloudflare_platform_interface.dart';
import 'package:stream_cloudflare/stream_cloudflare_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStreamCloudflarePlatform
    with MockPlatformInterfaceMixin
    implements StreamCloudflarePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StreamCloudflarePlatform initialPlatform = StreamCloudflarePlatform.instance;

  test('$MethodChannelStreamCloudflare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStreamCloudflare>());
  });

  test('getPlatformVersion', () async {
    StreamCloudflare streamCloudflarePlugin = StreamCloudflare();
    MockStreamCloudflarePlatform fakePlatform = MockStreamCloudflarePlatform();
    StreamCloudflarePlatform.instance = fakePlatform;

    expect(await streamCloudflarePlugin.getPlatformVersion(), '42');
  });
}
