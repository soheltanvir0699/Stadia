//
//  StadiaService.swift
//  Stadia
//
//  Created by Sohel on 31/5/21.
//

import Foundation
import UIKit

class StadiaService {
    var audioManager = AudioManager()
    static var stadiaService = StadiaService()
    func callNotification(bettery: String, distance: String) {
        calulateData(battery: bettery, distance: distance)
    }
    func calulateData(battery:String, distance: String?) {
        if distance!.count != 0 && !distance!.contains("STANDBY") {
            if distance == "1" {
                let heightAlert = isHeightAlert(heightInt: Int(distance!.trimmingCharacters(in: .whitespacesAndNewlines))!)
                NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": heightAlert.first, "distance": "UNKNOWN", "battery": battery])
                audioManager.stop()
            }else {
                let heightAlert = isHeightAlert(heightInt: Int(distance!.trimmingCharacters(in: .whitespacesAndNewlines))!)
                NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": heightAlert.first, "distance": String(format: "%0.1f", heightAlert.second), "battery": battery])
                if(heightAlert.first){
                    if distance != nil {
                        let distanceInCm = getHeightAfterCalibrate(heightInt: Int(distance!.trimmingCharacters(in: .whitespacesAndNewlines))!)
//                        audioManager.stop()
                        print("start sound")
                        audioManager.start(height: distanceInCm)
                    }
                    else {
                        print("distance nil")
                    }
                    
                    
                }else {
                    print("stop sound")
                    audioManager.stop()
                }
            }
        }else {
            NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": false, "distance": distance, "battery": battery])
        }
    }
    func isHeightAlert(heightInt: Int)-> Pair {
        print("view alert",heightInt)
        if Constant.isMetricMeasurement {
            let i = Double(heightInt-Constant.HEIGHT_OFFSET) / 100
            return i<0 ? Pair(first: true, second: 0.0) : Pair(first: i <= Double(Constant.seekbarValue) ? true:false, second: i)
            
        }else {
            let i = ((Double(heightInt) / 2.54) - Double(Constant.HEIGHT_OFFSET))/12.0
            return i<0 ? Pair(first: true, second: 0.0) : Pair(first: i <= Double(Constant.seekbarValue) ? true:false, second: i)
        }
    }
    
    func getHeightAfterCalibrate(heightInt: Int) -> Int {
        return Int(Constant.isMetricMeasurement == true ? (Double(heightInt) - Double(Constant.HEIGHT_OFFSET)) : (((Double(heightInt)/2.54) - Double(Constant.HEIGHT_OFFSET)) * 2.54))
    }
}

extension Notification.Name {
    static let sendData = Notification.Name("sendData")
    static let Stop = Notification.Name("Stop")
}
