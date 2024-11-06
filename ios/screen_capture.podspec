Pod::Spec.new do |s|
  s.name             = 'screen_capture'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin for screen recording on macOS and iOS, supporting system audio.'
  s.description      = <<-DESC
                       This Flutter plugin enables screen recording capabilities on both macOS and iOS.
                       DESC
  s.homepage         = 'https://appquirk.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AppQuirk' => 'bilal.javed1000@gmail.com' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '13.0'
  s.source_files     = 'Classes/**/*.{h,m,swift}'
  s.dependency       'Flutter'
end
