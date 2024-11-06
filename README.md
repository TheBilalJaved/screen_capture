# flutter_screen_capture

A Flutter plugin for macOS and IOS to record the screen and capture system audio, designed for seamless integration in Flutter applications. This plugin currently supports **screen recording on macOS and IOS only**.

## Features

- Screen recording functionality on macOS and IOS
- System audio recording (not microphone)
- Customizable recording settings
- Simple API for starting and stopping recordings

## Installation

Add `flutter_screen_capture` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_screen_capture:
    path: path/to/your/plugin
```

Or install from GitHub (if you’re planning to publish it):

```yaml
dependencies:
  flutter_screen_capture:
    git:
      url: https://github.com/TheBilalJaved/flutter_screen_capture.git
```

Then, run:

```bash
flutter pub get
```

## Usage

1. **Import the Plugin**  
   In your Dart code, import the `flutter_screen_capture` package:

   ```dart
   import 'package:flutter_screen_capture/flutter_screen_capture.dart';
   ```

2. **Start and Stop Recording**  
   Use `startRecording` and `stopRecording` methods to manage recording sessions.

   ```dart
   // Start recording
   await FlutterScreenCapture.startRecording();

   // Stop recording
   await FlutterScreenCapture.stopRecording();
   ```

3. **Save and Play Recordings**  
   Save the recordings to a local file and use a media player to review the results.

## Example App

Here is a simple example of how to implement the screen recording functionality in your Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screen_capture/flutter_screen_capture.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Recorder Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Screen Recorder Example'),
        ),
        body: const ScreenRecorderWidget(),
      ),
    );
  }
}

class ScreenRecorderWidget extends StatefulWidget {
  const ScreenRecorderWidget({super.key});

  @override
  State<ScreenRecorderWidget> createState() => _ScreenRecorderWidgetState();
}

class _ScreenRecorderWidgetState extends State<ScreenRecorderWidget> {
  String _status = "Ready to Record";

  void _startRecording() async {
    final result = await FlutterScreenCapture.startRecording();
    setState(() {
      _status = result;
    });
  }

  void _stopRecording() async {
    final result = await FlutterScreenCapture.stopRecording();
    setState(() {
      _status = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_status),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startRecording,
                child: const Text("Start Recording"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _stopRecording,
                child: const Text("Stop Recording"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## Permissions

Ensure your macOS application has the necessary permissions:

1. Open `macos/Runner/Info.plist`.
2. Add the following keys to request screen recording permission:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to record the screen.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need access to capture system audio during screen recording.</string>
```

## Notes

- This plugin is currently macOS only.
- The plugin captures system audio only, not microphone input.
- Audio is captured through an `AVAudioEngine`, which can be customized further if needed.

## License

MIT License. See LICENSE file for details.
