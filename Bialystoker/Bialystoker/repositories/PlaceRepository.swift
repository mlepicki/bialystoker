//
//  PlaceRepository.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import Foundation
import Contentful
import Interstellar

class PlaceRepository {
    
    private let client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    public func fetchAlPlaces(completionHandler: @escaping ([Place]?, Error?) -> Void) {
        
        let query = QueryOn<Place>.where(contentTypeId: "place")
        
        client.fetchMappedEntries(matching: query) { (result: Result<MappedArrayResponse<Place>>) in
            switch result {
            case .success(let entriesArrayResponse):
                let places = entriesArrayResponse.items
                DispatchQueue.main.async {
                    completionHandler(places, nil)
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
    }
    
}
