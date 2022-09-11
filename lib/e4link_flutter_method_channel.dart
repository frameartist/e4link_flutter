import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'e4link_flutter_platform_interface.dart';

/// An implementation of [E4linkFlutterPlatform] that uses method channels.
class MethodChannelE4linkFlutter extends E4linkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('e4link_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
