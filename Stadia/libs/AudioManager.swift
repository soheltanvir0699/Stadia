//
//  AudioManager.swift
//  Stadia
//
//  Created by Al Mujahid Khan on 6/24/21.
//

import Foundation

var frequency = 500
var durations = 1000

final class AudioManager: NSObject {
    
    let myUnit = ToneOutputUnit()
    
    func calculateToneProps(height: Int) {
        if height > 1219 {
            frequency = 270
            durations = 200
        }else if (914...1218).contains(height) {
            frequency = 510
            durations = 200
        }else if (610...914).contains(height) {
            frequency = 760
            durations = 150
        }else if (305...610).contains(height) {
            frequency = 1020
            durations = 150
        }else if (91...305).contains(height) {
            frequency = 1220
            durations = 100
        }else if (30...91).contains(height) {
            frequency = 1350
            durations = 50
        }else if (height < 30) {
            frequency = 1400
            durations = 60000
        }
    }
    func mute() {
        myUnit.setToneVolume(vol: 0.0)
    }
    
    func unMute() {
        myUnit.setToneVolume(vol: 1.0)
    }
    
    func start(height: Int = 150) {
        calculateToneProps(height: height)
        myUnit.setFrequency(freq: Double(frequency))
        myUnit.setToneVolume(vol: 1.0)
            myUnit.enableSpeaker()
        myUnit.setToneTime(t: Double(durations))
    }
    
    func stop () {
        myUnit.stop()
    }
}
