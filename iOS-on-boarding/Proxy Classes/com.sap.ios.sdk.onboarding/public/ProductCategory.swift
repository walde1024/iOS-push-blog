// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class ProductCategory: EntityValue {
    public static let category: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "Category")

    public static let categoryName: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "CategoryName")

    public static let mainCategory: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "MainCategory")

    public static let mainCategoryName: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "MainCategoryName")

    public static let numberOfProducts: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "NumberOfProducts")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "UpdatedTimestamp")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.productCategory)
    }

    open class func array(from: EntityValueList) -> Array<ProductCategory> {
        return ArrayConverter.convert(from.toArray(), Array<ProductCategory>())
    }

    open var category: String {
        get {
            return StringValue.unwrap(self.dataValue(for: ProductCategory.category))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.category, to: StringValue.of(value))
        }
    }

    open var categoryName: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductCategory.categoryName))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.categoryName, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ProductCategory {
        return CastRequired<ProductCategory>.from(self.copyEntity())
    }

    open class func key(category: String) -> EntityKey {
        return EntityKey().with(name: "Category", value: StringValue.of(category))
    }

    open var mainCategory: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductCategory.mainCategory))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.mainCategory, to: StringValue.of(optional: value))
        }
    }

    open var mainCategoryName: String? {
        get {
            return StringValue.optional(self.dataValue(for: ProductCategory.mainCategoryName))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.mainCategoryName, to: StringValue.of(optional: value))
        }
    }

    open var numberOfProducts: Int64? {
        get {
            return LongValue.optional(self.dataValue(for: ProductCategory.numberOfProducts))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.numberOfProducts, to: LongValue.of(optional: value))
        }
    }

    open var old: ProductCategory {
        get {
            return CastRequired<ProductCategory>.from(self.oldEntity)
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.dataValue(for: ProductCategory.updatedTimestamp))
        }
        set(value) {
            self.setDataValue(for: ProductCategory.updatedTimestamp, to: value)
        }
    }
}
