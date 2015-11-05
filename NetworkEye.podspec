Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.0"
  s.summary      = "NetworkEye - 监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。"
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :commit => "1627b9d6020ef031a29aeffc2a390f2d00252337" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit', 'libsqlite3.0'
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true

end