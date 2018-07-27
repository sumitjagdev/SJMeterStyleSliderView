
Pod::Spec.new do |s|
  s.name             = 'SJMeterStyleSliderView'
  s.version          = '0.1.0'
  s.summary          = 'Meter Style Slider Control for selecting current index on meter scale.'


  s.description      = <<-DESC
The SJMeterStyleSliderView control is a completely customisable widget that can be used in any iOS app. It also plays a little victory fanfare.
                       DESC

  s.homepage         = 'https://github.com/sumitjagdev/SJMeterStyleSliderView'
  s.screenshots     = 'https://raw.githubusercontent.com/sumitjagdev/SJMeterStyleSliderView/master/Screen1.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sumitjagdev' => 'sumitjagdev3@gmail.com' }
  s.source           = { :git => 'https://github.com/sumitjagdev/SJMeterStyleSliderView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SJMeterStyleSliderView/Classes/**/*'
  
end
