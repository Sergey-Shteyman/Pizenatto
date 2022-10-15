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
        var sections: [Section] = []
        
        // make Promotions sections
        let mappedPromotions = promotions.map {
            PromotionViewModel(imageUrl: $0.imageUrl)
        }
        let promotionsViewModel = PromotionsViewModel(promotions: mappedPromotions)
        let promotionsSection = Section(type: .promotions, rows: [.promotions(promotionsViewModel)])
        
        sections.append(promotionsSection)
        
        // make Promotions sections
        let mappedCategories = categories.map {
            // TODO: -
            CategoryViewModel(title: $0.title, isSelected: false)
        }
        let categoriesViewModel = CategoriesViewModel(categories: mappedCategories)
        
        let productsRows = products.map { product -> RowType in
            let productViewModel = ProductViewModel(
                title: product.title,
                desciption: product.description,
                price: "\(product.price) \(product.currency)",
                imageUrl: product.imageUrl
            )
            return RowType.product(productViewModel)
        }
        
        let productsSection = Section(type: .products(categoriesViewModel), rows: productsRows)
        
        sections.append(productsSection)
        
        viewController?.tableViewUpdate(viewModel: sections)
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
                    self.categories = response
                    
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

        let firstIndex = products.firstIndex {
            $0.categoryId == categoryId
        } ?? 0
        print(firstIndex)
        let newIndexPath = IndexPath(row: firstIndex, section: productsSectionNumber)
        viewController?.tableViewScrollToRow(at: newIndexPath)
    }
}
