//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Ivan Redreev on 12.10.2023.
//

import UIKit
import Combine
import Kingfisher

final class CountryDetailViewController: UIViewController, FullscreenLoaderRoute {
    
    private enum Constants {
        enum Constraints {
            static let standartOffset: CGFloat = 16
            static let flagImageViewWidth: CGFloat = 80
            static let flagImageViewHeight: CGFloat = 55
        }
    }
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var flagImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    private lazy var regionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var capitalLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var currencyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var timezoneLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delaysContentTouches = false
        return $0
    }(UIScrollView())
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: CountryDetailViewModel
    
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.action.send(.onAppear)
        showFullscreenLoader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBind()
    }
    
    private func setupBind() {
        viewModel.country
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] _ in
                self?.configureViews()
                self?.hideFullscreenLoader()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(scrollView)
        stackView.addArrangedSubview(regionLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(capitalLabel)
        stackView.addArrangedSubview(timezoneLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(flagImageView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.Constraints.standartOffset),
            nameLabel.bottomAnchor.constraint(equalTo: flagImageView.topAnchor, constant: -Constants.Constraints.standartOffset),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.standartOffset),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.standartOffset),
            
            flagImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.flagImageViewHeight),
            flagImageView.widthAnchor.constraint(equalToConstant:  Constants.Constraints.flagImageViewWidth),
            
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: Constants.Constraints.standartOffset),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.Constraints.standartOffset),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.Constraints.standartOffset),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.Constraints.standartOffset)
        ])
    }
    
    private func configureViews() {
        nameLabel.text = viewModel.country.value?.name
        if let url = URL(string: viewModel.country.value?.flag ?? "") {
            flagImageView.kf.setImage(with: url)
        }
        regionLabel.text = viewModel.country.value?.region
        capitalLabel.text = viewModel.country.value?.capital
        currencyLabel.text = viewModel.country.value?.currency
        timezoneLabel.text = viewModel.country.value?.timezone
    }
}

