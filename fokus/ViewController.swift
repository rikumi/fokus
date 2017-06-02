//
//  ViewController.swift
//  fokus
//
//  Created by Vhyme on 2017/6/2.
//  Copyright © 2017年 HeraldStudio. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    
    var motion = CMMotionManager()
    
    var lastSecond = Int64(Date().timeIntervalSince1970)
    
    var isFokus = false
    
    var fokusTime = 0 {
        didSet {
            timeLabel.text = String(format: "%d:%02d", fokusTime / 60, fokusTime % 60)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMotion()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        releaseMotion()
    }
    
    func setupMotion() {
        UIApplication.shared.isIdleTimerDisabled = true
        motion.deviceMotionUpdateInterval = 0.1
        motion.startDeviceMotionUpdates(to: .main) { motion, error in
            let second = Int64(Date().timeIntervalSince1970)
            if second != self.lastSecond {
                self.lastSecond = Int64(Date().timeIntervalSince1970)
                if (motion?.gravity.z ?? 0) > 0.9 {
                    self.fokusForOneSecond()
                }
            }
        }
    }
    
    func releaseMotion() {
        UIApplication.shared.isIdleTimerDisabled = false
        motion.stopDeviceMotionUpdates()
    }
    
    func fokusForOneSecond() {
        fokusTime += 1
        doHeartBeat()
    }
    
    func doHeartBeat() {
        Thread {
            AudioServicesPlaySystemSound(1519)
            Thread.sleep(forTimeInterval: 0.25)
            AudioServicesPlaySystemSound(1520)
        }.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

