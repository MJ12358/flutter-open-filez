import 'package:flutter_open_filez/flutter_open_filez.dart';
import 'package:flutter_open_filez/flutter_open_filez_method_channel.dart';
import 'package:flutter_open_filez/flutter_open_filez_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterOpenFilezPlatform
    with MockPlatformInterfaceMixin
    implements FlutterOpenFilezPlatform {
  @override
  Future<void> open(Map<String, String?> params) => Future<void>.value();
}

void main() {
  final FlutterOpenFilezPlatform initialPlatform =
      FlutterOpenFilezPlatform.instance;

  test('$MethodChannelFlutterOpenFilez is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterOpenFilez>());
  });

  test('getPlatformVersion', () async {
    // final FlutterOpenFilez flutterOpenFilezPlugin = FlutterOpenFilez();
    final MockFlutterOpenFilezPlatform fakePlatform =
        MockFlutterOpenFilezPlatform();
    FlutterOpenFilezPlatform.instance = fakePlatform;

    await FlutterOpenFilez().open('path');
  });
}
