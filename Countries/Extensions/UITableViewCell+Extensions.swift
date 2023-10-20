//
//  UITableViewCell+Extensions.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
