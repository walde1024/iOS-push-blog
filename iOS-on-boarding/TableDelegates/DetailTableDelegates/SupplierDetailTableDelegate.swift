//
// SupplierDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class SupplierDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: Supplier?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? Supplier
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 10)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? Supplier else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: Supplier.city) {
                if let city = currentEntity.city {
                    value = "\(city)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.city, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.city = nil
                    self.validity[0] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.city) {
                        currentEntity.city = validValue
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
            if currentEntity.hasDataValue(for: Supplier.country) {
                if let country = currentEntity.country {
                    value = "\(country)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.country, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.country = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.country) {
                        currentEntity.country = validValue
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
            if currentEntity.hasDataValue(for: Supplier.emailAddress) {
                if let emailAddress = currentEntity.emailAddress {
                    value = "\(emailAddress)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.emailAddress, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.emailAddress = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.emailAddress) {
                        currentEntity.emailAddress = validValue
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
            if currentEntity.hasDataValue(for: Supplier.houseNumber) {
                if let houseNumber = currentEntity.houseNumber {
                    value = "\(houseNumber)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.houseNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.houseNumber = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.houseNumber) {
                        currentEntity.houseNumber = validValue
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
            if currentEntity.hasDataValue(for: Supplier.phoneNumber) {
                if let phoneNumber = currentEntity.phoneNumber {
                    value = "\(phoneNumber)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.phoneNumber, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.phoneNumber = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.phoneNumber) {
                        currentEntity.phoneNumber = validValue
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
            if currentEntity.hasDataValue(for: Supplier.postalCode) {
                if let postalCode = currentEntity.postalCode {
                    value = "\(postalCode)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.postalCode, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.postalCode = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.postalCode) {
                        currentEntity.postalCode = validValue
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
            if currentEntity.hasDataValue(for: Supplier.street) {
                if let street = currentEntity.street {
                    value = "\(street)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.street, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.street = nil
                    self.validity[6] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.street) {
                        currentEntity.street = validValue
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
            if currentEntity.hasDataValue(for: Supplier.supplierID) {
                value = "\(currentEntity.supplierID)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.supplierID, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validString(from: newValue, for: Supplier.supplierID) {
                    currentEntity.supplierID = validValue
                    self.validity[7] = true
                } else {
                    self.validity[7] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[7]
            })
        case 8:
            var value = ""
            if currentEntity.hasDataValue(for: Supplier.supplierName) {
                if let supplierName = currentEntity.supplierName {
                    value = "\(supplierName)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.supplierName, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.supplierName = nil
                    self.validity[8] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: Supplier.supplierName) {
                        currentEntity.supplierName = validValue
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
            if currentEntity.hasDataValue(for: Supplier.updatedTimestamp) {
                if let updatedTimestamp = currentEntity.updatedTimestamp {
                    value = "\(updatedTimestamp)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: Supplier.updatedTimestamp, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.updatedTimestamp = nil
                    self.validity[9] = true
                } else {
                    if let validValue = TypeValidator.validLocalDateTime(from: newValue) { // This is just a simple solution to handle UTC only
                        currentEntity.updatedTimestamp = validValue
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

    func createEntityWithDefaultValues() -> Supplier {
        let newEntity = Supplier()
        newEntity.supplierID = defaultValueFor(Supplier.supplierID)
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
