Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "0.9.9"
  s.summary      = "NetworkEye - a iOS network debug library ,It can monitor HTTP requests within the App and displays information related to the request."
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :tag => "0.9.9" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.library = "sqlite3"
  s.platform     = :ios, '7.0'
  s.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  s.requires_arc = true
  
  s.dependency "FMDB/SQLCipher", "~> 2.5"



 

end