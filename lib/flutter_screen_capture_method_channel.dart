import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_screen_capture_platform_interface.dart';

/// An implementation of [FlutterScreenCapturePlatform] that uses method channels.
class MethodChannelFlutterScreenCapture extends FlutterScreenCapturePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_screen_capture');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
