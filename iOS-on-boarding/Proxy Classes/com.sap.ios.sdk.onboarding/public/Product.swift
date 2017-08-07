// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class Product: EntityValue {
    public static let category: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "Category")

    public static let categoryName: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "CategoryName")

    public static let currencyCode: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "CurrencyCode")

    public static let dimensionDepth: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "DimensionDepth")

    public static let dimensionHeight: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "DimensionHeight")

    public static let dimensionUnit: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "DimensionUnit")

    public static let dimensionWidth: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "DimensionWidth")

    public static let longDescription: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "LongDescription")

    public static let name: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "Name")

    public static let pictureUrl: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "PictureUrl")

    public static let price: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "Price")

    public static let productID: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "ProductId")

    public static let quantityUnit: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "QuantityUnit")

    public static let shortDescription: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "ShortDescription")

    public static let supplierID: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "SupplierId")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "UpdatedTimestamp")

    public static let weight: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "Weight")

    public static let weightUnit: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "WeightUnit")

    public static let stockDetails: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "StockDetails")

    public static let supplierDetails: Property = ESPMContainerMetadata.EntityTypes.product.property(withName: "SupplierDetails")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.product)
    }

    open class func array(from: EntityValueList) -> Array<Product> {
        return ArrayConverter.convert(from.toArray(), Array<Product>())
    }

    open var category: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.category))
        }
        set(value) {
            self.setDataValue(for: Product.category, to: StringValue.of(optional: value))
        }
    }

    open var categoryName: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.categoryName))
        }
        set(value) {
            self.setDataValue(for: Product.categoryName, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> Product {
        return CastRequired<Product>.from(self.copyEntity())
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.currencyCode))
        }
        set(value) {
            self.setDataValue(for: Product.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var dimensionDepth: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: Product.dimensionDepth))
        }
        set(value) {
            self.setDataValue(for: Product.dimensionDepth, to: DecimalValue.of(optional: value))
        }
    }

    open var dimensionHeight: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: Product.dimensionHeight))
        }
        set(value) {
            self.setDataValue(for: Product.dimensionHeight, to: DecimalValue.of(optional: value))
        }
    }

    open var dimensionUnit: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.dimensionUnit))
        }
        set(value) {
            self.setDataValue(for: Product.dimensionUnit, to: StringValue.of(optional: value))
        }
    }

    open var dimensionWidth: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: Product.dimensionWidth))
        }
        set(value) {
            self.setDataValue(for: Product.dimensionWidth, to: DecimalValue.of(optional: value))
        }
    }

    open class func key(productID: String) -> EntityKey {
        return EntityKey().with(name: "ProductId", value: StringValue.of(productID))
    }

    open var longDescription: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.longDescription))
        }
        set(value) {
            self.setDataValue(for: Product.longDescription, to: StringValue.of(optional: value))
        }
    }

    open var name: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.name))
        }
        set(value) {
            self.setDataValue(for: Product.name, to: StringValue.of(optional: value))
        }
    }

    open var old: Product {
        get {
            return CastRequired<Product>.from(self.oldEntity)
        }
    }

    open var pictureUrl: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.pictureUrl))
        }
        set(value) {
            self.setDataValue(for: Product.pictureUrl, to: StringValue.of(optional: value))
        }
    }

    open var price: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: Product.price))
        }
        set(value) {
            self.setDataValue(for: Product.price, to: DecimalValue.of(optional: value))
        }
    }

    open var productID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: Product.productID))
        }
        set(value) {
            self.setDataValue(for: Product.productID, to: StringValue.of(value))
        }
    }

    open var quantityUnit: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.quantityUnit))
        }
        set(value) {
            self.setDataValue(for: Product.quantityUnit, to: StringValue.of(optional: value))
        }
    }

    open var shortDescription: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.shortDescription))
        }
        set(value) {
            self.setDataValue(for: Product.shortDescription, to: StringValue.of(optional: value))
        }
    }

    open var stockDetails: Stock {
        get {
            return CastRequired<Stock>.from(self.dataValue(for: Product.stockDetails))
        }
        set(value) {
            self.setDataValue(for: Product.stockDetails, to: value)
        }
    }

    open var supplierDetails: Supplier {
        get {
            return CastRequired<Supplier>.from(self.dataValue(for: Product.supplierDetails))
        }
        set(value) {
            self.setDataValue(for: Product.supplierDetails, to: value)
        }
    }

    open var supplierID: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.supplierID))
        }
        set(value) {
            self.setDataValue(for: Product.supplierID, to: StringValue.of(optional: value))
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.dataValue(for: Product.updatedTimestamp))
        }
        set(value) {
            self.setDataValue(for: Product.updatedTimestamp, to: value)
        }
    }

    open var weight: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: Product.weight))
        }
        set(value) {
            self.setDataValue(for: Product.weight, to: DecimalValue.of(optional: value))
        }
    }

    open var weightUnit: String? {
        get {
            return StringValue.optional(self.dataValue(for: Product.weightUnit))
        }
        set(value) {
            self.setDataValue(for: Product.weightUnit, to: StringValue.of(optional: value))
        }
    }
}
