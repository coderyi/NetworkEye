Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.0"
  s.summary      = "NetworkEye - 监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。"
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :commit => "bbc167dc29514f84e4c8a6207c074827d44e8eeb" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit', 'libsqlite3.0'
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true

end