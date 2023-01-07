#
# Be sure to run `pod lib lint BGTableViewComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BGTableViewComponent'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BGTableViewComponent.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  一款简单易用的TableView组件，快速搭建复杂类型cell列表视图，逻辑清晰易拓展，cell支持纯代码、xib。
                       DESC

  s.homepage         = 'https://github.com/Bingo/BGTableViewComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bingo-xu' => '1203_xu@sina.com' }
  s.source           = { :git => 'https://github.com/Bingo-xu/BGTableViewComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

#  s.source_files = 'BGTableViewComponent/Classes/**/*'
#  s.public_header_files = 'BGTableViewComponent/Classes/BGTableViewComponent/**/*.h'
#  s.default_subspec = 'Core'

#s.static_framework = true
#s.subspec 'Framework' do |co|
#   co.vendored_frameworks = 'xxx/*.xcframework'
#end

  s.subspec 'Interface' do |inte|
      inte.source_files = 'BGTableViewComponent/Classes/Interface/**/*.{h,m}'
  end
  
  s.subspec 'Private' do |pr|
      pr.source_files = 'BGTableViewComponent/Classes/Private/**/*.{h,m}'
      pr.dependency 'BGTableViewComponent/Interface'
  end

  s.subspec 'Croe' do |bg|
      bg.source_files = 'BGTableViewComponent/Classes/Croe/**/*.{h,m}'
      bg.dependency 'BGTableViewComponent/Private'
  end
  
  # s.resource_bundles = {
  #   'BGTableViewComponent' => ['BGTableViewComponent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
