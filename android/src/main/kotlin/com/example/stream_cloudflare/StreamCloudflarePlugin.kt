package com.example.stream_cloudflare

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.exoplayer2.*
import com.google.android.exoplayer2.trackselection.*
import com.google.android.exoplayer2.ui.PlayerView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.google.android.exoplayer2.source.*
import com.google.android.exoplayer2.source.hls.HlsMediaSource
import com.google.android.exoplayer2.upstream.DefaultDataSource

class StreamCloudflarePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var player: ExoPlayer
    private lateinit var trackSelector: DefaultTrackSelector
    private lateinit var context: Context
    private var playerView: PlayerView? = null

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
                val trackIndex: Int? = call.argument("trackId")
                if (trackIndex != null) {
                    setAudioTrack(trackIndex)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "trackId is required", null)
                }
            }
            "setSubtitleTrack" -> {
                val trackIndex: Int? = call.argument("trackId")
                if (trackIndex != null) {
                    setSubtitleTrack(trackIndex)
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
        val dataSourceFactory = DefaultDataSource.Factory(context)
        val mediaSource: MediaSource = HlsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(url))

        player.setMediaSource(mediaSource)
        player.prepare()
        player.play()

        Log.d("StreamCloudflarePlugin", "Playing video: $url")
    }

    private fun setAudioTrack(trackIndex: Int) {
        val mappedTrackInfo = trackSelector.currentMappedTrackInfo
        if (mappedTrackInfo != null) {
            for (rendererIndex in 0 until mappedTrackInfo.rendererCount) {
                val trackGroups = mappedTrackInfo.getTrackGroups(rendererIndex)
                for (groupIndex in 0 until trackGroups.length) {
                    if (trackGroups.get(groupIndex).type == C.TRACK_TYPE_AUDIO) {
                        val parameters = trackSelector.buildUponParameters()
                            .setSelectionOverride(rendererIndex, trackGroups, SelectionOverride(groupIndex, trackIndex))
                        trackSelector.setParameters(parameters)
                        Log.d("StreamCloudflarePlugin", "Audio track set to index: $trackIndex")
                        return
                    }
                }
            }
        }
        Log.e("StreamCloudflarePlugin", "Failed to set audio track: Invalid index")
    }

    private fun setSubtitleTrack(trackIndex: Int) {
        val mappedTrackInfo = trackSelector.currentMappedTrackInfo
        if (mappedTrackInfo != null) {
            for (rendererIndex in 0 until mappedTrackInfo.rendererCount) {
                val trackGroups = mappedTrackInfo.getTrackGroups(rendererIndex)
                for (groupIndex in 0 until trackGroups.length) {
                    if (trackGroups.get(groupIndex).type == C.TRACK_TYPE_TEXT) {
                        val parameters = trackSelector.buildUponParameters()
                            .setSelectionOverride(rendererIndex, trackGroups, SelectionOverride(groupIndex, trackIndex))
                        trackSelector.setParameters(parameters)
                        Log.d("StreamCloudflarePlugin", "Subtitle track set to index: $trackIndex")
                        return
                    }
                }
            }
        }
        Log.e("StreamCloudflarePlugin", "Failed to set subtitle track: Invalid index")
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        player.release()
        playerView = null
    }
}