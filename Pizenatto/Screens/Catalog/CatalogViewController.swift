//
//  ViewController.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

// MARK: - CatalogViewProtocol
protocol CatalogViewProtocol: AnyObject {
    func tableViewUpdate(viewModel sections: [Section])
    func tableViewScrollToRow(at indexPath: IndexPath)
}

// MARK: - CatalogViewController
final class CatalogViewController: UIViewController {

    var presenter: CatalogPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.myRegister(PromotionsTableViewCell.self)
        tableView.myRegister(ProductTableViewCell.self)
        return tableView
    }()
    
    private var sections: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - переделать на констеитнты
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        title = "Москва"
        
        presenter?.viewDidLoad()
    }
}

// MARK: - CatalogViewProtocol Impl
extension CatalogViewController: CatalogViewProtocol {
    
    func tableViewUpdate(viewModel sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
    
    func tableViewScrollToRow(at indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - UITableViewDataSource Impl
extension CatalogViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case .promotions(let promotionsViewModel):
            let cell = tableView.myDequeueReusableCell(type: PromotionsTableViewCell.self, indePath: indexPath)
            cell.configureCell(with: promotionsViewModel)
            return cell
        case .product(let productViewModel):
            let cell = tableView.myDequeueReusableCell(type: ProductTableViewCell.self, indePath: indexPath)
            cell.configureCell(with: productViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].type {
        case .promotions:
            return nil
            
        case .products(let categoriesViewModel):
            let header = CategoriesHeaderView()
            header.configure(with: categoriesViewModel)
            header.delegate = self
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 150
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section].type {
        case .promotions:
            return 0
            
        case .products:
            return 80
        }
    }
}

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CategoriesHeaderViewDelegate Impl
extension CatalogViewController: CategoriesHeaderViewDelegate {
    func categoryHeaderViewDidTapCell(at indexPath: IndexPath) {
        presenter?.didTapCategory(at: indexPath)
    }
}
