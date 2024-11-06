import 'package:flutter/services.dart';

import 'screen_capture_platform_interface.dart';

class FlutterScreenCapture {
  Future<String?> getPlatformVersion() {
    return FlutterScreenCapturePlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel('screen_capture');

  static Future<String> startRecording() async {
    final String result = await _channel.invokeMethod('startRecording');
    return result;
  }

  static Future<String> stopRecording() async {
    final String result = await _channel.invokeMethod('stopRecording');
    return result;
  }
}
