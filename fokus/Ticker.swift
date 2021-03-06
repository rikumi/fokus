import Foundation
import UIKit

class Ticker: NSObject {
    var action: (() -> Void)?
    
    var running = false
    
    var interval: TimeInterval
    
    init(action: (() -> Void)?, interval: TimeInterval) {
        self.action = action
        self.interval = interval
    }
    
    func start() {
        if !running {
            running = true
            _action()
        }
    }
    
    func stop() {
        running = false
    }
    
    @objc func _action() {
        if running {
            action?()
            perform(#selector(self._action), with: nil, afterDelay: interval)
        }
    }
}
