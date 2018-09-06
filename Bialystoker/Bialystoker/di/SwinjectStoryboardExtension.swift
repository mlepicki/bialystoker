//
//  SwinjectConfigurator.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import Contentful
import Interstellar

extension SwinjectStoryboard {
    @objc class func setup() {
        
        // disable logging due to https://github.com/Swinject/Swinject/issues/213
        Container.loggingFunction = nil

        // Services, repositories etc.
        defaultContainer.register(Client.self) { _ in
            let contentTypeClasses: [EntryDecodable.Type] = [
                Place.self
            ]
            
            return Client(spaceId: "gcscqxghl0od",
                                accessToken: "10ada72d26247c924abf3bcae8abc13605c642820413b2810223d812050bd199",
                                contentTypeClasses: contentTypeClasses)
        }
        
        defaultContainer.register(PlaceRepository.self) { r in
            PlaceRepository(client: r.resolve(Client.self)!)
        }
        
        defaultContainer.register(AboutRepository.self) { _ in
            AboutRepository()
        }
        
        // view models
        defaultContainer.register(PlaceMapViewModel.self) { r in
            PlaceMapViewModel(placeRepository: r.resolve(PlaceRepository.self)!)
        }
        
        defaultContainer.register(PlaceListViewModel.self) { r in
            PlaceListViewModel(placeRepository: r.resolve(PlaceRepository.self)!)
        }
        
        defaultContainer.register(AboutViewModel.self) { r in
            AboutViewModel(aboutRepository: r.resolve(AboutRepository.self)!)
        }
        
        // view controllers
        defaultContainer.storyboardInitCompleted(PlaceMapViewController.self) { r, c in
            c.viewModel = r.resolve(PlaceMapViewModel.self)
        }

        defaultContainer.storyboardInitCompleted(PlaceListViewController.self) { r, c in
            c.viewModel = r.resolve(PlaceListViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(AboutViewController.self) { r, c in
            c.viewModel = r.resolve(AboutViewModel.self)
        }
    }
}
