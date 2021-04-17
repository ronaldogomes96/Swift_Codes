//
//  ViewController.swift
//  BussolaApp
//
//  Created by Ronaldo Gomes on 03/03/21.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bussola
        //initialConfigurationForLocationManager()
        
        //Proximity
        //activateProximitySensor()
        
        //Core motion
        //coreMotion()
        
        // Swipe
        let userTap = UISwipeGestureRecognizer(target: self, action: #selector(tapGesture))
        userTap.direction = .up
        userTap.direction = .down
        view.addGestureRecognizer(userTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Bussola code
    func initialConfigurationForLocationManager() {
        if (CLLocationManager.headingAvailable()) {
            locationManager.headingFilter = 1
            locationManager.startUpdatingHeading()
            locationManager.delegate = self
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        //print(heading.magneticHeading)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    //MARK: - Proximity code
    func activateProximitySensor() {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }

    @objc func proximityChanged(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device) detected!")
        }
    }
    
    
    //MARK: - Core motion
    func coreMotion() {
        //let motionManager = CMMotionManager()

           if motionManager.isDeviceMotionAvailable {

               motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()

               motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] (motion, error) -> Void in

                if let attitude = motion?.rotationRate.z {

                        print("CORE MOTION\(attitude)")
                    print(self?.motionManager.deviceMotion!.rotationRate.z as Any)

                        DispatchQueue.main.async{
                            // Update UI
                       }
                   }

               }

               print("Device motion started")
            }
           else {
               print("Device motion unavailable")
            }
    }
    
    @objc func tapGesture(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.state {
        case .ended:
            for _ in 0...1000 {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
        default:
             return
        }

    }
    
}

