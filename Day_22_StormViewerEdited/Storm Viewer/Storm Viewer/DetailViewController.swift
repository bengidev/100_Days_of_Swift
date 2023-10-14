//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Bambang Tri Rahmat Doni on 14/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// UIActivityViewController explained
        ///
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    /// UIActivityViewController explained
    ///
    @objc func shareTapped() -> Void {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found!")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
