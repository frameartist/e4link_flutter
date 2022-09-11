import 'package:flutter_test/flutter_test.dart';
import 'package:e4link_flutter/e4link_flutter.dart';
import 'package:e4link_flutter/e4link_flutter_platform_interface.dart';
import 'package:e4link_flutter/e4link_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockE4linkFlutterPlatform 
    with MockPlatformInterfaceMixin
    implements E4linkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final E4linkFlutterPlatform initialPlatform = E4linkFlutterPlatform.instance;

  test('$MethodChannelE4linkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelE4linkFlutter>());
  });

  test('getPlatformVersion', () async {
    E4linkFlutter e4linkFlutterPlugin = E4linkFlutter();
    MockE4linkFlutterPlatform fakePlatform = MockE4linkFlutterPlatform();
    E4linkFlutterPlatform.instance = fakePlatform;
  
    expect(await e4linkFlutterPlugin.getPlatformVersion(), '42');
  });
}
