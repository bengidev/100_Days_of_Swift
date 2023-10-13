//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Bambang Tri Rahmat Doni on 14/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    /// Building a detail screen
    /// 
    @IBOutlet var imageView: UIImageView!
    
    /// Loading images with UIImage
    ///
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Final tweaks: hidesBarsOnTap and large titles
        ///
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        
        /// Loading images with UIImage
        ///
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    /// Final tweaks: hidesBarsOnTap and large titles
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
