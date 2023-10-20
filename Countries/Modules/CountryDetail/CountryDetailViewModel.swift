//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Ivan Redreev on 12.10.2023.
//

import UIKit
import Combine

final class CountryDetailViewModel {
    
    public struct CountryDetailItem {
        public let name: String
        public let flag: String
        public let region: String
        public let capital: String
        public let currency: String
        public let timezone: String
    }
    
    public enum Action {
        case onAppear
    }
    
    public var action = PassthroughSubject<Action, Never>()
    private(set) var country = CurrentValueSubject<CountryDetailItem?, Never>(nil)
    private var cancellables: Set<AnyCancellable> = []
    
    public init(country: Country) {
        
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .onAppear:
                    self?.prepareCountryDetailItem(country)
                }
            }
            .store(in: &cancellables)
    }
    
    private func prepareCountryDetailItem(_ country: Country) {
        let name = country.name?.official ?? ""
        let flag = country.flags?.png ?? ""
        let region = "Region:\n \(country.region ?? "")\n"
        let capital = "Capital:\n \(country.capital?.first ?? "")\n"
        
        var currenciesString = "Currency:\n"
        guard let currencies = country.currencies else { return }
        for (key,value) in currencies {
            if let name = value.name {
                currenciesString += "\(key): \(name)\n"
            }
        }
        
        var timezoneString = "Timezone:\n"
        guard let timezones = country.timezones else { return }
        for timezone in timezones {
            timezoneString += "\(timezone)\n"
        }
        
        self.country.send(CountryDetailItem(name: name, flag: flag, region: region, capital: capital, currency: currenciesString, timezone: timezoneString))
    }
}
