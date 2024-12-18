package com.example.stream_cloudflare_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.example.stream_cloudflare.StreamCloudflarePlugin

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        StreamCloudflarePlugin.registerWith(flutterEngine?.dartExecutor?.binaryMessenger)
    }
}
