//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Bambang Tri Rahmat Doni on 16/10/23.
//

import UIKit

class ViewController: UITableViewController {
    /// Creating the basic UI: UITabBarController
    ///
    private var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petitions.append(Petition(title: "Test", body: "Test", signatureCount: 1))
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    /// Parsing JSON using the Codable protocol
    ///
    private func parse(json: Data) -> Void {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

}

