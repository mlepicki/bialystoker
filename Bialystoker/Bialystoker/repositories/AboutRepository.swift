//
//  AboutRepository.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AboutRepository: NSObject {

    func fetchAboutContent(completionHandler: @escaping (About?, Error?) -> Void) {
        
        let URL = "http://mlepicki.com/about.json"
        Alamofire.request(URL).responseObject { (response: DataResponse<About>) in

            if let about = response.result.value {
                DispatchQueue.main.async {
                    completionHandler(about, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(nil, response.error)
                }
            }
            
        }
    }
    
}
