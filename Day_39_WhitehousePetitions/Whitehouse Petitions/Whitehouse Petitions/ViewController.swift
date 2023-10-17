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

        /// Easy GCD using performSelector(inBackground:)
        ///
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
//        let urlString: String
//        if navigationController?.tabBarItem.tag == 1 {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//        } else {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
//        }
//
//        /// GCD 101: async()
//        ///
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            if let url = URL(string: urlString) {
//                if let data = try? Data(contentsOf: url) {
//                    self?.parse(json: data)
//                    return
//                }
//            }
//
//            self?.showError()
//        }
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    @objc private func fetchJSON() {
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

        /// Easy GCD using performSelector(inBackground:)
        ///
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
//    private func parse(json: Data) -> Void {
//        let decoder = JSONDecoder()
//
//        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
//            petitions = jsonPetitions.results
//
//            /// Back to the main thread: DispatchQueue.main
//            ///
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
//    }
    
    /// Easy GCD using performSelector(inBackground:)
    ///
    private func parse(json: Data) -> Void {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData),
                                      with: nil,
                                      waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    /// Back to the main thread: DispatchQueue.main
    ///
//    @objc private func showError(title: String? = nil, message: String? = nil) -> Void {
//        DispatchQueue.main.async { [weak self] in
//            let tempTitle = "Loading Error"
//            let tempMessage = "There was a problem loading the feed; please check your connection and try again."
//
//            let ac = UIAlertController(title: title ?? tempTitle,
//                                       message: message ?? tempMessage,
//                                       preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            self?.present(ac, animated: true)
//        }
//    }
    
    /// Easy GCD using performSelector(inBackground:)
    ///
    @objc private func showError(title: String? = nil, message: String? = nil) {
        let tempTitle = "Loading Error"
        let tempMessage = "There was a problem loading the feed; please check your connection and try again."

        let ac = UIAlertController(title: title ?? tempTitle,
                                   message: message ?? tempMessage,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

