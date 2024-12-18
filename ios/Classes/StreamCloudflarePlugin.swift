import Flutter
import UIKit
import AVFoundation

public class StreamCloudflarePlugin: NSObject, FlutterPlugin {
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var playerLayer: AVPlayerLayer?
    private var currentViewController: UIViewController? // For displaying the player

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "stream_cloudflare", binaryMessenger: registrar.messenger())
        let instance = StreamCloudflarePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "play":
            guard let args = call.arguments as? [String: Any],
                  let videoId = args["videoId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "videoId is required", details: nil))
                return
            }
            playVideo(videoId: videoId)
            result(nil)
        case "setAudioTrack":
            guard let args = call.arguments as? [String: Any],
                  let trackIndex = args["trackId"] as? Int else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "trackId is required", details: nil))
                return
            }
            setAudioTrack(trackIndex: trackIndex)
            result(nil)
        case "setSubtitleTrack":
            guard let args = call.arguments as? [String: Any],
                  let trackIndex = args["trackId"] as? Int else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "trackId is required", details: nil))
                return
            }
            setSubtitleTrack(trackIndex: trackIndex)
            result(nil)
        case "getPlatformVersion":
            result("iOS \(UIDevice.current.systemVersion)")
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func playVideo(videoId: String) {
        let urlString = "https://videodelivery.net/\(videoId)/manifest/video.m3u8"
        guard let url = URL(string: urlString) else { return }

        // Initialize player
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        // Display the player in the app
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                self.currentViewController = rootVC
                self.playerLayer?.removeFromSuperlayer() // Clean up any existing layer

                let layer = AVPlayerLayer(player: self.player)
                layer.frame = rootVC.view.bounds
                rootVC.view.layer.addSublayer(layer)
                self.playerLayer = layer

                self.player?.play()
            }
        }
    }

    private func setAudioTrack(trackIndex: Int) {
        guard let group = playerItem?.asset.mediaSelectionGroup(forMediaCharacteristic: .audible),
              group.options.indices.contains(trackIndex) else {
            print("Invalid audio track index")
            return
        }

        let selectedOption = group.options[trackIndex]
        playerItem?.select(selectedOption, in: group)
    }

    private func setSubtitleTrack(trackIndex: Int) {
        guard let group = playerItem?.asset.mediaSelectionGroup(forMediaCharacteristic: .legible),
              group.options.indices.contains(trackIndex) else {
            print("Invalid subtitle track index")
            return
        }

        let selectedOption = group.options[trackIndex]
        playerItem?.select(selectedOption, in: group)
    }
}