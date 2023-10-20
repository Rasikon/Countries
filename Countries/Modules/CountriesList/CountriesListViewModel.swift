//
//  CountriesListViewModel.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit
import Combine

final class CountriesListViewModel {
    
    public enum Action {
        case onDidLoad
    }
    
    public var action = PassthroughSubject<Action, Never>()
    private(set) var countriesData = CurrentValueSubject<[Country]?, Never>([])
    private(set) var errorMessage = CurrentValueSubject<String?, Never>(nil)
    private var networkService: NetworkService
    private var cancellables: Set<AnyCancellable> = []
    
    public init(service: NetworkService) {
        networkService = service
        
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .onDidLoad:
                    self?.loadCountries()
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadCountries() {
        networkService.requestCountriesData { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countriesData.send(countries)
            case .failure(let error):
                self?.errorMessage.send(error.errorDescription)
            }
        }
    }
}
