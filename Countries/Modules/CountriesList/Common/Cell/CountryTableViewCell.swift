//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit
import Kingfisher

final class CountryTableViewCell: UITableViewCell {
    
    private enum Constants {
        enum Constraints {
            static let standartOffset: CGFloat = 16
            static let flagImageViewWidth: CGFloat = 50
            static let flagImageViewHeight: CGFloat = 35
        }
    }
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var flagImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    public func setData(nameCountry: String, imageURL: String) {
        nameLabel.text = nameCountry
        if let url = URL(string: imageURL) {
            flagImageView.kf.setImage(with: url)
        }
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(flagImageView)
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.standartOffset),
            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.standartOffset),
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.standartOffset),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.flagImageViewHeight),
            flagImageView.widthAnchor.constraint(equalToConstant:  Constants.Constraints.flagImageViewWidth),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.standartOffset),
            nameLabel.trailingAnchor.constraint(equalTo: flagImageView.leadingAnchor, constant: -Constants.Constraints.standartOffset)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
