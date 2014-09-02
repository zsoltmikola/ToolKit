Pod::Spec.new do |s|
  s.name         = "ToolKit"
  s.version      = "0.1.3"
  s.summary      = "A toolkit for iOS"
  s.homepage     = "https://github.com/zsoltmikola/ToolKit"
  s.license      = "Apache v2 License"
  s.author       = "zsoltmikola"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/zsoltmikola/ToolKit.git", :tag => "0.1.3" }
  s.source_files  = 'ToolKit/ToolKit.h'
  s.requires_arc = true
  
  s.subspec 'Multithreading' do |ss|
  	ss.source_files = 'ToolKit/TKMultithreading.{h,m}'
  end
  
end
