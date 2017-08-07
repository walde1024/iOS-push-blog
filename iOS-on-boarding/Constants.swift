//
// Constants.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import Foundation
import SAPFoundation

struct Constants {

    static let appId = "com.sap.ios.sdk.onboarding"
    private static let sapcpmsUrlString = "https://hcpms-d056936trial.hanatrial.ondemand.com"
    static let sapcpmsUrl = URL(string: sapcpmsUrlString)!
    static let appUrl = Constants.sapcpmsUrl.appendingPathComponent(appId)
    static let configurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
}
