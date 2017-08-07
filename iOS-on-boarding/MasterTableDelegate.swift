//
// MasterTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import Foundation
import SAPOData
import SAPFiori

protocol MasterTableDelegate: UITableViewDelegate, UITableViewDataSource {
    var entities: [EntityValue] { get set }

    func requestEntities(completionHandler: @escaping(Error?) -> Void)

    weak var notifier: Notifier? { get set }
}

extension MasterTableDelegate {

    func cellWithNonEditableContent(tableView: UITableView, indexPath: IndexPath, key: String, value: String) -> FUIObjectTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
        cell.headlineText = value
        cell.footnoteText = key
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MasterViewController {

    func generatedTableDelegate() -> MasterTableDelegate? {
        switch collectionType {
        case .salesOrderHeaders:
            return SalesOrderHeadersMasterTableDelegate(dataAccess: self.espmContainer)
        case .productTexts:
            return ProductTextsMasterTableDelegate(dataAccess: self.espmContainer)
        case .suppliers:
            return SuppliersMasterTableDelegate(dataAccess: self.espmContainer)
        case .purchaseOrderItems:
            return PurchaseOrderItemsMasterTableDelegate(dataAccess: self.espmContainer)
        case .stock:
            return StockMasterTableDelegate(dataAccess: self.espmContainer)
        case .customers:
            return CustomersMasterTableDelegate(dataAccess: self.espmContainer)
        case .productCategories:
            return ProductCategoriesMasterTableDelegate(dataAccess: self.espmContainer)
        case .salesOrderItems:
            return SalesOrderItemsMasterTableDelegate(dataAccess: self.espmContainer)
        case .purchaseOrderHeaders:
            return PurchaseOrderHeadersMasterTableDelegate(dataAccess: self.espmContainer)
        case .products:
            return ProductsMasterTableDelegate(dataAccess: self.espmContainer)
        default:
            return nil
        }
    }
}
