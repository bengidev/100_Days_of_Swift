//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Bambang Tri Rahmat Doni on 16/10/23.
//

import UIKit

class ViewController: UITableViewController {
    private var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petitions.append(Petition(title: "Test", body: "Test", signatureCount: 1))
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 1 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func parse(json: Data) -> Void {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    /// Finishing touches: didFinishLaunchingWithOptions
    ///
    private func showError(title: String? = nil, message: String? = nil) -> Void {
        let tempTitle = "Loading Error"
        let tempMessage = "There was a problem loading the feed; please check your connection and try again."
        
        let ac = UIAlertController(title: title ?? tempTitle,
                                   message: message ?? tempMessage,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

