Pod::Spec.new do |s|
  s.name         = "JTSReachability"
  s.version      = "1.1.0"
  s.summary      = "Adaptation of Apple's Reachability with some block-based conveniences."
  s.homepage     = "https://github.com/jaredsinclair/JTSReachability"
  s.license      = { :type => 'MIT', :file => 'LICENSE'  }
  s.author       = { "Jared Sinclair" => "https://twitter.com/jaredsinclair" }
  s.source       = { :git => "https://github.com/jaredsinclair/JTSReachability.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks   = 'UIKit', 'SystemConfiguration'
  
  s.ios.deployment_target = '7.0'
  
  s.source_files = ['Source/*.{h,m}']
  
end
