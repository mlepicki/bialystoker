//
//  AboutViewController.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    var viewModel: AboutViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchAboutContent()
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
        
        viewModel.about.subscribe { [weak self] about in
            self?.titleLabel.text = about.title
            self?.descriptionLabel.text = about.content
            self?.copyrightLabel.text = about.copyright
        }
    }

}
