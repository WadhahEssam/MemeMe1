//
//  MemeTextFieldDelegate.swift
//  MemeMe1
//
//  Created by Wadah Esam on 22/09/2023.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    var initialText: String!
    weak var viewController: ViewController?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        initialText = textField.text
        
        if (textField == viewController?.topTextField && textField.text == "TOP") {
            viewController?.meme.topText = ""
        } else if (textField == viewController?.bottomTextField && textField.text == "BOTTOM") {
            viewController?.meme.bottomText = ""
        }
        viewController?.redrawCanvas()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.text == "") {
            if (textField == viewController?.topTextField) {
                viewController?.meme.topText = "TOP"
            } else {
                viewController?.meme.bottomText = "BOTTOM"
            }
            viewController?.redrawCanvas()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        
        if (textField == viewController?.topTextField) {
            viewController?.meme.topText = newText
        } else {
            viewController?.meme.bottomText = newText
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
