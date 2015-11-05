Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.0"
  s.summary      = "NetworkEye - 监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。"
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :commit => "23849acc935d19623c15b39d5c854b716681b54d" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true
  s.dependency "SQLCipher", "~> 3.1.0"
  s.dependency "Aspects", "~> 1.4.1"
end