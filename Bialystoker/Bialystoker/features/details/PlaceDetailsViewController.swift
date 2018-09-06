//
//  PlaceDetailsViewController.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaceDetailsViewController: UIViewController {

    var place: Place?
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var websiteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageUrl = place?.mainImage?.url {
            placeImage.af_setImage(withURL: imageUrl)
        }
        titleLabel.text = place?.name
        descriptionLabel.text = place?.description
        addressLabel.text = place?.address
        websiteTextView.text = place?.website
    }
}
