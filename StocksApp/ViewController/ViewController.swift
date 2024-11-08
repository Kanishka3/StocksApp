//
//  ViewController.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 31/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
        
    private let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        return indicator
    }()
    
    private let bottomStickyView = BottomStickyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
        viewModel.collection.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return } 
                self.tableView.reloadData()
                self.bottomStickyView.setData(viewModel: self.viewModel.getStickyViewModel())
            }
        }
        
        viewModel.state.bind { [weak self] state in
            DispatchQueue.main.async {  [weak self] in
                guard let self else { return }
                switch state {
                case .loading:
                    loader.startAnimating()
                    loader.isHidden = false
                default:
                    loader.stopAnimating()
                    loader.isHidden = true
                }
            }
        }
        
        configureUI()
    }
    
    private func configureUI() {
        createViews()
        setupTableView()
    }
    
    private func createViews() {
        view.addSubviews(tableView, bottomStickyView, loader)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        [bottomStickyView, tableView].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        navigationItem.title = GlobalConstants.navTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HoldingCell.self,
                           forCellReuseIdentifier: HoldingCell.self.description())
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
    }
}


typealias ViewControllerTableSetters = ViewController

extension ViewControllerTableSetters: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.collection.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: HoldingCell.self.description()) as? HoldingCell else {
            return .init()
        }
        if let data = viewModel.collection.value[safe: indexPath.row] {
            tableViewCell.setData(from: data,
                                  calculatedPnl: viewModel.pnl(data))
        }
        return tableViewCell
    }
    
}


