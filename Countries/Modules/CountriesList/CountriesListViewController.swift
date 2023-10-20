//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit
import Combine

final class CountriesListViewController: UIViewController, FullscreenLoaderRoute, AlertsRoute {
    
    // MARK: - Constants
    private enum Constants {
        static let title = "Страны"
    }
    
    private lazy var tableView: UITableView = {
        $0.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    //MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: CountriesListViewModel
    
    init(viewModel: CountriesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFullscreenLoader()
        viewModel.action.send(.onDidLoad)
        setupBind()
        setupUI()
    }
    
    private func setupBind() {
        viewModel.countriesData
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.hideFullscreenLoader()
            }
            .store(in: &cancellables)
        
        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] error in
                self?.showCancelAlert(title: "Ошибка", message: error)
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        title = Constants.title
        let update = UIButton(type: .system)
        update.setTitle("Обновить", for: .normal)
        update.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: update)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "backgroundColor")
        appearance.shadowColor = .clear
        appearance.titleTextAttributes =  [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
        
    }
    
    @objc private func updateTapped() {
        showFullscreenLoader()
        viewModel.action.send(.onDidLoad)
    }
}

extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countriesData.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell, let dataSource = viewModel.countriesData.value else { return UITableViewCell() }
        cell.setData(nameCountry: dataSource[indexPath.row].name?.official ?? "", imageURL: dataSource[indexPath.row].flags?.png ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let country = viewModel.countriesData.value?[indexPath.row] else { return }
        let assembly = CountryDetailAssembly(country)
        navigationController?.pushViewController(assembly.view, animated: true)
    }
}
