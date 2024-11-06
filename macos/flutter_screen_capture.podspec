#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_screen_capture.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_screen_capture'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin for macOS and IOS to record the screen and capture system audio, designed for seamless integration in Flutter applications. This plugin currently supports screen recording on macOS and IOS only'
  s.description      = <<-DESC
A Flutter plugin for macOS and IOS to record the screen and capture system audio, designed for seamless integration in Flutter applications. This plugin currently supports screen recording on macOS and IOS only
                       DESC
  s.homepage         = 'https://appquirk.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'AppQuirk' => 'bilal.javed1000@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
