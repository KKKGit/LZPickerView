
Pod::Spec.new do |s|

  s.name          = "LZPickerView"
  s.version       = "0.1.3"
  s.summary       = "LZPickerView"
  s.description   = <<-DESC
                    Easy to use a PickerView like WeChat.
                    DESC

  s.homepage      = "https://github.com/KKKGit/LZPickerView"
  s.license       = { :type => "MIT" }
  s.author        = { "LLZ" => "lvboyv@sohu.com" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/KKKGit/LZPickerView.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "LZPickerView/LZPickerView.{h,m}"
  s.resources     = ["LZPickerView/**/*.xib" ,"LZPickerView/.lproj"]

  s.framework     = "UIKit"
  s.requires_arc  = true


end
