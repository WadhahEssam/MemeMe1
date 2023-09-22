//
//  Meme.swift
//  MemeMe1
//
//  Created by Wadah Esam on 22/09/2023.
//

import Foundation
import UIKit

struct Meme {
    var topText: String? = "TOP"
    var bottomText: String? = "BOTTOM"
    private var isPlaceHolderImage = true
    var image: UIImage = UIImage(imageLiteralResourceName: "Placeholder") {
        didSet {
            isPlaceHolderImage = false
        }
    }
    func isReadyToShare() -> Bool {
        return !isPlaceHolderImage && topText != "TOP" && bottomText != "BOTTOM";
    }
    var memedImage: UIImage?
}
