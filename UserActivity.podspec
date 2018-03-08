Pod::Spec.new do |s|
  s.name          = "UserActivity"
  s.version       = "0.1.13"
  s.source_files  = "UserActivity.h", "UserActivity.m"
  s.author          = { "Philip Heinser" => "philipheinser@me.com" }
  s.ios.deployment_target = '8.0'
  s.license       = "MIT"
  s.summary       = "NSUserActivity for React Native"
  s.homepage      = "https://github.com/philipheinser/react-native-user-activity"
  s.source        = { :git => "https://github.com/philipheinser/react-native-user-activity.git" }

  s.dependency 'React'
end
