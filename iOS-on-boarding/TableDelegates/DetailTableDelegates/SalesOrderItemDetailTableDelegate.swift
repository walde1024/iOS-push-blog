//
// SalesOrderItemDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class SalesOrderItemDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: SalesOrderItem?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? SalesOrderItem
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 10)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? SalesOrderItem else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.currencyCode) {
                if let currencyCode = currentEntity.currencyCode {
                    value = "\(currencyCode)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.currencyCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.currencyCode = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderItem.currencyCode) {
                        currentEntity.currencyCode = validValue
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
            if currentEntity.hasDataValue(for: SalesOrderItem.deliveryDate) {
                if let deliveryDate = currentEntity.deliveryDate {
                    value = "\(deliveryDate)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.deliveryDate, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.deliveryDate = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.deliveryDate = validValue
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
            if currentEntity.hasDataValue(for: SalesOrderItem.grossAmount) {
                if let grossAmount = currentEntity.grossAmount {
                    value = "\(grossAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.grossAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.grossAmount = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.grossAmount = validValue
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
            if currentEntity.hasDataValue(for: SalesOrderItem.itemNumber) {
                value = "\(currentEntity.itemNumber)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.itemNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validInteger(from: newValue) {
                    currentEntity.itemNumber = validValue
                    self.validity[3] = true
                } else {
                    self.validity[3] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[3]
            })
        case 4:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.salesOrderID) {
                value = "\(currentEntity.salesOrderID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.salesOrderID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderItem.salesOrderID) {
                    currentEntity.salesOrderID = validValue
                    self.validity[4] = true
                } else {
                    self.validity[4] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.netAmount) {
                if let netAmount = currentEntity.netAmount {
                    value = "\(netAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.netAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.netAmount = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.netAmount = validValue
                        self.validity[5] = true
                    } else {
                        self.validity[5] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        case 6:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.productID) {
                if let productID = currentEntity.productID {
                    value = "\(productID)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.productID = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderItem.productID) {
                        currentEntity.productID = validValue
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
            if currentEntity.hasDataValue(for: SalesOrderItem.quantity) {
                if let quantity = currentEntity.quantity {
                    value = "\(quantity)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.quantity, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantity = nil
                    self.validity[7] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.quantity = validValue
                        self.validity[7] = true
                    } else {
                        self.validity[7] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[7]
            })
        case 8:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.quantityUnit) {
                if let quantityUnit = currentEntity.quantityUnit {
                    value = "\(quantityUnit)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.quantityUnit, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantityUnit = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: SalesOrderItem.quantityUnit) {
                        currentEntity.quantityUnit = validValue
                        self.validity[8] = true
                    } else {
                        self.validity[8] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[8]
            })
        case 9:
            var value = ""
            if currentEntity.hasDataValue(for: SalesOrderItem.taxAmount) {
                if let taxAmount = currentEntity.taxAmount {
                    value = "\(taxAmount)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: SalesOrderItem.taxAmount, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.taxAmount = nil
                    self.validity[9] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.taxAmount = validValue
                        self.validity[9] = true
                    } else {
                        self.validity[9] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[9]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> SalesOrderItem {
        let newEntity = SalesOrderItem()
        newEntity.itemNumber = defaultValueFor(SalesOrderItem.itemNumber)
        newEntity.salesOrderID = defaultValueFor(SalesOrderItem.salesOrderID)
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
