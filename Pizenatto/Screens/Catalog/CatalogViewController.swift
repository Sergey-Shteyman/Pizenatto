//
//  ViewController.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit


// MARK: - CatalogProtocol
protocol CatalogViewProtocol: AnyObject {
    func tableViewScrollToRow(at indexPath: IndexPath)
}

// MARK: - CatalogViewController
final class CatalogViewController: UIViewController {
    
    
    // TODO: - ModuleBuilder
    var presenter: CatalogPresenterProtocol = CatalogPresenter()
    
    private var categoriesViewModel: [CategoryCellViewModel] = [
        CategoryCellViewModel(title: "Пицца", isSelected: true),
        CategoryCellViewModel(title: "Комбо", isSelected: false),
        CategoryCellViewModel(title: "123", isSelected: false),
        CategoryCellViewModel(title: "4321", isSelected: false),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - Refactore to Constraints
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        title = "Москва"
    }
}

// MARK: - CatalogViewProtocol Impl
extension CatalogViewController: CatalogViewProtocol {
    
    func tableViewScrollToRow(at indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - UITableViewDataSource impl
extension CatalogViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 20
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 1 {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .red
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 1 {
//            return "Title"
//        } else {
//            return nil
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = CategoriesHeaderView()
            header.configureCell(with: categoriesViewModel)
            header.delegate = self
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 80
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDelegate impl
extension CatalogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CategoriesHeaderViewDelegate Impl
extension CatalogViewController: CategoriesHeaderViewDelegate {
    
    func categoryHeaderViewDidTapCell(at indexPath: IndexPath) {
        presenter.didTapCategory(at: indexPath)
    }
}
