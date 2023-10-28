//
//  ViewController.swift
//  Selfie Share
//
//  Created by Bambang Tri Rahmat Doni on 28/10/23.
//

import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    MCSessionDelegate,
                      MCBrowserViewControllerDelegate {
    
    private var peerID: MCPeerID?
    private var mcSession: MCSession?
    private var mcAdvertiserAssistant: MCAdvertiserAssistant?

    private var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }

    private func configureNavigation() {
        title = "Selfie Share"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(showConnectionPrompt))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                                            target: self,
                                                            action: #selector(importPicture))
    }

    private func configurePeerConnectivity() {
        peerID = MCPeerID(displayName: UIDevice.current.name)

        if let peerID = peerID {
            mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
            mcSession?.delegate = self
        }
    }

    @objc private func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect To Others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    @objc private func importPicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    private func startHosting(_ action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25",
                                                      discoveryInfo: nil,
                                                      session: mcSession)
        mcAdvertiserAssistant?.start()
    }

    private func joinSession(_ action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        cell.layer.cornerRadius = 10.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5.0

        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
            imageView.layer.cornerRadius = 10.0
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOffset = .zero
            imageView.layer.shadowOpacity = 0.5
            imageView.layer.shadowRadius = 5.0
        }

        return cell
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)

        images.insert(image, at: 0)
        collectionView.reloadData()
        
        guard let mcSession = mcSession else { return }
        
        if mcSession.connectedPeers.count > 0 {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send Error",
                                               message: error.localizedDescription,
                                               preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .connected:
            print("Connected: \(peerID.displayName)")
        @unknown default:
            print("Unknown State Received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
    
    func session(_ session: MCSession,
                 didReceive stream: InputStream,
                 withName streamName: String,
                 fromPeer peerID: MCPeerID) {
        //
    }
    
    func session(_ session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 with progress: Progress) {
        //
    }
    
    func session(_ session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 at localURL: URL?,
                 withError error: Error?) {
        //
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
}
