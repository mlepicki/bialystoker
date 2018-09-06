//
//  Place.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import Foundation
import Contentful

final class Place: EntryDecodable, EntryQueryable {
    
    static let contentTypeId: String = "place"
    
    let sys: Sys
    let name: String
    let description: String
    let address: String
    let location: Location
    let website: String
    
    var mainImage: Asset?
    
    public required init(from decoder: Decoder) throws {
        sys                 = try decoder.sys()
        let fields          = try decoder.contentfulFieldsContainer(keyedBy: Place.Fields.self)
        
        self.name           = try fields.decode(String.self, forKey: .name)
        self.description    = try fields.decode(String.self, forKey: .description)
        self.address        = try fields.decode(String.self, forKey: .address)
        self.location       = try fields.decode(Location.self, forKey: .location)
        self.website        = try fields.decode(String.self, forKey: .website)
        
        try fields.resolveLink(forKey: .mainImage, decoder: decoder) { [weak self] linkedAsset in
            self?.mainImage = linkedAsset as? Asset
        }
    }
    
    enum Fields: String, CodingKey {
        case name, description, address, location, website, mainImage
    }
}
