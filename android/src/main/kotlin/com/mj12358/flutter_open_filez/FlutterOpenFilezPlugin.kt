package com.mj12358.flutter_open_filez

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

// TODO: This should prolly be in its own package,
// in order to use their "federated" plugins.....

/** FlutterOpenFilezPlugin */
class FlutterOpenFilezPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "flutter_open_filez")
    channel.setMethodCallHandler(this)
    context = binding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    var path: String = call.argument("path")!!
    var type: String? = call.argument("type")

    when (call.method) {
      "open" -> {
        _openFile(path, type)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  fun _openFile(@NonNull path: String, type: String?) {
    var file: File = File(path)
    var intent: Intent = Intent(Intent.ACTION_VIEW)
    var uri: Uri = Uri.fromFile(file)

    // android versions N or above require a "FileProvider"
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      // id like to use androids built-in fileprovider here
      // uri = FileProvider.getUriForFile(context, BuildConfig.APPLICATION_ID + ".provider", file)
      uri =
          FileProvider.getUriForFile(
              context,
              context.packageName + ".fileProvider.com.mj12358.flutter_open_filez",
              file
          )
    }

    intent.addCategory(Intent.CATEGORY_DEFAULT)
    intent.setDataAndType(uri, type)
    intent.addFlags(
        Intent.FLAG_ACTIVITY_NEW_TASK or
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
            Intent.FLAG_GRANT_WRITE_URI_PERMISSION
    )

    context.startActivity(intent)
  }
}
