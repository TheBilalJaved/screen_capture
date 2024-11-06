import 'package:flutter_screen_capture/flutter_screen_capture.dart';
import 'package:flutter_screen_capture/flutter_screen_capture_method_channel.dart';
import 'package:flutter_screen_capture/flutter_screen_capture_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterScreenCapturePlatform
    with MockPlatformInterfaceMixin
    implements FlutterScreenCapturePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterScreenCapturePlatform initialPlatform =
      FlutterScreenCapturePlatform.instance;

  test('$MethodChannelFlutterScreenCapture is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterScreenCapture>());
  });

  test('getPlatformVersion', () async {
    FlutterScreenCapture flutterScreenCapturePlugin = FlutterScreenCapture();
    MockFlutterScreenCapturePlatform fakePlatform =
        MockFlutterScreenCapturePlatform();
    FlutterScreenCapturePlatform.instance = fakePlatform;

    expect(await flutterScreenCapturePlugin.getPlatformVersion(), '42');
  });
}
