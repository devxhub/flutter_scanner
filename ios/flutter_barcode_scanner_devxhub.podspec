#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_scanner_devxhub'
  s.version          = '1.0.0'
  s.summary          = 'The Flutter Scanner plugin offers seamless barcode and QR code scanning capabilities for Flutter apps on Android and iOS. It supports a range of code types, enhancing mobile app functionality.'
  s.description      = <<-DESC
  The Flutter Scanner plugin offers seamless barcode and QR code scanning capabilities for Flutter apps on Android and iOS. It supports a range of code types, enhancing mobile app functionality.
                       DESC
  s.homepage         = 'https://github.com/devxhub/flutter_scanner'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DEVxHUB' => 'support@devxhub.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{swift,h,m}'
  s.public_header_files = 'Classes/**/*.h'
  s.resources = 'Assets/*.png'
  s.dependency 'Flutter'

  s.ios.deployment_target = '11.0'  
  s.swift_version = '5.0'
end
