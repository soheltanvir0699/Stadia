//
//  Constant.swift
//  Stadia
//
//  Created by Sohel on 25/5/21.
//

import Foundation
import SwiftyBluetooth
class Constant {
    static var Calibrate_Value: Int {
         set {
             UserDefaults.standard.set(newValue, forKey: "Calibrate_Value")
         } get {
            var str_user_value = 0
             if UserDefaults.standard.value(forKey: "Calibrate_Value") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "Calibrate_Value") as! Int
             }
             return str_user_value
         }
     }
    static var BetteryLbl: Int {
         set {
             UserDefaults.standard.set(newValue, forKey: "BetteryLbl")
         } get {
            var str_user_value = 0
             if UserDefaults.standard.value(forKey: "BetteryLbl") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "BetteryLbl") as! Int
             }
             return str_user_value
         }
     }
    static var HEIGHT_OFFSET: Int {
         set {
             UserDefaults.standard.set(newValue, forKey: "HEIGHT_OFFSET")
         } get {
            var str_user_value = 0
             if UserDefaults.standard.value(forKey: "HEIGHT_OFFSET") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "HEIGHT_OFFSET") as! Int
             }
             return str_user_value
         }
     }
    static var IsDeviceConnect: Bool {
         set {
             UserDefaults.standard.set(newValue, forKey: "IsDeviceConnect")
         } get {
            var str_user_value = false
             if UserDefaults.standard.value(forKey: "IsDeviceConnect") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "IsDeviceConnect") as! Bool
             }
             return str_user_value
         }
     }
    static var seekbarValue: Int {
         set {
             UserDefaults.standard.set(newValue, forKey: "seekbarValue")
         } get {
            var str_user_value = 0
             if UserDefaults.standard.value(forKey: "seekbarValue") != nil {
                str_user_value = UserDefaults.standard.value(forKey: "seekbarValue") as! Int
             }
            return str_user_value
         }
     }
    static var SoundAlert: Bool {
         set {
             UserDefaults.standard.set(newValue, forKey: "SoundAlert")
         } get {
            var str_user_value = false
             if UserDefaults.standard.value(forKey: "SoundAlert") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "SoundAlert") as! Bool
             }
             return str_user_value
         }
     }
    static var isMetricMeasurement: Bool {
         set {
             UserDefaults.standard.set(newValue, forKey: "isMetricMeasurement")
         } get {
            var str_user_value = false
             if UserDefaults.standard.value(forKey: "isMetricMeasurement") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "isMetricMeasurement") as! Bool
             }
             return str_user_value
         }
     }
    static var dataCommand: String {
         set {
             UserDefaults.standard.set(newValue, forKey: "active_Value")
         } get {
            var str_user_value = "0"
             if UserDefaults.standard.value(forKey: "active_Value") != nil {
                 str_user_value = UserDefaults.standard.value(forKey: "active_Value") as! String
             }
             return str_user_value
         }
     }
    static var PeripheralDevice: SwiftyBluetooth.Peripheral {
         set {
             UserDefaults.standard.set(newValue, forKey: "PeripheralDevice")
         } get {
            var str_user_value:SwiftyBluetooth.Peripheral? = nil
             if UserDefaults.standard.value(forKey: "PeripheralDevice") != nil {
                str_user_value = UserDefaults.standard.value(forKey: "PeripheralDevice") as? SwiftyBluetooth.Peripheral
             }
            return str_user_value!
         }
     }
    
    static var writeUUID = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    static var notifyUUID = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
    static var serviceUUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
}
