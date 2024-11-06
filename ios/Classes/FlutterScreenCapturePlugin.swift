import Flutter
import ReplayKit
import UIKit

public class FlutterScreenCapturePlugin: NSObject, FlutterPlugin {
    private let recorder = RPScreenRecorder.shared()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "screen_capture", binaryMessenger: registrar.messenger())
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

        recorder.startRecording { error in
            if let error = error {
                if (error as NSError).code == -5801 {
                    result(FlutterError(code: "USER_DENIED", message: "The user declined application recording", details: nil))
                } else {
                    result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
                }
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

            // Handle the preview view properly
            if let previewVC = previewVC {
                DispatchQueue.main.async {
                    // Ensure this is being presented in a valid context
                    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                        // Present the preview view controller
                        rootVC.present(previewVC, animated: true, completion: nil)

                        // Handle save and cancel actions
                        previewVC.previewControllerDelegate = self
                        result("Recording stopped and ready for preview.")
                    } else {
                        result("Error: Unable to get root view controller.")
                    }
                }
            } else {
                result("Recording stopped but no preview available.")
            }
        }
    }
}

extension FlutterScreenCapturePlugin: RPPreviewViewControllerDelegate {
    // Handle the save and cancel actions in the preview controller
    public func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        // This is triggered when the user taps "Cancel" in the preview view
        print("Recording canceled.")
        previewController.dismiss(animated: true, completion: nil)
    }

    public func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        // This is triggered when the user taps "Save" or completes the preview
        if activityTypes.contains(UIActivity.ActivityType.saveToCameraRoll.rawValue) {
            print("Recording saved.")
        } else if activityTypes.contains(UIActivity.ActivityType.mail.rawValue) {
            print("Recording sent via email.")
        } else {
            print("Recording action completed.")
        }
        
        // Dismiss the preview controller after the action is taken
        previewController.dismiss(animated: true, completion: nil)
    }
}
