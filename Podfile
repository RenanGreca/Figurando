platform :ios, '8.0'
use_frameworks!

pod "SwiftyJSON", ">= 2.2"
pod "PNChart"

target 'Psico-Kids' do
    
    
end

target 'Psico-KidsTests' do
    
    
end

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        if target.to_s.include? 'Pods'
            target.build_configurations.each do |config|
                if !config.to_s.include? 'Debug'
                    config.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'iPhone Distribution'
                end
            end
        end
    end
end