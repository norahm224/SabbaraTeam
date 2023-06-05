//
//  MotionManager.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 09/06/2023.
//

import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject {
private let motionManager = CMMotionManager()

    @Published var isPhoneInPosition = false
    @Published var isTiltedRight = false
    @Published var isTiltedLeft = false
    @Published var isCheating = false

    
    init() {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            guard let data = data else { return }

            let pitch = data.attitude.pitch
            let roll = data.attitude.roll
            let yaw = data.attitude.yaw
            
            self.isPhoneInPosition = pitch > -0.401004 && pitch < 0.2 && roll > 1.2 && roll < 2.20274 && ((yaw > 2.5 && yaw < 3.2) || (yaw > 0.2 && yaw < 1.9) || (yaw > -3.15 && yaw < -2.4))
            
            self.isTiltedRight = pitch > 0.3 && pitch < 0.9 && roll < 2 && roll > 1.2 && ((yaw > -3.2 && yaw < -2.6) || (yaw > 3 && yaw < 3.15) || (yaw > 0.8 && yaw < 2) || (yaw > 0.3 && yaw < 0.7))
            
            self.isTiltedLeft = pitch < -0.2 && pitch > -1.1 && roll < 2.1 && roll > 1.3 && ((yaw > -3.1 && yaw < -2.6) || (yaw < 3 && yaw > 2.4) || (yaw > 0.5 && yaw < 2) || (yaw > 1.1 && yaw < 3.1))
            
            self.isCheating = pitch < 0.5 && pitch > -0.2 && roll < 0.9 && roll > -1.2 && yaw > -1.4 && yaw < 1.26
        }
    }

}
