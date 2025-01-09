#
# Be sure to run `pod lib lint SwiftCoreData.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftCoreData'
  s.version          = '1.0.2'
  s.summary          = 'SwiftCoreData is a simple library for manage Core Data Stack'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  SwiftCoreData is a simple library for manage Core Data Stack.
                       DESC

  s.homepage         = 'https://github.com/sapgv/SwiftCoreData'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sapgv' => 'grisha.sapgv@mail.ru' }
  s.source           = { :git => 'https://github.com/sapgv/SwiftCoreData.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '11.0'
  s.swift_version = '5.0'
  
  s.source_files = 'SwiftCoreData/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftCoreData' => ['SwiftCoreData/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
