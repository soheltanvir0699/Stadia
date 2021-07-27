//
//  StadiaService.swift
//  Stadia
//
//  Created by Sohel on 31/5/21.
//

import Foundation
import UIKit

class StadiaService {
    var slowDownAudioPlayerCount = 8
    var audioManager = AudioManager()
    static var stadiaService = StadiaService()
    func callNotification(bettery: String, distance: String) {
        calulateData(battery: bettery, distance: distance)
    }
    func calulateData(battery:String, distance: String?) {
        
        if distance!.count != 0 && !distance!.contains("STANDBY") {
            if distance == "1" {
                let heightAlert = isHeightAlert(heightInt: Int(distance!)!)
                NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": heightAlert.first, "distance": "UNKNOWN", "battery": battery])
                audioManager.stop()
            }else {
                let heightAlert = isHeightAlert(heightInt: Int(distance!)!)
                NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": heightAlert.first, "distance": String(format: "%0.1f", heightAlert.second), "battery": battery])
                print(heightAlert)
                if heightAlert.first{
                    if distance != nil {
                        if Constant.dataCommand == "0"{
                            let distanceInCm = getHeightAfterCalibrate(heightInt: Int(distance!.trimmingCharacters(in: .whitespacesAndNewlines))!)
    //                        audioManager.stop()
                            print("start sound")
                            if slowDownAudioPlayerCount < 7 {
                                slowDownAudioPlayerCount += 1
                            }else {
                                if Constant.SoundAlert {
                                audioManager.start(height: distanceInCm)
                                }else {
                                    audioManager.stop()
                                }
                                slowDownAudioPlayerCount = 0
                            }
                            
                        }else {
                            audioManager.stop()
                        }
                        
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
            audioManager.stop()
            NotificationCenter.default.post(name: .sendData, object: nil, userInfo: ["isAlert": false, "distance": distance, "battery": battery])
            
        }
    }
    func isHeightAlert(heightInt: Int)-> Pair {
        print("view alert",heightInt)
        
        if Constant.isMetricMeasurement {
            let i = (Double(heightInt-Constant.HEIGHT_OFFSET) / 100.0)
            if i < 0  {
                return Pair(first: true, second: 0.0)
            }else {
                if i <= Double(Constant.seekbarValue) {
                    return Pair(first: true, second: i)
                }else {
                    return Pair(first: false, second: i)
                }
            }
            
        }else {
            let i = ((Double(String(format: "%.1f", (Double(heightInt) / 2.54)))! - Double(Constant.HEIGHT_OFFSET))/12.0)
            if i<0 {
                return Pair(first: true, second: 0.0)
            }else {
                if i <= Double(Constant.seekbarValue) {
                    return Pair(first: true, second: i)
                }else {
                    return Pair(first: false, second: i)
                }
            }
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
