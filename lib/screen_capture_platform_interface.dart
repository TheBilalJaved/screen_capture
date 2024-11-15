import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_capture_method_channel.dart';

abstract class FlutterScreenCapturePlatform extends PlatformInterface {
  /// Constructs a FlutterScreenCapturePlatform.
  FlutterScreenCapturePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterScreenCapturePlatform _instance =
      MethodChannelFlutterScreenCapture();

  /// The default instance of [FlutterScreenCapturePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterScreenCapture].
  static FlutterScreenCapturePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterScreenCapturePlatform] when
  /// they register themselves.
  static set instance(FlutterScreenCapturePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();

  Future<String> startRecording();
  Future<String> stopRecording();
}
