//
//  PlaceCell.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeTitleLabel: UILabel!
    
    @IBOutlet weak var placeAddressLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeImageView.af_cancelImageRequest()
        placeImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func update(with place: Place) {
        placeTitleLabel.text = place.name
        placeAddressLabel.text = place.address
        if let url = place.mainImage?.url {
            placeImageView.af_setImage(withURL: url)
        }
    }
}
