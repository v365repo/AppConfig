//
//  FirebaseRemoteConfigService.swift
//  SecurityUpdate
//
//  Created by balachandran on 24/08/23.
//

import Foundation
import Firebase

final class AppRemoteConfigService: NSObject {
    
    typealias Handler = (Result<SecurityConfig, Error>) -> Void
    
    func fetchRemoteConfigurations(completionHandler: @escaping Handler) {
        
        // WARNING: Only for debug
        activateDebugMode()
        
        RemoteConfig.remoteConfig().fetch { status, error in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
                
                let value = RemoteConfig.remoteConfig().configValue(forKey: ValueKey.app_config_json.rawValue)

                do {
                    let appInfo = try JSONDecoder().decode(AppRemoteConfig.self, from: value.dataValue).agsense
                    completionHandler(.success(appInfo))
                } catch {
                    print("Failed to decode JSON")
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    private func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Only for debug
        settings.minimumFetchInterval = 0
        //settings.minimumFetchInterval = 43200
        RemoteConfig.remoteConfig().configSettings = settings
    }
}
