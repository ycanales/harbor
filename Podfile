source 'https://github.com/CocoaPods/Specs.git'

# platform
platform :osx, '10.10'
use_frameworks!

# build configuration inheritance
project 'Harbor', 'Test' => :debug

# dependencies
target 'Harbor' do
  pod 'Alamofire', '~> 3.0'
  pod 'Drip', '~> 0.1'

  target 'HarborTests' do
    pod 'Quick', '~> 0.9'
    pod 'Nimble', '~> 4.0'
  end
end
