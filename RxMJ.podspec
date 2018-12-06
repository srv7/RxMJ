Pod::Spec.new do |s|
  s.name             = 'RxMJ'
  s.version          = '0.3.0'
  s.summary          = 'MJ in Rx world'
  s.description      = <<-DESC
MJRefresh with RxCocoa
                       DESC
  s.homepage         = 'https://github.com/srv7/RxMJ'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'srv7' => 'liubo004@126.com' }
  s.source           = { :git => 'https://github.com/srv7/RxMJ.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RxMJ/Classes/**/*'
  s.swift_version = '4.2'
  s.frameworks = 'UIKit'
  s.dependency 'MJRefresh', '~> 3.1.15.7'
  s.dependency 'RxCocoa', '~> 4.3.0'
end
