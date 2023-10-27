//
//  ViewController.swift
//  DetectABeacon
//
//  Created by Bambang Tri Rahmat Doni on 27/10/23.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var status = CLAuthorizationStatus.notDetermined
        status = manager.authorizationStatus
        
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didRange beacons: [CLBeacon],
                         satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    private func startScanning() -> Void {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: uuid))
    }

    private func update(distance: CLProximity) -> Void {
        UIView.animate(withDuration: 1) { [weak self] in
            switch distance {
            case .immediate:
                self?.view.backgroundColor = .red
                self?.distanceReading.text = "RIGHT HERE"
            case .near:
                self?.view.backgroundColor = .orange
                self?.distanceReading.text = "NEAR"
            case .far:
                self?.view.backgroundColor = .blue
                self?.distanceReading.text = "FAR"
            default:
                self?.view.backgroundColor = .gray
                self?.distanceReading.text = "UNKNOWN"
            }
        }
    }
}

