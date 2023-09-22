//
//  CropImageDelegate.swift
//  MemeMe1
//
//  Created by Wadah Esam on 22/09/2023.
//

import Foundation
import UIKit
import CropViewController

class CropImageDelegate: NSObject, CropViewControllerDelegate {
    weak var viewController: ViewController!
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        viewController?.meme.memedImage = image
        if let memedImage = viewController?.meme.memedImage {
            cropViewController.dismiss(animated: true)
            let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            viewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
}
