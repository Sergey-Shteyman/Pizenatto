//
//  CatalogPresenter.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import Foundation

// MARK: - CatalogPresenterProtocol
protocol CatalogPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapCategory(at indexPath: IndexPath)
}

// MARK: - CatalogPresenter
final class CatalogPresenter {
    
    weak var viewController: CatalogViewProtocol?
    
    private let apiService: APIServicable
    private let productsSectionNumber = 1
    private var promotions: [PromotionModel] = []
    private var categories: [CategoryModel] = []
    private var products: [ProductModel] = []
    
    init(apiService: APIServicable) {
        self.apiService = apiService
    }
    
    private func makeSections() {
        let sections: [Section] = [
            makePromotionsSection(),
            makeProductsSection()
        ]
        
        viewController?.tableViewUpdate(viewModel: sections)
    }
    
    private func makePromotionsSection() -> Section {
        let mappedPromotions = promotions.map {
            PromotionViewModel(imageUrl: $0.imageUrl)
        }
        let promotionsViewModel = PromotionsViewModel(promotions: mappedPromotions)
        let promotionsSection = Section(type: .promotions, rows: [.promotions(promotionsViewModel)])
        
        return promotionsSection
    }
    
    private func makeProductsSection() -> Section {
        let categoriesViewModel = makeCategoriesViewModel()
        
        var productsRows: [RowType] = [.empty]
        
        let rows = products.map { product -> RowType in
            let productViewModel = ProductViewModel(
                title: product.title,
                desciption: product.description,
                price: "от \(product.price) \(product.currency)",
                imageUrl: product.imageUrl
            )
            return RowType.product(productViewModel)
        }
        
        productsRows.append(contentsOf: rows)
        
        let productsSection = Section(type: .products(categoriesViewModel), rows: productsRows)
        
        return productsSection
    }
    
    private func makeCategoriesViewModel() -> CategoriesViewModel {
        let mappedCategories = categories.map {
            CategoryViewModel(title: $0.title, isSelected: $0.isSelected)
        }
        let categoriesViewModel = CategoriesViewModel(categories: mappedCategories)
        
        return categoriesViewModel
    }
}

// MARK: - CatalogPresenterProtocol
extension CatalogPresenter: CatalogPresenterProtocol {
    func viewDidLoad() {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            let group = DispatchGroup()
            
            group.enter()
            self.apiService.fetchPromotions { result in
                switch result {
                case .success(let response):
                    self.promotions = response
                    
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
                group.leave()
            }
            
            group.wait()
            group.enter()

            self.apiService.fetchCategories { result in
                switch result {
                case .success(let response):
                    self.categories = response.enumerated().map({ index, categoryResponse in
                        CategoryModel(
                            id: categoryResponse.id,
                            title: categoryResponse.title,
                            isSelected: index == 0 ? true : false
                        )
                    })
                    
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
                group.leave()
            }
            
            group.wait()
            group.enter()

            self.apiService.fetchProducts { result in
                switch result {
                case .success(let response):
                    self.products = response
                    
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
                group.leave()
            }
            group.wait()
            
            group.notify(queue: .main) { [weak self] in
                self?.makeSections()
            }
        }
    }
    
    func didTapCategory(at indexPath: IndexPath) {
        let categoryId = categories[indexPath.item].id
        
        categories.enumerated().forEach {
            categories[$0].isSelected = $1.id == categoryId
        }

        let firstIndex = products.firstIndex {
            $0.categoryId == categoryId
        } ?? 0
        print(firstIndex)
        let newIndexPath = IndexPath(row: firstIndex, section: productsSectionNumber)
        let categoriesViewModel = makeCategoriesViewModel()
        viewController?.tableViewScrollToRow(at: newIndexPath, categoriesViewModel: categoriesViewModel)
    }
}
