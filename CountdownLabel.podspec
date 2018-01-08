Pod::Spec.new do |s|
  s.name         = "CountdownLabel"
  s.version      = '3.0.0'
  s.summary      = 'Simple countdown UILabel with morphing animation, and some useful function.'
  s.homepage     = "https://github.com/choulex99/CountdownLabel"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "choulex99" => "claude.houle@gmail.com" }
  s.source       = { :git => "https://github.com/timonchev/CountdownLabel.git", :tag => s.version }
  s.platform     = :ios, "9.0"
  s.source_files = 'CountdownLabel/*.swift'
  s.source_files = 'CountdownLabel/**/*.swift'
  s.requires_arc = true
  s.frameworks   = "UIKit"
end
