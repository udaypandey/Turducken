# Run `pod lib lint FanMaker.podspec' to ensure this is a valid spec before submitting.
#
# Please refer https://guides.cocoapods.org/syntax/podspec.html
Pod::Spec.new do |s|
  s.name             = 'FanMaker'
  s.version          = '1.2.3'
  s.summary          = 'FanMaker Swift SDK'
  s.description      = <<-DESC
Swift SDK for FanMaker Product
                       DESC
  s.homepage         = 'https://github.com/udaypandey/Turducken'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Uday Pandey' => 'uday.pandey@gmail.com' }
  s.source           = { :git => 'https://github.com/udaypandey/Turducken.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5']

  s.source_files = 'Sources/**/*.swift'
  
  s.resource_bundles = {
    'FanMaker' => ['Sources/FanMaker/Resources/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
