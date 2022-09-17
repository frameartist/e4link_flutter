import 'package:e4link_flutter/models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'e4link_flutter_method_channel.dart';

abstract class E4linkFlutterPlatform extends PlatformInterface {
  /// Constructs a E4linkFlutterPlatform.
  E4linkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static E4linkFlutterPlatform _instance = MethodChannelE4linkFlutter();

  /// The default instance of [E4linkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelE4linkFlutter].
  static E4linkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [E4linkFlutterPlatform] when
  /// they register themselves.
  static set instance(E4linkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<E4Device>> discoverDevices() {
    throw UnimplementedError('discoverDevices() has not been implemented.');
  }

  Future<void> connect(String id) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  void unsubscribe(String id, String feature) {
    throw UnimplementedError('unsubscribe() has not been implemented.');
  }

  void subscribe(String id, String feature) { 
    throw UnimplementedError('usubscribe() has not been implemented.');
  }
}
