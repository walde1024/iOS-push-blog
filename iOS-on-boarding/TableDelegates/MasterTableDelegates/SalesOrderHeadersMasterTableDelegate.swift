//
// SalesOrderHeadersMasterTableDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//
import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class SalesOrderHeadersMasterTableDelegate: NSObject, MasterTableDelegate {
    private let dataAccess: ESPMContainerDataAccess
    weak var notifier: Notifier?
    private let logger = Logger.shared(named: "MasterTableDelegateLogger")

    private var _entities: [SalesOrderHeader] = [SalesOrderHeader]()
    var entities: [EntityValue] {
        get {
            return _entities
        }
        set {
            self._entities = newValue as! [SalesOrderHeader]
        }
    }

    init(dataAccess: ESPMContainerDataAccess) {
        self.dataAccess = dataAccess
    }

    func requestEntities(completionHandler: @escaping(Error?) -> ()) {
        self.dataAccess.loadSalesOrderHeaders() { (salesorderheaders, error) in
            guard let salesorderheaders = salesorderheaders else {
                completionHandler(error!)
                return
            }
            self.entities = salesorderheaders
            completionHandler(nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._entities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let salesorderheader = self.entities[indexPath.row] as! SalesOrderHeader
        let cell = cellWithNonEditableContent(tableView: tableView, indexPath: indexPath, key: "SalesOrderId", value: "\(salesorderheader.salesOrderID)")
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
