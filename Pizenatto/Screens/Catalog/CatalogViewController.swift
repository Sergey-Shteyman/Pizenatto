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
    func tableViewScrollToRow(at indexPath: IndexPath, categoriesViewModel: CategoriesViewModel)
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
        tableView.myRegister(EmptyTableViewCell.self)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var headerView: CategoriesHeaderView = {
        let header = CategoriesHeaderView()
        header.delegate = self
        return header
    }()
    
    private var sections: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        presenter?.viewDidLoad()
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemGray6
        view.myAddSubviews(tableView)
        
        setupConstraints()
        setupNavBar()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavBar() {
        let cityButtonView = CityButtonView()
        cityButtonView.configure(with: "Москва")
        let barButtonItem = UIBarButtonItem(customView: cityButtonView)
        navigationItem.leftBarButtonItem = barButtonItem
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
    }
}

// MARK: - CatalogViewProtocol Impl
extension CatalogViewController: CatalogViewProtocol {
    
    func tableViewUpdate(viewModel sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
    
    func tableViewScrollToRow(at indexPath: IndexPath, categoriesViewModel: CategoriesViewModel) {
        headerView.configure(with: categoriesViewModel)
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
            
        case .empty:
            let cell = tableView.myDequeueReusableCell(type: EmptyTableViewCell.self, indePath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].type {
        case .promotions:
            return nil
            
        case .products(let categoriesViewModel):
            headerView.configure(with: categoriesViewModel)
            return headerView
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

// MARK: - ProductTableViewCellDelegate Impl
extension CatalogViewController: ProductTableViewCellDelegate {
    func productTableViewCellDidTapPrice(_ cell: ProductTableViewCell) {
        print(#function)
    }
}
