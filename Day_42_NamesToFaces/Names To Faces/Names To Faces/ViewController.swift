//
//  ViewController.swift
//  Names To Faces
//
//  Created by Bambang Tri Rahmat Doni on 20/10/23.
//

import UIKit

class ViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person",
                                                            for: indexPath) as? PersonCell
        // We failed to get a PersonCell – bail out!
        else { fatalError("Unable to dequeue PersonCell.") }
        
        // If we're still here it means we got a PersonCell, so we can return it
        return cell
    }
}
