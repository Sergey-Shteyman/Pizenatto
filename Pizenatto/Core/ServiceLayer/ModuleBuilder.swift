//
//  ModuleBuilder.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

import Foundation

// MARK: - Buildable
protocol Buildable {
    func makeTabbarViewController() -> TabbarController
    func makeCatalogViewController() -> CatalogViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {

    private let apiService: APIServicable
    private let networkService: Networkable
    private let decoderService: Decoderable

    init() {
        decoderService = DecoderService()
        networkService = NetworkService(decoderService: decoderService)
        apiService = APIService(networkService: networkService)
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func makeTabbarViewController() -> TabbarController {
        return TabbarController(moduleBuilder: self)
    }

    func makeCatalogViewController() -> CatalogViewController {
        let viewController = CatalogViewController()
        let presenter = CatalogPresenter(apiService: apiService)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
