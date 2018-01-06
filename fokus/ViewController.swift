import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var tipLabel: UILabel!
    
    var isFocus = false
    
    var ticker: Ticker!
    
    var manager = CMMotionManager()
    
    var focusTime = 0 {
        didSet {
            timeLabel.text = String(format: "%d:%02d", focusTime / 60, focusTime % 60)
        }
    }
    
    override func viewDidLoad() {
        ticker = Ticker(action: self.tickerAction, interval: 1)
        manager.deviceMotionUpdateInterval = 1
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
        manager.startDeviceMotionUpdates()
        ticker.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
        manager.stopDeviceMotionUpdates()
        ticker.stop()
    }
    
    func tickerAction() {
        if manager.deviceMotion?.gravity.z ?? 0 > 0.98 {
            UIDevice.current.isProximityMonitoringEnabled = true
            focusTime += 1
            doHeartBeat()
            tipLabel.isHidden = true
        } else {
            UIDevice.current.isProximityMonitoringEnabled = false
            tipLabel.isHidden = false
        }
    }
    
    func doHeartBeat() {
        Thread {
//            AudioServicesPlaySystemSound(1519)
//            Thread.sleep(forTimeInterval: 0.25)
            if self.focusTime % 60 == 0 {
                AudioServicesPlaySystemSound(1521)
            } else {
                AudioServicesPlaySystemSound(1519)
            }
        }.start()
    }
}

