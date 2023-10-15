//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Bambang Tri Rahmat Doni on 14/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    private var countries = [String]()
    private var scores = 0
    private var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        askQuestion()
    }

    /// Guess which flag: random numbers
    ///
    private func askQuestion(alert: UIAlertAction! = nil) -> Void {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    /// From outlets to actions: creating an IBAction
    ///
    @IBAction func buttonTapped(_ sender: UIButton) -> Void {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            scores += 1
        } else {
            title = "Wrong"
            scores -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is: \(scores)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

