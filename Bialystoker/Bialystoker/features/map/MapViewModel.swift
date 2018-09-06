//
//  MapViewModel.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import Interstellar

class MapViewModel {

    let showLoading = Observable<Bool>()
    let places = Observable<[Place]>()
    let error = Observable<String>()
    
    private let placeRepository: PlaceRepository
    
    init(placeRepository: PlaceRepository) {
        self.placeRepository = placeRepository
    }
    
    func fetchPlaces() {
        showLoading.update(true)
        placeRepository.fetchAlPlaces { [weak self] (places, error) in
            guard let strongSelf = self else { return }
            strongSelf.showLoading.update(false)
            if let unwrappedPlaces = places {
                strongSelf.places.update(unwrappedPlaces)
            } else if error != nil {
                strongSelf.error.update(error?.localizedDescription ?? "Unknown error")
            } else {
                strongSelf.error.update("Unknown error")
            }
        }
    }
    
}
