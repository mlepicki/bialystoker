//
//  ListViewController.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Injected
    var viewModel: ListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModelBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchPlaces()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    private func setupViewModelBinding() {
        
        viewModel.showLoading.subscribe { [weak self] showLoading in
            if showLoading {
                self?.showProgressHud()
            } else {
                self?.hideProgressHud()
            }
        }
        
        viewModel.error.subscribe { [weak self] errorMessage in
            self?.showError(with: errorMessage)
        }
        
        viewModel.places.subscribe { [weak self] places in
            self?.updateDisplayedPlaces(with: places)
        }
    }
    
    private func updateDisplayedPlaces(with places: [Place]) {
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.places.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let placeCell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else { fatalError("Unable to dequeue right cell!") }
        
        if let place = viewModel.places.value?[indexPath.row] {
            placeCell.update(with: place)
        }
        
        return placeCell
    }
}
