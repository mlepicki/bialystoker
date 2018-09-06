//
//  PlaceAnnotation.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import MapKit

class PlaceAnnotation: MKPointAnnotation {
    
    let place: Place
    
    init(place: Place) {
        self.place = place
        super.init()
        self.title = place.name
    }

}
