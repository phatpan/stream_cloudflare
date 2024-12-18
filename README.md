# stream_cloudflare

A Flutter plugin to integrate Cloudflare Stream for video playback with advanced features, such as adaptive quality management (HLS), audio track switching, and subtitle support.

This plugin provides a native implementation using ExoPlayer (Android) and AVPlayer (iOS) for high performance and feature completeness without relying on WebView.

## Features
1. Adaptive Quality Management (HLS)

    Supports HLS streaming with automatic bitrate adjustment based on network conditions.

2. Audio Track Switching

    Switch between multiple audio tracks dynamically.

3. Subtitle Support

    Load and switch between subtitle tracks (e.g., WebVTT) during video playback.

4. Low Latency

    Optimized for real-time adaptive streaming with Cloudflare Stream.

5. Cross-Platform

    Works seamlessly on Android and iOS devices.

# Installation
Add the dependency to your pubspec.yaml:

dependencies:

  `stream_cloudflare: ^1.0.0`

Run flutter pub get to install the plugin.

### Usage
1. Basic Setup
Import the plugin:

`import 'package:stream_cloudflare/stream_cloudflare.dart';`

Create an instance of the StreamCloudflare class:

`final streamCloudflare = StreamCloudflare();`

2. Play Video

To play a video using its Cloudflare Stream video ID:

`streamCloudflare.play('your_cloudflare_video_id');`

3. Switch Audio Track

Switch the audio track dynamically during playback:

`streamCloudflare.setAudioTrack(1); // Track ID: 1`

4. Switch Subtitle Track

Load and enable a specific subtitle track:

`streamCloudflare.setSubtitleTrack(2); // Subtitle track ID: 2`

## Example Code

Here is a full example of integrating the plugin in your Flutter app:

```
import 'package:flutter/material.dart';
import 'package:stream_cloudflare/stream_cloudflare.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final streamCloudflare = StreamCloudflare();

  @override
  void initState() {
    super.initState();
    _playVideo();
  }

  void _playVideo() {
    streamCloudflare.play('your_cloudflare_video_id');
  }

  void _changeAudioTrack() {
    streamCloudflare.setAudioTrack(1);
  }

  void _changeSubtitleTrack() {
    streamCloudflare.setSubtitleTrack(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cloudflare Video Player")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _changeAudioTrack,
              child: Text("Change Audio Track"),
            ),
            ElevatedButton(
              onPressed: _changeSubtitleTrack,
              child: Text("Change Subtitle"),
            ),
          ],
        ),
      ),
    );
  }
}

```
### Contributing
Contributions are welcome! To report issues or propose new features, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch (feature/your-feature-name).
3. Commit your changes.
4. Open a pull request.

### Support
For questions or help using this plugin, please create an issue in the repository or contact me directly.