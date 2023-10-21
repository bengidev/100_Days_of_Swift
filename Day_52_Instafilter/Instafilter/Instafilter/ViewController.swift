//
//  ViewController.swift
//  Instafilter
//
//  Created by Bambang Tri Rahmat Doni on 21/10/23.
//

import UIKit

class ViewController: UIViewController,
                        UINavigationControllerDelegate,
                        UIImagePickerControllerDelegate {
    @IBOutlet var imageWrapperView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    private var currentImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeParentView()
        customizeImageWrapperView()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        currentImage = image
        print(currentImage ?? UIImage())
        dismiss(animated: true)
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
    }
    
    @IBAction func changeFilter(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    @objc private func importPicture() -> Void {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    private func customizeParentView() -> Void {
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(importPicture))
    }
    
    private func customizeImageWrapperView() -> Void {
        imageWrapperView.layer.cornerRadius = 10
    }

}

