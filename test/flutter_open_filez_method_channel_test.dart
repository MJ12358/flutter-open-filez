import 'package:flutter/services.dart';
import 'package:flutter_open_filez/flutter_open_filez_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelFlutterOpenFilez platform =
      MethodChannelFlutterOpenFilez();
  const MethodChannel channel = MethodChannel('flutter_open_filez');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('open', () async {
    await platform.open(<String, String?>{
      'path': 'test',
      'type': 'test',
    });
  });
}
