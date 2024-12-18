import Flutter
import UIKit
import AVFoundation

public class StreamCloudflarePlugin: NSObject, FlutterPlugin {
  var player: AVPlayer!
  var playerItem: AVPlayerItem!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "stream_cloudflare", binaryMessenger: registrar.messenger())
    let instance = StreamCloudflarePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "play":
      let args = call.arguments as! [String: Any]
      let videoId = args["videoId"] as! String
      playVideo(videoId: videoId)
      result(nil)
    case "setAudioTrack":
      let args = call.arguments as! [String: Any]
      let trackId = args["trackId"] as! Int
      setAudioTrack(trackId: trackId)
      result(nil)
    case "setSubtitleTrack":
      let args = call.arguments as! [String: Any]
      let trackId = args["trackId"] as! Int
      setSubtitleTrack(trackId: trackId)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func playVideo(videoId: String) {
    let url = URL(string: "https://videodelivery.net/\(videoId)/manifest/video.m3u8")!
    playerItem = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: playerItem)
    player.play()
  }

  private func setAudioTrack(trackId: Int) {
    playerItem.select(trackId)
  }

  private func setSubtitleTrack(trackId: Int) {
    playerItem.select(trackId)
  }
}
