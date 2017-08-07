// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class Supplier: EntityValue {
    public static let city: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "City")

    public static let country: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Country")

    public static let emailAddress: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "EmailAddress")

    public static let houseNumber: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "HouseNumber")

    public static let phoneNumber: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "PhoneNumber")

    public static let postalCode: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "PostalCode")

    public static let street: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Street")

    public static let supplierID: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "SupplierId")

    public static let supplierName: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "SupplierName")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "UpdatedTimestamp")

    public static let products: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Products")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.supplier)
    }

    open class func array(from: EntityValueList) -> Array<Supplier> {
        return ArrayConverter.convert(from.toArray(), Array<Supplier>())
    }

    open var city: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.city))
        }
        set(value) {
            self.setDataValue(for: Supplier.city, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> Supplier {
        return CastRequired<Supplier>.from(self.copyEntity())
    }

    open var country: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.country))
        }
        set(value) {
            self.setDataValue(for: Supplier.country, to: StringValue.of(optional: value))
        }
    }

    open var emailAddress: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.emailAddress))
        }
        set(value) {
            self.setDataValue(for: Supplier.emailAddress, to: StringValue.of(optional: value))
        }
    }

    open var houseNumber: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.houseNumber))
        }
        set(value) {
            self.setDataValue(for: Supplier.houseNumber, to: StringValue.of(optional: value))
        }
    }

    open class func key(supplierID: String) -> EntityKey {
        return EntityKey().with(name: "SupplierId", value: StringValue.of(supplierID))
    }

    open var old: Supplier {
        get {
            return CastRequired<Supplier>.from(self.oldEntity)
        }
    }

    open var phoneNumber: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.phoneNumber))
        }
        set(value) {
            self.setDataValue(for: Supplier.phoneNumber, to: StringValue.of(optional: value))
        }
    }

    open var postalCode: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.postalCode))
        }
        set(value) {
            self.setDataValue(for: Supplier.postalCode, to: StringValue.of(optional: value))
        }
    }

    open var products: Array<Product> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.dataValue(for: Supplier.products)).toArray(), Array<Product>())
        }
        set(value) {
            Supplier.products.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open var street: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.street))
        }
        set(value) {
            self.setDataValue(for: Supplier.street, to: StringValue.of(optional: value))
        }
    }

    open var supplierID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: Supplier.supplierID))
        }
        set(value) {
            self.setDataValue(for: Supplier.supplierID, to: StringValue.of(value))
        }
    }

    open var supplierName: String? {
        get {
            return StringValue.optional(self.dataValue(for: Supplier.supplierName))
        }
        set(value) {
            self.setDataValue(for: Supplier.supplierName, to: StringValue.of(optional: value))
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.dataValue(for: Supplier.updatedTimestamp))
        }
        set(value) {
            self.setDataValue(for: Supplier.updatedTimestamp, to: value)
        }
    }
}
