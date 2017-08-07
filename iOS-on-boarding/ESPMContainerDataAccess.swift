//
// ESPMContainerDataAccess.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import Foundation
import SAPCommon
import SAPFoundation
import SAPOData

class ESPMContainerDataAccess {

    let service: ESPMContainer<OnlineODataProvider>
    private let logger = Logger.shared(named: "ServiceDataAccessLogger")

    init(urlSession: SAPURLSession) {
        let odataProvider = OnlineODataProvider(serviceName: "ESPMContainer", serviceRoot: Constants.appUrl, sapURLSession: urlSession)

        // Disables version validation of the backend OData service
        // TODO: Should only be used in demo and test applications
        odataProvider.serviceOptions.checkVersion = false

        self.service = ESPMContainer(provider: odataProvider)

        // To update entity force to use X-HTTP-Method header
        self.service.provider.networkOptions.tunneledMethods.append("MERGE")
    }

    func loadSalesOrderHeaders(completionHandler: @escaping([SalesOrderHeader]?, Error?) -> ()) {
        self.executeRequest(self.service.salesOrderHeaders, completionHandler)
    }

    func loadProductTexts(completionHandler: @escaping([ProductText]?, Error?) -> ()) {
        self.executeRequest(self.service.productTexts, completionHandler)
    }

    func loadSuppliers(completionHandler: @escaping([Supplier]?, Error?) -> ()) {
        self.executeRequest(self.service.suppliers, completionHandler)
    }

    func loadPurchaseOrderItems(completionHandler: @escaping([PurchaseOrderItem]?, Error?) -> ()) {
        self.executeRequest(self.service.purchaseOrderItems, completionHandler)
    }

    func loadStock(completionHandler: @escaping([Stock]?, Error?) -> ()) {
        self.executeRequest(self.service.stock, completionHandler)
    }

    func loadCustomers(completionHandler: @escaping([Customer]?, Error?) -> ()) {
        self.executeRequest(self.service.customers, completionHandler)
    }

    func loadProductCategories(completionHandler: @escaping([ProductCategory]?, Error?) -> ()) {
        self.executeRequest(self.service.productCategories, completionHandler)
    }

    func loadSalesOrderItems(completionHandler: @escaping([SalesOrderItem]?, Error?) -> ()) {
        self.executeRequest(self.service.salesOrderItems, completionHandler)
    }

    func loadPurchaseOrderHeaders(completionHandler: @escaping([PurchaseOrderHeader]?, Error?) -> ()) {
        self.executeRequest(self.service.purchaseOrderHeaders, completionHandler)
    }

    func loadProducts(completionHandler: @escaping([Product]?, Error?) -> ()) {
        self.executeRequest(self.service.products, completionHandler)
    }

    // MARK: - Request execution
    private typealias DataAccessCompletionHandler<Entity> = ([Entity]?, Error?) -> ()
    private typealias DataAccessRequestWithQuery<Entity> = (DataQuery, @escaping DataAccessCompletionHandler<Entity>) -> ()

    /// Helper function to execute a given request.
    /// Provides error logging and extends the query so that it only requests the first 20 items.
    ///
    /// - Parameter request: the request to execute
    private func executeRequest<Entity: EntityValue>(_ request: DataAccessRequestWithQuery<Entity>, _ completionHandler: @escaping DataAccessCompletionHandler<Entity>) {

        // Only request the first 20 values
        let query = DataQuery().selectAll().top(20)

        request(query) { (result, error) in
            guard let result = result else {
                let error = error!
                self.logger.error("Error happened in the downloading process.", error: error)
                completionHandler(nil, error)
                return
            }
            completionHandler(result, nil)
        }
    }
}
