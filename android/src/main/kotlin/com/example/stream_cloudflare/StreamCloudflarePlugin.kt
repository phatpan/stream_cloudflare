package com.example.stream_cloudflare

import android.content.Context
import androidx.annotation.NonNull
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class StreamCloudflarePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var player: ExoPlayer
    private lateinit var trackSelector: DefaultTrackSelector

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "stream_cloudflare")
        channel.setMethodCallHandler(this)

        val context: Context = flutterPluginBinding.applicationContext
        trackSelector = DefaultTrackSelector(context)
        player = ExoPlayer.Builder(context).setTrackSelector(trackSelector).build()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "play" -> {
                val videoId: String? = call.argument("videoId")
                if (videoId != null) {
                    playVideo(videoId)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "videoId is required", null)
                }
            }
            "setAudioTrack" -> {
                val trackId: Int? = call.argument("trackId")
                if (trackId != null) {
                    setAudioTrack(trackId)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "trackId is required", null)
                }
            }
            "setSubtitleTrack" -> {
                val subtitleTrackId: Int? = call.argument("trackId")
                if (subtitleTrackId != null) {
                    setSubtitleTrack(subtitleTrackId)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "trackId is required", null)
                }
            }
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            else -> result.notImplemented()
        }
    }

    private fun playVideo(videoId: String) {
        val url = "https://videodelivery.net/$videoId/manifest/video.m3u8"
        val mediaItem = MediaItem.fromUri(url)
        player.setMediaItem(mediaItem)
        player.prepare()
        player.play()
    }

    private fun setAudioTrack(trackId: Int) {
        trackSelector.setParameters(
            trackSelector.buildUponParameters().setPreferredAudioLanguage(trackId.toString())
        )
    }

    private fun setSubtitleTrack(trackId: Int) {
        trackSelector.setParameters(
            trackSelector.buildUponParameters().setPreferredTextLanguage(trackId.toString())
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        player.release()
    }
}
