import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e4link_flutter/e4link_flutter_method_channel.dart';

void main() {
  MethodChannelE4linkFlutter platform = MethodChannelE4linkFlutter();
  const MethodChannel channel = MethodChannel('e4link_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
