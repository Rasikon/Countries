//
//  CountriesListAssembly.swift
//  Countries
//
//  Created by Ivan Redreev on 11.10.2023.
//

import UIKit

final class CountriesListAssembly {
    
    private var networkService: NetworkService
    
    public var view: UIViewController {
        let viewModel = CountriesListViewModel(service: networkService)
        let vc = CountriesListViewController(viewModel: viewModel)
        return vc
    }
    
    public init(_ networkService: NetworkService) {
        self.networkService = networkService
    }
}
