//
//  ViewController.swift
//  Debugging
//
//  Created by Bambang Tri Rahmat Doni on 23/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        print("I'm inside the loadView() method!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm inside the viewDidLoad() method!")
        
        print(1, 2, 3, 4, 5)
        print(1, 2, 3, 4, 5, separator: "-")
        
        print("Some message", terminator: "")
        print("Some message")
        
        assert(1 == 1, "Maths failure!")
        assert(1 == 2, "Maths failure!")
        
        for i in 1 ... 10 {
            print("Got number \(i)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("I'm inside the viewWillAppear() method!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("I'm inside the viewDidAppear() method!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("I'm inside the viewDidDisappear() method!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("I'm inside the viewDidLayoutSubviews() method!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("I'm inside the viewWillDisappear() method!")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("I'm inside the viewWillLayoutSubviews() method!")
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        print("I'm inside the viewSafeAreaInsetsDidChange() method!")
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        print("I'm inside the viewWillTransition() method!")
    }
    
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        
        print("I'm inside the viewLayoutMarginsDidChange() method!")
    }
}

