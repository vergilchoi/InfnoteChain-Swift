#
# Be sure to run `pod lib lint InfnoteChain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'InfnoteChain'
    s.version          = '0.1.0'
    s.summary          = 'A short description of InfnoteChain.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/Vergil Choi/InfnoteChain'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Vergil Choi' => 'gameboy0824@126.com' }
    s.source           = { :git => 'https://github.com/Vergil Choi/InfnoteChain.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.swift_version = '4.2'
    s.ios.deployment_target = '11.0'

    s.source_files = 'InfnoteChain/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'InfnoteChain' => ['InfnoteChain/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'RealmSwift'
    s.dependency 'Starscream'

    s.pod_target_xcconfig = {
#        'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES',
#        'APPLICATION_EXTENSION_API_ONLY' => 'YES',
        'SWIFT_INCLUDE_PATHS' => '"${PODS_ROOT}/../../InfnoteChain/Libraries/**" "${PODS_ROOT}/../../InfnoteChain/Classes/secp256k1/*"',
        'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/../../InfnoteChain/Libraries/openssl/include" "${PODS_ROOT}/../../InfnoteChain/Libraries/secp256k1/include"',
        'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/../../InfnoteChain/Libraries/openssl/lib" "${PODS_ROOT}/../../InfnoteChain/Libraries/secp256k1/lib"'
    }

    s.preserve_paths = ['setup', 'Libraries']
#    s.prepare_command = 'sh setup/build_libraries.sh'
end
