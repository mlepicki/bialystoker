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
        
        defaultContainer.register(MapViewModel.self) { r in
            MapViewModel(placeRepository: r.resolve(PlaceRepository.self)!)
        }
        
        defaultContainer.register(ListViewModel.self) { r in
            ListViewModel(placeRepository: r.resolve(PlaceRepository.self)!)
        }
        
        defaultContainer.register(AboutViewModel.self) { _ in
            AboutViewModel()
        }
        
        defaultContainer.storyboardInitCompleted(MapViewController.self) { r, c in
            c.viewModel = r.resolve(MapViewModel.self)
        }

        defaultContainer.storyboardInitCompleted(ListViewController.self) { r, c in
            c.viewModel = r.resolve(ListViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(AboutViewController.self) { r, c in
            c.viewModel = r.resolve(AboutViewModel.self)
        }
    }
}
