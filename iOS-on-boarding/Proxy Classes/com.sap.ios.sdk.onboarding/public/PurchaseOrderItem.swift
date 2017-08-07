// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

open class PurchaseOrderItem: EntityValue {
    public static let currencyCode: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "CurrencyCode")

    public static let grossAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "GrossAmount")

    public static let netAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "NetAmount")

    public static let productID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ProductId")

    public static let itemNumber: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ItemNumber")

    public static let purchaseOrderID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "PurchaseOrderId")

    public static let quantity: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "Quantity")

    public static let quantityUnit: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "QuantityUnit")

    public static let taxAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "TaxAmount")

    public static let productDetails: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ProductDetails")

    public static let header: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "Header")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.purchaseOrderItem)
    }

    open class func array(from: EntityValueList) -> Array<PurchaseOrderItem> {
        return ArrayConverter.convert(from.toArray(), Array<PurchaseOrderItem>())
    }

    open func copy() -> PurchaseOrderItem {
        return CastRequired<PurchaseOrderItem>.from(self.copyEntity())
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.dataValue(for: PurchaseOrderItem.currencyCode))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var grossAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: PurchaseOrderItem.grossAmount))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.grossAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var header: PurchaseOrderHeader {
        get {
            return CastRequired<PurchaseOrderHeader>.from(self.dataValue(for: PurchaseOrderItem.header))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.header, to: value)
        }
    }

    open var itemNumber: Int {
        get {
            return IntValue.unwrap(self.dataValue(for: PurchaseOrderItem.itemNumber))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.itemNumber, to: IntValue.of(value))
        }
    }

    open class func key(itemNumber: Int, purchaseOrderID: String) -> EntityKey {
        return EntityKey().with(name: "ItemNumber", value: IntValue.of(itemNumber)).with(name: "PurchaseOrderId", value: StringValue.of(purchaseOrderID))
    }

    open var netAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: PurchaseOrderItem.netAmount))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.netAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var old: PurchaseOrderItem {
        get {
            return CastRequired<PurchaseOrderItem>.from(self.oldEntity)
        }
    }

    open var productDetails: Product {
        get {
            return CastRequired<Product>.from(self.dataValue(for: PurchaseOrderItem.productDetails))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.productDetails, to: value)
        }
    }

    open var productID: String? {
        get {
            return StringValue.optional(self.dataValue(for: PurchaseOrderItem.productID))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.productID, to: StringValue.of(optional: value))
        }
    }

    open var purchaseOrderID: String {
        get {
            return StringValue.unwrap(self.dataValue(for: PurchaseOrderItem.purchaseOrderID))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.purchaseOrderID, to: StringValue.of(value))
        }
    }

    open var quantity: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: PurchaseOrderItem.quantity))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.quantity, to: DecimalValue.of(optional: value))
        }
    }

    open var quantityUnit: String? {
        get {
            return StringValue.optional(self.dataValue(for: PurchaseOrderItem.quantityUnit))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.quantityUnit, to: StringValue.of(optional: value))
        }
    }

    open var taxAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.dataValue(for: PurchaseOrderItem.taxAmount))
        }
        set(value) {
            self.setDataValue(for: PurchaseOrderItem.taxAmount, to: DecimalValue.of(optional: value))
        }
    }
}
