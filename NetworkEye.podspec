Pod::Spec.new do |s|
  s.name         = "NetworkEye"
  s.version      = "1.1.0"
  s.summary      = "NetworkEye - a iOS network debug library ,It can monitor HTTP requests within the App and displays information related to the request."
  s.homepage     = "https://github.com/coderyi/NetworkEye"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/NetworkEye.git", :tag => "1.1.0" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.default_subspec = 'standard'  

  s.subspec 'standard' do |ss|
    ss.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  end

  s.subspec 'FMDB' do |ss|
    ss.library = "sqlite3"
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DFMDB_SQLCipher' }
    ss.dependency "FMDB/SQLCipher", "~> 2.5"
    ss.source_files = 'NetworkEye/NetworkEye/**/*.{h,m,png}'
  end


 

end