//
//  SecurityConfigDatasource.swift
//  SecurityUpdate
//
//  Created by balachandran on 24/08/23.
//

import Foundation

enum ValueKey: String {
    case app_config_json
}

@objcMembers
@objc public class RemoteConfigDatasource: NSObject {
    
    public static let shared = RemoteConfigDatasource()
    
    var securityConfig: SecurityConfig?
    
    public var forcePasswordUpdateInterval: String {
        return self.securityConfig?.security.interval ?? "7"
    }
    
    public var isForcePasswordUpdateTurnedOff: Bool {
        return self.securityConfig?.security.isTurnedOff ?? false
    }
    
    public var isLaterEnabled: Bool {
        return self.securityConfig?.security.isLaterAllowed ?? true
    }
    
    private override init() {
        super.init()
    }
    
    public func fetchCloudValues(_ callback: @escaping ()->Void) {
        
        AppRemoteConfigService().fetchRemoteConfigurations { [weak self] result in
            
            switch result {
                
            case .success(let appInfo):
                // Success
                self?.securityConfig = appInfo
                // Switch to main thread and execute the closure
                DispatchQueue.main.async {
                   callback()
                }

            case .failure(let error):
                // Failure
                print(error)
            }
        }
    }
}

