import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_filez/flutter_open_filez_platform_interface.dart';

/// An implementation of [FlutterOpenFilezPlatform] that uses method channels.
class MethodChannelFlutterOpenFilez extends FlutterOpenFilezPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel('flutter_open_filez');

  @override
  Future<void> open(Map<String, String?> params) async {
    return methodChannel.invokeMethod<void>('open', params);
  }
}
