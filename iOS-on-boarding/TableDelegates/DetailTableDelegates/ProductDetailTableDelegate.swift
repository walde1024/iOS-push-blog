//
// ProductDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class ProductDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: Product?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? Product
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 18)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? Product else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: Product.category) {
                if let category = currentEntity.category {
                    value = "\(category)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.category, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.category = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.category) {
                        currentEntity.category = validValue
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
            if currentEntity.hasDataValue(for: Product.categoryName) {
                if let categoryName = currentEntity.categoryName {
                    value = "\(categoryName)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.categoryName, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.categoryName = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.categoryName) {
                        currentEntity.categoryName = validValue
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
            if currentEntity.hasDataValue(for: Product.currencyCode) {
                if let currencyCode = currentEntity.currencyCode {
                    value = "\(currencyCode)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.currencyCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.currencyCode = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.currencyCode) {
                        currentEntity.currencyCode = validValue
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
            if currentEntity.hasDataValue(for: Product.dimensionDepth) {
                if let dimensionDepth = currentEntity.dimensionDepth {
                    value = "\(dimensionDepth)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.dimensionDepth, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.dimensionDepth = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.dimensionDepth = validValue
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
            if currentEntity.hasDataValue(for: Product.dimensionHeight) {
                if let dimensionHeight = currentEntity.dimensionHeight {
                    value = "\(dimensionHeight)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.dimensionHeight, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.dimensionHeight = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.dimensionHeight = validValue
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
            if currentEntity.hasDataValue(for: Product.dimensionUnit) {
                if let dimensionUnit = currentEntity.dimensionUnit {
                    value = "\(dimensionUnit)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.dimensionUnit, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.dimensionUnit = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.dimensionUnit) {
                        currentEntity.dimensionUnit = validValue
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
            if currentEntity.hasDataValue(for: Product.dimensionWidth) {
                if let dimensionWidth = currentEntity.dimensionWidth {
                    value = "\(dimensionWidth)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.dimensionWidth, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.dimensionWidth = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.dimensionWidth = validValue
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
            if currentEntity.hasDataValue(for: Product.longDescription) {
                if let longDescription = currentEntity.longDescription {
                    value = "\(longDescription)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.longDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.longDescription = nil
                    self.validity[7] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.longDescription) {
                        currentEntity.longDescription = validValue
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
            if currentEntity.hasDataValue(for: Product.name) {
                if let name = currentEntity.name {
                    value = "\(name)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.name, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.name = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.name) {
                        currentEntity.name = validValue
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
            if currentEntity.hasDataValue(for: Product.pictureUrl) {
                if let pictureUrl = currentEntity.pictureUrl {
                    value = "\(pictureUrl)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.pictureUrl, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.pictureUrl = nil
                    self.validity[9] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.pictureUrl) {
                        currentEntity.pictureUrl = validValue
                        self.validity[9] = true
                    } else {
                        self.validity[9] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[9]
            })
        case 10:
            var value = ""
            if currentEntity.hasDataValue(for: Product.price) {
                if let price = currentEntity.price {
                    value = "\(price)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.price, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.price = nil
                    self.validity[10] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.price = validValue
                        self.validity[10] = true
                    } else {
                        self.validity[10] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[10]
            })
        case 11:
            var value = ""
            if currentEntity.hasDataValue(for: Product.productID) {
                value = "\(currentEntity.productID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: Product.productID) {
                    currentEntity.productID = validValue
                    self.validity[11] = true
                } else {
                    self.validity[11] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[11]
            })
        case 12:
            var value = ""
            if currentEntity.hasDataValue(for: Product.quantityUnit) {
                if let quantityUnit = currentEntity.quantityUnit {
                    value = "\(quantityUnit)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.quantityUnit, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.quantityUnit = nil
                    self.validity[12] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.quantityUnit) {
                        currentEntity.quantityUnit = validValue
                        self.validity[12] = true
                    } else {
                        self.validity[12] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[12]
            })
        case 13:
            var value = ""
            if currentEntity.hasDataValue(for: Product.shortDescription) {
                if let shortDescription = currentEntity.shortDescription {
                    value = "\(shortDescription)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.shortDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.shortDescription = nil
                    self.validity[13] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.shortDescription) {
                        currentEntity.shortDescription = validValue
                        self.validity[13] = true
                    } else {
                        self.validity[13] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[13]
            })
        case 14:
            var value = ""
            if currentEntity.hasDataValue(for: Product.supplierID) {
                if let supplierID = currentEntity.supplierID {
                    value = "\(supplierID)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.supplierID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.supplierID = nil
                    self.validity[14] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.supplierID) {
                        currentEntity.supplierID = validValue
                        self.validity[14] = true
                    } else {
                        self.validity[14] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[14]
            })
        case 15:
            var value = ""
            if currentEntity.hasDataValue(for: Product.updatedTimestamp) {
                if let updatedTimestamp = currentEntity.updatedTimestamp {
                    value = "\(updatedTimestamp)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.updatedTimestamp, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.updatedTimestamp = nil
                    self.validity[15] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.updatedTimestamp = validValue
                        self.validity[15] = true
                    } else {
                        self.validity[15] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[15]
            })
        case 16:
            var value = ""
            if currentEntity.hasDataValue(for: Product.weight) {
                if let weight = currentEntity.weight {
                    value = "\(weight)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.weight, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.weight = nil
                    self.validity[16] = true
                } else {
                    if let validValue = TypeValidator.validBigDecimal(from: newValue) {
                        currentEntity.weight = validValue
                        self.validity[16] = true
                    } else {
                        self.validity[16] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[16]
            })
        case 17:
            var value = ""
            if currentEntity.hasDataValue(for: Product.weightUnit) {
                if let weightUnit = currentEntity.weightUnit {
                    value = "\(weightUnit)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Product.weightUnit, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.weightUnit = nil
                    self.validity[17] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Product.weightUnit) {
                        currentEntity.weightUnit = validValue
                        self.validity[17] = true
                    } else {
                        self.validity[17] = false
                    }
                }
                self.barButtonShouldBeEnabled()
                return self.validity[17]
            })
        default:
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func createEntityWithDefaultValues() -> Product {
        let newEntity = Product()
        newEntity.productID = defaultValueFor(Product.productID)
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
