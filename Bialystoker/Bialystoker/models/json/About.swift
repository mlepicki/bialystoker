//
//  About.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import ObjectMapper

class About: Mappable {
    var title: String?
    var content: String?
    var copyright: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
        copyright <- map["copyright"]
    }
}
