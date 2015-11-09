Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.7"
  s.summary      = "NetworkEye - iOS网络调试库，NetworkEye可以监控App内HTTP请求并显示请求相关的详细信息，方便App开发的网络调试。"
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :commit => "b36379d0e853d4cc3139130a7f689a3274db6d76" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.library = "sqlite3"
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true
  
  s.dependency "FMDB/SQLCipher", "~> 2.5"



 

end