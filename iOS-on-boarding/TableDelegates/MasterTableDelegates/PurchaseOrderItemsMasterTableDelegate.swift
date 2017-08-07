//
// PurchaseOrderItemsMasterTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class PurchaseOrderItemsMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    weak var notifier: Notifier?
    private let logger = Logger.shared(named: "MasterTableDelegateLogger")

    private var _entities: [PurchaseOrderItem] = [PurchaseOrderItem]()
    var entities: [EntityValue] {
        get {
            return _entities
        }
        set {
            self._entities = newValue as! [PurchaseOrderItem]
        }
    }

    init(dataAccess: ESPMContainerDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> ()) {
        self.dataAccess.loadPurchaseOrderItems() { (purchaseorderitems, error) in
            guard let purchaseorderitems = purchaseorderitems else {
                completionHandler(error!)
                return
            }
            self.entities = purchaseorderitems
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let purchaseorderitem = self.entities[indexPath.row] as! PurchaseOrderItem
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "ItemNumber", value: "\(purchaseorderitem.itemNumber)")
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        let currentEntity = self._entities[indexPath.row]
        self.dataAccess.service.deleteEntity(currentEntity) { error in
            if let error = error {
                self.logger.error("Delete entry failed.", error: error)
                self.notifier?.displayAlert(title: NSLocalizedString("keyErrorDeletingEntryTitle",
                    value: "Delete entry failed",
                    comment: "XTIT: Title of deleting entry error pop up."),
                message: error.localizedDescription)
                return
            }
            self._entities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
