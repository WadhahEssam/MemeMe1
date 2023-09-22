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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        initialText = textField.text
        if (textField.text == "TOP" || textField.text == "BOTTOM") {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.text == "" && (initialText == "TOP" || initialText == "BOTTOM")) {
            textField.text = initialText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
