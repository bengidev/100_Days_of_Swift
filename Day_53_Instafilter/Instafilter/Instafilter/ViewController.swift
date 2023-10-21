//
//  ViewController.swift
//  Instafilter
//
//  Created by Bambang Tri Rahmat Doni on 21/10/23.
//

import CoreImage
import UIKit

class ViewController: UIViewController,
                        UINavigationControllerDelegate,
                        UIImagePickerControllerDelegate {
    @IBOutlet var imageWrapperView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    private var currentImage: UIImage!
    
    private var context: CIContext!
    private var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeInstances()
        customizeParentView()
        customizeImageWrapperView()
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "CIChooseFilter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.sourceView = sender
        ac.popoverPresentationController?.sourceRect = sender.bounds
        
        present(ac, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func importPicture() -> Void {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func image(_ image: UIImage,
                       didFinishSavingWithError error: Error?,
                       contextInfo: UnsafeRawPointer) -> Void {
        if let error = error {
            // We got back an error!
            let ac = UIAlertController(title: "Save Error",
                                       message: error.localizedDescription,
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: resetInstances))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Save Successful",
                                       message: "Your altered image has been saved to your photos.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: resetInstances))
            present(ac, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
        dismiss(animated: true)
    }

    private func initializeInstances() -> Void {
        resetInstances()
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    private func resetInstances(action: UIAlertAction? = nil) -> Void {
        intensity.value = 0.5
        imageView.image = nil
    }
    
    private func customizeParentView() -> Void {
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(importPicture))
    }
    
    private func customizeImageWrapperView() -> Void {
        imageWrapperView.layer.cornerRadius = 10.0
        imageWrapperView.layer.shadowColor = UIColor.black.cgColor
        imageWrapperView.layer.shadowOffset = .zero
        imageWrapperView.layer.shadowOpacity = 0.5
        imageWrapperView.layer.shadowRadius = 5.0
        
        imageView.layer.cornerRadius = 10.0
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 5.0
    }
    
    private func applyProcessing() -> Void {
        guard let outputImage = currentFilter.outputImage else { return }
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2,
                                            y: currentImage.size.height / 2),
                                   forKey: kCIInputCenterKey)
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    private func setFilter(action: UIAlertAction) -> Void {
        // Make sure we have a valid image before continuing!
        guard currentImage != nil else { return }
        
        // Safely read the alert action's title
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }

}

