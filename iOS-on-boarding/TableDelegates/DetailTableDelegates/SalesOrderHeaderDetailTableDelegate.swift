//
// SalesOrderHeaderDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class SalesOrderHeaderDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: SalesOrderHeader?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? SalesOrderHeader
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 9)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? SalesOrderHeader else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.createdAt) {
                if let createdAt = currentEntity.createdAt {
                    value = "\(createdAt)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.createdAt, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.createdAt = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.createdAt = validValue
                        self.validity[0] = true
                    } else {
                        self.validity[0] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.currencyCode) {
                if let currencyCode = currentEntity.currencyCode {
                    value = "\(currencyCode)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.currencyCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.currencyCode = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderHeader.currencyCode) {
                        currentEntity.currencyCode = validValue
                        self.validity[1] = true
                    } else {
                        self.validity[1] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[1]
            })
        case 2:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.customerID) {
                if let customerID = currentEntity.customerID {
                    value = "\(customerID)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.customerID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.customerID = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderHeader.customerID) {
                        currentEntity.customerID = validValue
                        self.validity[2] = true
                    } else {
                        self.validity[2] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[2]
            })
        case 3:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.grossAmount) {
                if let grossAmount = currentEntity.grossAmount {
                    value = "\(grossAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.grossAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.grossAmount = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.grossAmount = validValue
                        self.validity[3] = true
                    } else {
                        self.validity[3] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.lifeCycleStatus) {
                value = "\(currentEntity.lifeCycleStatus)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.lifeCycleStatus, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderHeader.lifeCycleStatus) {
                    currentEntity.lifeCycleStatus = validValue
                    self.validity[4] = true
                } else {
                    self.validity[4] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.lifeCycleStatusName) {
                value = "\(currentEntity.lifeCycleStatusName)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.lifeCycleStatusName, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderHeader.lifeCycleStatusName) {
                    currentEntity.lifeCycleStatusName = validValue
                    self.validity[5] = true
                } else {
                    self.validity[5] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        case 6:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.netAmount) {
                if let netAmount = currentEntity.netAmount {
                    value = "\(netAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.netAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.netAmount = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.netAmount = validValue
                        self.validity[6] = true
                    } else {
                        self.validity[6] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[6]
            })
        case 7:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.salesOrderID) {
                value = "\(currentEntity.salesOrderID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.salesOrderID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderHeader.salesOrderID) {
                    currentEntity.salesOrderID = validValue
                    self.validity[7] = true
                } else {
                    self.validity[7] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[7]
            })
        case 8:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderHeader.taxAmount) {
                if let taxAmount = currentEntity.taxAmount {
                    value = "\(taxAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderHeader.taxAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.taxAmount = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.taxAmount = validValue
                        self.validity[8] = true
                    } else {
                        self.validity[8] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[8]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> SalesOrderHeader {
        let newEntity = SalesOrderHeader()
        newEntity.lifeCycleStatus = defaultValueFor(SalesOrderHeader.lifeCycleStatus)
        newEntity.lifeCycleStatusName = defaultValueFor(SalesOrderHeader.lifeCycleStatusName)
        newEntity.salesOrderID = defaultValueFor(SalesOrderHeader.salesOrderID)
        return newEntity
    }

    // Check if all text fields are valid
    private func barButtonShouldBeEnabled() {
        let anyFieldInvalid = self.validity.first { (field) -> Bool in
            return field == false
        }
        self.rightBarButton.isEnabled = anyFieldInvalid == nil
    }
}
