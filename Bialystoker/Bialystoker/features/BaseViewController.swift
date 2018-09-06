//
//  BaseViewController.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
    
    private let hud = JGProgressHUD(style: .dark)
    
    func showProgressHud() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }
    
    func hideProgressHud() {
        hud.dismiss()
    }
    
    func showError(with message: String) {
        let errorHud = JGProgressHUD(style: .dark)
        errorHud.textLabel.text = message
        errorHud.indicatorView = JGProgressHUDErrorIndicatorView()
        errorHud.show(in: self.view)
        errorHud.dismiss(afterDelay: 2.0, animated: true)
    }

}
