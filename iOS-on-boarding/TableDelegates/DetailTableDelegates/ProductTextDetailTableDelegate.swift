//
// ProductTextDetailTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import UIKit
import SAPOData
import SAPCommon

class ProductTextDetailTableDelegate: NSObject, DetailTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    private var _entity: ProductText?
    var entity: EntityValue {
        get {
            if _entity == nil {
                _entity = createEntityWithDefaultValues()
            }
            return _entity!
        }
        set {
            _entity = newValue as? ProductText
        }
    }
    var rightBarButton: UIBarButtonItem
    private var validity = Array(repeating: true, count: 6)

    init(dataAccess: ESPMContainerDataAccess, rightBarButton: UIBarButtonItem) {
        self.dataAccess = dataAccess
        self.rightBarButton = rightBarButton
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentEntity = self.entity as? ProductText else {
            return cellForDefault(tableView: tableView, indexPath: indexPath)
        }
        switch indexPath.row {
        case 0:
            var value = ""
            if currentEntity.hasDataValue(for: ProductText.id) {
                value = "\(currentEntity.id)"
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.id, value: value, changeHandler: { (newValue: String) -> Bool in
                if let validValue = TypeValidator.validInt64(from: newValue) {
                    currentEntity.id = validValue
                    self.validity[0] = true
                } else {
                    self.validity[0] = false
                }
                self.barButtonShouldBeEnabled()
                return self.validity[0]
            })
        case 1:
            var value = ""
            if currentEntity.hasDataValue(for: ProductText.language) {
                if let language = currentEntity.language {
                    value = "\(language)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.language, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.language = nil
                    self.validity[1] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: ProductText.language) {
                        currentEntity.language = validValue
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
            if currentEntity.hasDataValue(for: ProductText.longDescription) {
                if let longDescription = currentEntity.longDescription {
                    value = "\(longDescription)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.longDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.longDescription = nil
                    self.validity[2] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: ProductText.longDescription) {
                        currentEntity.longDescription = validValue
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
            if currentEntity.hasDataValue(for: ProductText.name) {
                if let name = currentEntity.name {
                    value = "\(name)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.name, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.name = nil
                    self.validity[3] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: ProductText.name) {
                        currentEntity.name = validValue
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
            if currentEntity.hasDataValue(for: ProductText.productID) {
                if let productID = currentEntity.productID {
                    value = "\(productID)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.productID, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.productID = nil
                    self.validity[4] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: ProductText.productID) {
                        currentEntity.productID = validValue
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
            if currentEntity.hasDataValue(for: ProductText.shortDescription) {
                if let shortDescription = currentEntity.shortDescription {
                    value = "\(shortDescription)"
                }
            }
            return cellForProperty(tableView: tableView, indexPath: indexPath, property: ProductText.shortDescription, value: value, changeHandler: { (newValue: String) -> Bool in
                // The property is optional, so nil value can be accepted
                if newValue.isEmpty {
                    currentEntity.shortDescription = nil
                    self.validity[5] = true
                } else {
                    if let validValue = TypeValidator.validString(from: newValue, for: ProductText.shortDescription) {
                        currentEntity.shortDescription = validValue
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

    func createEntityWithDefaultValues() -> ProductText {
        let newEntity = ProductText()
        newEntity.id = defaultValueFor(ProductText.id)
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
