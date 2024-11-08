# screen_capture

A Flutter plugin for macOS and IOS to record the screen and capture system audio, designed for seamless integration in Flutter applications. This plugin currently supports **screen recording on macOS and IOS only**.

## Features

- Screen recording functionality on macOS and IOS
- System audio recording (not microphone)
- Customizable recording settings
- Simple API for starting and stopping recordings

## Installation

Add `screen_capture` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  screen_capture:
    path: path/to/your/plugin
```

Or install from GitHub (if you’re planning to publish it):

```yaml
dependencies:
  screen_capture:
    git:
      url: https://github.com/TheBilalJaved/screen_capture.git
```

Then, run:

```bash
flutter pub get
```

## Usage

1. **Import the Plugin**  
   In your Dart code, import the `screen_capture` package:

   ```dart
   import 'package:screen_capture/screen_capture.dart';
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
