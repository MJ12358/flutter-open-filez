import 'package:flutter_open_filez/flutter_open_filez_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterOpenFilezPlatform extends PlatformInterface {
  /// Constructs a FlutterOpenFilezPlatform.
  FlutterOpenFilezPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterOpenFilezPlatform _instance = MethodChannelFlutterOpenFilez();

  /// The default instance of [FlutterOpenFilezPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterOpenFilez].
  static FlutterOpenFilezPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterOpenFilezPlatform] when
  /// they register themselves.
  static set instance(FlutterOpenFilezPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> open(Map<String, String?> params) {
    throw UnimplementedError('open() has not been implemented.');
  }
}
