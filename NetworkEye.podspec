Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.4"
  s.summary      = "NetworkEye - 监控App内所有HTTP请求并显示请求相关的所有信息，方便App开发的网络调试。"
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :commit => "ff8a313cccb80acaddb8bd95af951a950d6c232b" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.library = "sqlite3"
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true
  
  s.dependency "FMDB/SQLCipher", "~> 2.5"



 

end