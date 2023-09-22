//
//  ViewController.swift
//  MemeMe1
//
//  Created by Wadah Esam on 20/09/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var canvasView: UIView!
    
    var meme = Meme()
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    let imagePickerDelegate = ImagePickerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        memeTextFieldDelegate.viewController = self
        topTextField.delegate = memeTextFieldDelegate
        bottomTextField.delegate = memeTextFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMemeTextFields()
        setupButtons()
        redrawCanvas()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func handleOpenPicker(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerDelegate.viewController = self
        imagePickerController.delegate = imagePickerDelegate
        
        switch (sender) {
        case cameraButton:
            imagePickerController.sourceType = .camera
        default:
            imagePickerController.sourceType = .photoLibrary
        }
        
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction func handleShareImage(_ sender: UIButton) {
        if captureView() != nil {
            let activityViewController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func redrawCanvas() {
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
        imageView.image = meme.image
        if (meme.isReadyToShare()) {
            shareButton.isEnabled = true
        }
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y == 0) {
                if (bottomTextField.isFirstResponder) { // left view only when bottomText is activve
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notificaiton: NSNotification) {
        if (self.view.frame.origin.y != 0) {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupButtons() {
        // Check for camera availability
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
        shareButton.isEnabled = false
    }

    private func setupMemeTextFields() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.backgroundColor: UIColor.clear,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
            NSAttributedString.Key.strokeWidth: -2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        [topTextField, bottomTextField].forEach { textField in
            textField.defaultTextAttributes = memeTextAttributes
            textField.backgroundColor = UIColor.clear
            textField.borderStyle = .none
            textField.autocorrectionType = .no
        }
    }
    
    private func captureView() -> UIImage? {
        if let view = canvasView {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
            if let context = UIGraphicsGetCurrentContext() {
                view.layer.render(in: context)
            }
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil;
    }

}

