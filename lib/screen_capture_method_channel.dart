import 'package:flutter/services.dart';
import 'package:screen_capture/screen_capture_platform_interface.dart';

class MethodChannelFlutterScreenCapture extends FlutterScreenCapturePlatform {
  static const MethodChannel _channel = MethodChannel('screen_capture');

  @override
  Future<String?> getPlatformVersion() async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Future<String> startRecording() async {
    final String result = await _channel.invokeMethod('startRecording');
    return result;
  }

  @override
  Future<String> stopRecording() async {
    final String result = await _channel.invokeMethod('stopRecording');
    return result;
  }
}
