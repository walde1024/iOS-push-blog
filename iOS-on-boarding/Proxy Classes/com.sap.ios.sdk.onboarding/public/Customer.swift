// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class Customer: EntityValue {
    public static let city: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "City")

    public static let country: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "Country")

    public static let customerID: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "CustomerId")

    public static let dateOfBirth: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "DateOfBirth")

    public static let emailAddress: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "EmailAddress")

    public static let firstName: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "FirstName")

    public static let houseNumber: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "HouseNumber")

    public static let lastName: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "LastName")

    public static let phoneNumber: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "PhoneNumber")

    public static let postalCode: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "PostalCode")

    public static let street: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "Street")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.customer.property(withName: "UpdatedTimestamp")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.customer)
    }

    open class func array(from: EntityValueList) -> Array<Customer> {
        return ArrayConverter.convert(from.toArray(), Array<Customer>())
    }

    open var city: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.city))
        }
        set(value) {
            self.setDataValue(for: Customer.city, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> Customer {
        return CastRequired<Customer>.from(self.copyEntity())
    }

    open var country: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.country))
        }
        set(value) {
            self.setDataValue(for: Customer.country, to: StringValue.of(optional: value))
        }
    }

    open var customerID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: Customer.customerID))
        }
        set(value) {
            self.setDataValue(for: Customer.customerID, to: StringValue.of(value))
        }
    }

    open var dateOfBirth: LocalDateTime {
        get {
            return LocalDateTime.castRequired(self.dataValue(for: Customer.dateOfBirth))
        }
        set(value) {
            self.setDataValue(for: Customer.dateOfBirth, to: value)
        }
    }

    open var emailAddress: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.emailAddress))
        }
        set(value) {
            self.setDataValue(for: Customer.emailAddress, to: StringValue.of(optional: value))
        }
    }

    open var firstName: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.firstName))
        }
        set(value) {
            self.setDataValue(for: Customer.firstName, to: StringValue.of(optional: value))
        }
    }

    open var houseNumber: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.houseNumber))
        }
        set(value) {
            self.setDataValue(for: Customer.houseNumber, to: StringValue.of(optional: value))
        }
    }

    open class func key(customerID: String) -> EntityKey {
        return EntityKey().with(name: "CustomerId", value: StringValue.of(customerID))
    }

    open var lastName: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.lastName))
        }
        set(value) {
            self.setDataValue(for: Customer.lastName, to: StringValue.of(optional: value))
        }
    }

    open var old: Customer {
        get {
            return CastRequired<Customer>.from(self.oldEntity)
        }
    }

    open var phoneNumber: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.phoneNumber))
        }
        set(value) {
            self.setDataValue(for: Customer.phoneNumber, to: StringValue.of(optional: value))
        }
    }

    open var postalCode: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.postalCode))
        }
        set(value) {
            self.setDataValue(for: Customer.postalCode, to: StringValue.of(optional: value))
        }
    }

    open var street: String? {
        get {
            return StringValue.optional(self.dataValue(for: Customer.street))
        }
        set(value) {
            self.setDataValue(for: Customer.street, to: StringValue.of(optional: value))
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.dataValue(for: Customer.updatedTimestamp))
        }
        set(value) {
            self.setDataValue(for: Customer.updatedTimestamp, to: value)
        }
    }
}
