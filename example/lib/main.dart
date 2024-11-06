import 'package:flutter/material.dart';
import 'package:screen_capture/screen_capture.dart';

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
    try {
      final result = await FlutterScreenCapture.startRecording();
      setState(() {
        _status = result;
      });
    } catch (e) {
      setState(() {
        _status = "Error starting recording: $e";
      });
    }
  }

  void _stopRecording() async {
    try {
      final result = await FlutterScreenCapture.stopRecording();
      setState(() {
        _status = result;
      });
    } catch (e) {
      setState(() {
        _status = "Error stopping recording: $e";
      });
    }
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
