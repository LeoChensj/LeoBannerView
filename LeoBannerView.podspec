Pod::Spec.new do |s|

  s.name         = "LeoBannerView"
  s.version      = "1.0"
  s.summary      = "Banner"
  s.description  = <<-DESC
                   广告横幅、多图滚动
                   DESC

  s.homepage     = "https://github.com/LeoChensj/LeoBannerView"
  s.license      = "MIT"
  s.author       = { "LeoChen" => "LeoChensj@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LeoChensj/LeoBannerView.git", :tag => "#{s.version}" }
  s.source_files = "LeoBannerView/*.{h,m}"
  s.public_header_files = "LeoBannerView/LeoBannerView.h"
  s.requires_arc = true
  s.dependency "SDWebImage"

end
