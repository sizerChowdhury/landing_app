package com.example.destination_app

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import DeepLinkApi

class MainActivity : FlutterActivity() {
    private lateinit var deepLinkApi: DeepLinkApi

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        deepLinkApi = DeepLinkApi(flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleDeepLink(intent)
    }

    private fun handleDeepLink(intent: Intent) {
        intent.data?.let { uri ->
            val message = uri.getQueryParameter("message") ?: "No message received"

            deepLinkApi.getMessage(message){

            }
        }
    }
}
