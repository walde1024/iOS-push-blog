//
// StockDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class StockDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: Stock?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? Stock
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 6)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? Stock else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: Stock.lotSize) {
                if let lotSize = currentEntity.lotSize {
                    value = "\(lotSize)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.lotSize, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.lotSize = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.lotSize = validValue
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
            if currentEntity.hasDataValue(for: Stock.minStock) {
                if let minStock = currentEntity.minStock {
                    value = "\(minStock)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.minStock, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.minStock = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.minStock = validValue
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
            if currentEntity.hasDataValue(for: Stock.productID) {
                value = "\(currentEntity.productID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: Stock.productID) {
                    currentEntity.productID = validValue
                    self.validity[2] = true
                } else {
                    self.validity[2] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[2]
            })
        case 3:
            var value = ""
            if currentEntity.hasDataValue(for: Stock.quantity) {
                if let quantity = currentEntity.quantity {
                    value = "\(quantity)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.quantity, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantity = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.quantity = validValue
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
            if currentEntity.hasDataValue(for: Stock.quantityLessMin) {
                if let quantityLessMin = currentEntity.quantityLessMin {
                    value = "\(quantityLessMin)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.quantityLessMin, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantityLessMin = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validBoolean(from: newValue) {
                        currentEntity.quantityLessMin = validValue
                        self.validity[4] = true
                    } else {
                        self.validity[4] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[4]
            })
        case 5:
            var value = ""
            if currentEntity.hasDataValue(for: Stock.updatedTimestamp) {
                if let updatedTimestamp = currentEntity.updatedTimestamp {
                    value = "\(updatedTimestamp)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Stock.updatedTimestamp, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.updatedTimestamp = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.updatedTimestamp = validValue
                        self.validity[5] = true
                    } else {
                        self.validity[5] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[5]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> Stock {
        let newEntity = Stock()
        newEntity.productID = defaultValueFor(Stock.productID)
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
