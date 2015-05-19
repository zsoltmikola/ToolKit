Pod::Spec.new do |s|
  s.name         = "ToolKit"
  s.version      = "0.12.4"
  s.summary      = "A toolkit for iOS"
  s.homepage     = "https://github.com/zsoltmikola/ToolKit"
  s.license      = "Apache v2 License"
  s.author       = "zsoltmikola"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/zsoltmikola/ToolKit.git", :tag => "0.12.4" }
  s.source_files  = 'ToolKit/ToolKit.h'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  
  s.subspec 'Multithreading' do |ss|
  	ss.source_files = 'ToolKit/Multithreading/*.{h,m}'
  end
  
  s.subspec 'DependencyInjection' do |ss|
  	ss.source_files = 'ToolKit/TKDependencyInjector.{h,m}'
  end
  
  s.subspec 'PListManager' do |ss|
  	ss.source_files = 'ToolKit/TKPListManager.{h,m}'
  end
  
  s.subspec 'Extensions' do |ss|
  	ss.source_files = 'ToolKit/Extensions/*.{h,m}'
  end
  
  s.subspec 'Cache' do |ss|
  ss.dependency 'ToolKit/Multithreading'
  ss.dependency 'ToolKit/Extensions'
   	ss.source_files = 'ToolKit/Cache/*.{h,m}'
  end
  
  s.subspec 'Builders' do |ss|
  	ss.source_files = 'ToolKit/Builders/*.{h,m}'
  end
  
  #  s.subspec 'Logging' do |ss|
  #	ss.dependency 'ToolKit/Multithreading'
  #  	ss.source_files = 'ToolKit/Logging/*.{h,m}'
  #  end
end
