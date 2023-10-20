//
//  CountryDetailAssembly.swift
//  Countries
//
//  Created by Ivan Redreev on 12.10.2023.
//

import UIKit

final class CountryDetailAssembly {
    
    private var country: Country
    
    public var view: UIViewController {
        let viewModel = CountryDetailViewModel(country: country)
        let vc = CountryDetailViewController(viewModel: viewModel)
        return vc
    }
    
    public init(_ country: Country) {
        self.country = country
    }
}
