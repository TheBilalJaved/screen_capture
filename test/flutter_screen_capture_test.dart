import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:screen_capture/screen_capture.dart';
import 'package:screen_capture/screen_capture_method_channel.dart';
import 'package:screen_capture/screen_capture_platform_interface.dart';

// Mock platform class
class MockFlutterScreenCapturePlatform
    with MockPlatformInterfaceMixin
    implements FlutterScreenCapturePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> startRecording() {
    return Future.value('Recording started');
  }

  @override
  Future<String> stopRecording() {
    return Future.value('Recording stopped');
  }
}

void main() {
  final FlutterScreenCapturePlatform initialPlatform =
      FlutterScreenCapturePlatform.instance;

  setUp(() {
    // Setup: Ensure the default platform is replaced by the mock
    FlutterScreenCapturePlatform.instance = MockFlutterScreenCapturePlatform();
  });

  tearDown(() {
    // Tear down: Reset the instance after the test runs to avoid affecting other tests
    FlutterScreenCapturePlatform.instance = initialPlatform;
  });

  test('$MethodChannelFlutterScreenCapture is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterScreenCapture>());
  });

  test('getPlatformVersion', () async {
    FlutterScreenCapture flutterScreenCapturePlugin = FlutterScreenCapture();
    expect(await flutterScreenCapturePlugin.getPlatformVersion(), '42');
  });

  test('startRecording', () async {
    // Call startRecording directly on the class, not the instance
    expect(await FlutterScreenCapture.startRecording(), 'Recording started');
  });

  test('stopRecording', () async {
    // Call stopRecording directly on the class, not the instance
    expect(await FlutterScreenCapture.stopRecording(), 'Recording stopped');
  });
}
