#
# Be sure to run `pod lib lint SVSwiftHelpers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SVSwiftHelpers'
  s.version          = '1.1.6'
  s.summary          = 'SVSwiftHelpers has collection of multiple extensions'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'SVSwiftHelpers has collection of multiple extensions and helpers. Just import and start using'
                       DESC

  s.homepage         = 'https://github.com/sudhakar-varma/SVSwiftHelpers'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sudhakar' => 'sudhakarvarma.ios@gmail.com' }
  s.source           = { :git => 'https://github.com/sudhakar-varma/SVSwiftHelpers.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sudhakarVarmaD'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*.{swift, plist}'
  s.resources = 'Sources/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,json}'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'SVSwiftHelpers' => ['SVSwiftHelpers/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
