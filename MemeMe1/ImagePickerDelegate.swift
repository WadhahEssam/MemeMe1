//
//  ImagePickerDelegate.swift
//  MemeMe1
//
//  Created by Wadah Esam on 22/09/2023.
//

import Foundation
import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var viewController: ViewController!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        picker.dismiss(animated: true)
        
        let selectedImage = info[.originalImage] as! UIImage
        viewController?.meme.image = selectedImage
        viewController?.redrawCanvas()
    }
}
