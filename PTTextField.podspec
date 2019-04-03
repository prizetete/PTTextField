Pod::Spec.new do |s|
  s.name             = 'PTTextField'
  s.version          = '0.1.0'
  s.summary          = 'PTTextField is TextField With Label'


  s.description      = "Create MyCustomTextField With Label Over TextField"

  s.homepage         = 'https://github.com/prizetete/PTTextField'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'prizetete' => 'prizetete1212@gmail.com' }
  s.source           = { :git => 'https://github.com/prizetete/PTTextField.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'PTTextField/Classes/**/*'
  
end
