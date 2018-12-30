//
//  ViewController.swift
//  MotionSensor
//
//  Created by 舟木正憲 on 2018/12/30.
//  Copyright © 2018 masanori. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()

    @IBOutlet var fish: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let originalX = fish.center.x

        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (motion, error) in
                print(motion!.attitude.roll) // iPhoneの縦方向を軸とした傾き　-πからπまで
                let newX = originalX + CGFloat(motion!.attitude.roll * 100)
                self.fish.center = CGPoint(x: newX, y: self.fish.center.y)
            }
        }
    }

    func stopSensor() {
        motionManager.stopDeviceMotionUpdates()
    }
}

