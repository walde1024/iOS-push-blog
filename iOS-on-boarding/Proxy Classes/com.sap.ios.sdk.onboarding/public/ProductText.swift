// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class ProductText: EntityValue {
    public static let id: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "Id")

    public static let language: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "Language")

    public static let longDescription: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "LongDescription")

    public static let name: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "Name")

    public static let productID: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "ProductId")

    public static let shortDescription: Property = ESPMContainerMetadata.EntityTypes.productText.property(withName: "ShortDescription")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.productText)
    }

    open class func array(from: EntityValueList) -> Array<ProductText> {
        return ArrayConverter.convert(from.toArray(), Array<ProductText>())
    }

    open func copy() -> ProductText {
        return CastRequired<ProductText>.from(self.copyEntity())
    }

    open var id: Int64 {
        get {
            return LongValue.unwrap(self.dataValue(for: ProductText.id))
        }
        set(value) {
            self.setDataValue(for: ProductText.id, to: LongValue.of(value))
        }
    }

    open class func key(id: Int64) -> EntityKey {
        return EntityKey().with(name: "Id", value: LongValue.of(id))
    }

    open var language: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductText.language))
        }
        set(value) {
            self.setDataValue(for: ProductText.language, to: StringValue.of(optional: value))
        }
    }

    open var longDescription: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductText.longDescription))
        }
        set(value) {
            self.setDataValue(for: ProductText.longDescription, to: StringValue.of(optional: value))
        }
    }

    open var name: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductText.name))
        }
        set(value) {
            self.setDataValue(for: ProductText.name, to: StringValue.of(optional: value))
        }
    }

    open var old: ProductText {
        get {
            return CastRequired<ProductText>.from(self.oldEntity)
        }
    }

    open var productID: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductText.productID))
        }
        set(value) {
            self.setDataValue(for: ProductText.productID, to: StringValue.of(optional: value))
        }
    }

    open var shortDescription: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductText.shortDescription))
        }
        set(value) {
            self.setDataValue(for: ProductText.shortDescription, to: StringValue.of(optional: value))
        }
    }
}
