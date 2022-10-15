//
//  Section.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//


// MARK: - Section
struct Section {
    let type: SectionType
    let rows: [RowType]
}

// MARK: - SectionType
enum SectionType {
    case promotions
    case products(CategoriesViewModel)
}

// MARK: - RowType
enum RowType {
    case promotions(PromotionsViewModel)
    case product(ProductViewModel)
}

// TODO: -

struct PromotionsViewModel {
    let promotions: [PromotionViewModel]
}

struct PromotionViewModel {
    let imageUrl: String
}

struct CategoriesViewModel {
    let categories: [CategoryViewModel]
}

struct CategoryViewModel {
    let title: String
    let isSelected: Bool
}

struct ProductViewModel {
    let title: String
    let desciption: String
    let price: String
    let imageUrl: String
}
