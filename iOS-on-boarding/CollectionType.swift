//
// CollectionType.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import Foundation

enum CollectionType: String {

    case salesOrderHeaders = "SalesOrderHeaders"
    case productTexts = "ProductTexts"
    case suppliers = "Suppliers"
    case purchaseOrderItems = "PurchaseOrderItems"
    case stock = "Stock"
    case customers = "Customers"
    case productCategories = "ProductCategories"
    case salesOrderItems = "SalesOrderItems"
    case purchaseOrderHeaders = "PurchaseOrderHeaders"
    case products = "Products"
    case none = ""

    private static let all = [
        salesOrderHeaders, productTexts, suppliers, purchaseOrderItems, stock, customers, productCategories, salesOrderItems, purchaseOrderHeaders, products]

    static let allValues = CollectionType.all.map { (type) -> String in
        return type.rawValue
    }
}
