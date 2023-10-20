//
//  NetworkError.swift
//  Countries
//
//  Created by Ivan Redreev on 11.10.2023.
//

import Foundation

public enum NetworkError: Error {
    case badFormatURL
    case transportError
    case noResponse
    case invalidResponse
    case invalidData
    
    public var errorDescription: String? {
        switch self {
        case .badFormatURL:
            return "Неверный URL-адрес запроса"
        case .noResponse:
            return "Ответ не получен"
        case .invalidResponse:
            return "Неверное значение ответа"
        case .invalidData:
            return "Неверный формат данных"
        case .transportError:
            return "Ошибка соединения"
        }
    }
}
