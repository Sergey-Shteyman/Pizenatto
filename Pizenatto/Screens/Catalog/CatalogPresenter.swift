//
//  CatalogPresenter.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import Foundation

// MARK: - CatalogPresenterProtocol
protocol CatalogPresenterProtocol: AnyObject {
    func didTapCategory(at indexPath: IndexPath)
}

// MARK: - CatalogPresenter
final class CatalogPresenter {
    
    weak var viewController: CatalogViewProtocol?
    
    private var categories: [CategoryModel] = [
        CategoryModel(id: 0, title: "123"),
        CategoryModel(id: 1, title: "1234"),
        CategoryModel(id: 2, title: "2222"),
        CategoryModel(id: 3, title: "3333")
    ]
    private var products: [ProductModel] = []
}

// MARK: - CatalogPresenterProtocol
extension CatalogPresenter: CatalogPresenterProtocol {
    func didTapCategory(at indexPath: IndexPath) {
        let categoryId = categories[indexPath.item].id
        
        let firstIndex = products.firstIndex { $0.categoryId == categoryId } ?? 0
        
        let newIndexPath = IndexPath(row: firstIndex, section: indexPath.section)
        viewController?.tableViewScrollToRow(at: newIndexPath)
    }
}

struct CategoryModel {
    let id: Int
    let title: String
}

struct ProductModel {
    let id: Int
    let categoryId: Int
    let title: String
}
