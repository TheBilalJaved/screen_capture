import Cocoa
import FlutterMacOS
import ReplayKit
import AVFoundation

public class FlutterScreenCapturePlugin: NSObject, FlutterPlugin {
    private let recorder = RPScreenRecorder.shared()
    private var audioEngine: AVAudioEngine?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "screen_capture", binaryMessenger: registrar.messenger)
        let instance = FlutterScreenCapturePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startRecording":
            startRecording(result: result)
        case "stopRecording":
            stopRecording(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startRecording(result: @escaping FlutterResult) {
        guard recorder.isAvailable else {
            result(FlutterError(code: "UNAVAILABLE", message: "Recording not available", details: nil))
            return
        }

        // Set up the audio engine
        audioEngine = AVAudioEngine()
        let mixer = audioEngine?.mainMixerNode

        // Start capturing audio from the virtual audio device
        let inputFormat = mixer?.outputFormat(forBus: 0)
        mixer?.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { buffer, when in
            // Process audio buffer here if needed
        }

        audioEngine?.prepare()
        do {
            try audioEngine?.start()
        } catch {
            result(FlutterError(code: "ERROR", message: "Failed to start audio engine: \(error.localizedDescription)", details: nil))
            return
        }

        recorder.startRecording { error in
            if let error = error {
                result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
            } else {
                result("Recording started.")
            }
        }
    }

    private func stopRecording(result: @escaping FlutterResult) {
        recorder.stopRecording { previewVC, error in
            if let error = error {
                result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
                return
            }

            // Stop audio engine
            self.audioEngine?.stop()
            self.audioEngine?.inputNode.removeTap(onBus: 0)

            // Check if the previewVC is available
            if let previewVC = previewVC {
                DispatchQueue.main.async {
                    // Present the preview controller
                    if let window = NSApplication.shared.windows.first {
                        window.contentViewController?.presentAsModalWindow(previewVC)
                    }
                    result("Recording stopped and ready for preview.")
                }
            } else {
                result("Recording stopped but no preview available.")
            }
        }
    }
}
