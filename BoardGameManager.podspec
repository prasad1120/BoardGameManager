Pod::Spec.new do |s|
  s.name             = 'BoardGameManager'
  s.version          = '1.2.0'
  s.summary          = 'Helps with traversing, transformation and score calculation in board games'
  s.homepage         = 'https://github.com/prasad1120/BoardGameManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Prasad Shinde' => 'prasadshinde1120@gmail.com' }
  s.source           = { :git => 'https://github.com/prasad1120/BoardGameManager.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '12.0'
  s.source_files = 'BoardGameManager/*.swift'
  s.swift_version = "5"
 
end
