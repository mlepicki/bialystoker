//
//  AboutViewModel.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import Interstellar

class AboutViewModel {

    let showLoading = Observable<Bool>()
    let about = Observable<About>()
    let error = Observable<String>()
    
    private let aboutRepository: AboutRepository
    
    init(aboutRepository: AboutRepository) {
        self.aboutRepository = aboutRepository
    }
    
    func fetchAboutContent() {
        showLoading.update(true)
        aboutRepository.fetchAboutContent { [weak self] (about, error) in
            guard let strongSelf = self else { return }
            strongSelf.showLoading.update(false)
            if let unwrappedAbout = about {
                strongSelf.about.update(unwrappedAbout)
            } else if error != nil {
                strongSelf.error.update(error?.localizedDescription ?? "Unknown error")
            } else {
                strongSelf.error.update("Unknown error")
            }
        }
    }
}
