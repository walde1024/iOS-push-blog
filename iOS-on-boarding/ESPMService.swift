//
//  ESPMService.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 20.07.17.
//  Copyright © 2017 SAP. All rights reserved.
//

import SAPFiori
import SAPFoundation
import SAPOfflineOData
import SAPOData

class ESPMService: SAPURLSessionDelegate {
    
    static let shared: ESPMService = ESPMService()
    
    private var username: String?
    private var password: String?
    
    public var deviceToken: Data?
    private var remoteNotificationClient: SAPcpmsRemoteNotificationClient!
    
    public var espmContainer: ESPMContainerDataAccess!
    
    private var urlSession: SAPURLSession! {
        didSet {
            self.espmContainer = ESPMContainerDataAccess(urlSession: urlSession)
            sendDeviceTokenToSAPCPms()
        }
    }
    
    private init() {
        
    }
    
    // MARK: - Push Configuration
    
    func sendDeviceTokenToSAPCPms() -> Void {
        guard let deviceToken = self.deviceToken else {
            // Device token has not been acquired
            return
        }
        
        self.remoteNotificationClient = SAPcpmsRemoteNotificationClient(sapURLSession: ESPMService.shared.urlSession, settingsParameters: Constants.configurationParameters)
        self.remoteNotificationClient.registerDeviceToken(deviceToken) { error in
            if let error = error {
                print("Register DeviceToken failed Error: \(error.localizedDescription)")
                return
            }
            print("Register DeviceToken succeeded")
        }
    }
    
    // MARK: - Basic Authentication
    
    func performBasicAuthentication(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        self.username = username
        self.password = password
        
        let sapUrlSession = SAPURLSession(delegate: self)
        sapUrlSession.register(SAPcpmsObserver(settingsParameters: Constants.configurationParameters))
        
        var request = URLRequest(url: Constants.appUrl)
        request.httpMethod = "GET"
        
        let dataTask = sapUrlSession.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let message: String
                
                if let error = error {
                    print("Error while basic authentication: \(error)")
                    message = error.localizedDescription
                } else {
                    message = "Check your credentials!"
                }
                
                DispatchQueue.main.async {
                    completion(false, message)
                }
                
                return
            }
            
            print("Response returned: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
            
            // We should check if we got SAML challenge from the server or not
            if self.isSAMLChallenge(response) {
                print("Logon process failure. It seems you got SAML authentication challenge.")
                
                let message = "Logon process failure. It seems you got SAML authentication challenge."
                
                DispatchQueue.main.async {
                    completion(false, message)
                }
            }
            else {
                print("Logged in successfully.")
                self.urlSession = sapUrlSession
                
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        completion(true, nil)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func isSAMLChallenge(_ response: HTTPURLResponse) -> Bool {
        return response.statusCode == 200 && ((response.allHeaderFields["com.sap.cloud.security.login"]) != nil)
    }
    
    // MARK: - SAPURLSessionDelegate
    
    func sapURLSession(_ session: SAPURLSession, task: SAPURLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping(SAPURLSession.AuthChallengeDisposition) -> Void) {
        if challenge.previousFailureCount > 0 {
            completionHandler(.performDefaultHandling)
            return
        }
        
        let credential = URLCredential(user: self.username!, password: self.password!, persistence: .forSession)
        completionHandler(.use(credential))
    }
    
}
