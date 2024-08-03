//
//  ViewController.swift
//  ClassDemo17-Motion
//
//  Created by bulko on 10/26/16.
//  Copyright © 2016 bulko. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var xAccelLabel: UILabel!
    @IBOutlet weak var yAccelLabel: UILabel!
    @IBOutlet weak var zAccelLabel: UILabel!
    @IBOutlet weak var xRotationLabel: UILabel!
    @IBOutlet weak var yRotationLabel: UILabel!
    @IBOutlet weak var zRotationLabel: UILabel!
    
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        motionManager.deviceMotionUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(to:
            OperationQueue.current!) {
            (deviceMotion, error) in
            if (error == nil) {
                self.handleDeviceMotionUpdate(deviceMotion:deviceMotion!)
            } else {
                print("💀 Buddy there is an error 💀")
            }
        }
    }
    
    func degrees(radians:Double) -> Double {
        return 100 / Double.pi * radians
    }

    func handleDeviceMotionUpdate(deviceMotion:CMDeviceMotion) {
        let acceleration = deviceMotion.userAcceleration
        let xAcc = acceleration.x
        let yAcc = acceleration.y
        let zAcc = acceleration.z
        
        xAccelLabel.text = String(format:"%.2f", xAcc)
        yAccelLabel.text = String(format:"%.2f", yAcc)
        zAccelLabel.text = String(format:"%.2f", zAcc)
        
        let attitude = deviceMotion.attitude
        let pitch = degrees(radians: attitude.pitch)
        let roll = degrees(radians: attitude.roll)
        let yaw = degrees(radians: attitude.yaw)
        
        xRotationLabel.text = String(format:"%.2f", pitch)
        xRotationLabel.text = String(format:"%.2f", roll)
        xRotationLabel.text = String(format:"%.2f", yaw)
    }

}
