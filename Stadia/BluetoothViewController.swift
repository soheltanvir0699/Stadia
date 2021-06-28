//
//  BluetoothViewController.swift
//  Stadia
//
//  Created by Sohel on 5/10/21.
//

import UIKit
import CoreBluetooth
import SwiftyBluetooth

class BluetoothViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, DeviceScannedDelegate {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var connectLbl: UILabel!
    @IBOutlet weak var cancelBtn: BXButton!
    var bluetoothAvailable = false
    @IBOutlet weak var connectImg: UIImageView!
    @IBOutlet weak var lblCalibrate: UILabel!
    @IBOutlet weak var offserLbl: UILabel!
    var centralManager: CBCentralManager!
    var CBPeripheralArray = [SwiftyBluetooth.Peripheral]()
    @IBOutlet weak var manulFld: UITextField!
    var rssiArray = [Int]()
    var countLbl = 0
    var bluefruitPeripheral:CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scanDevice)))
        BLEManager.getSharedBLEManager().initCentralManager(queue: DispatchQueue.main, options: nil)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Constant.IsDeviceConnect {
            self.connectLbl.text = "Connected"
            connectLbl.textColor = UIColor.green
        }else {
            self.connectLbl.text = "Tap button to connect to STADIA via BlueTooth"
            connectLbl.textColor = UIColor.red
        }
        if Constant.isMetricMeasurement {
            manulFld.placeholder = "CM"
            offserLbl.text = "Current Offset In Centimeters"
        }else {
            manulFld.placeholder = "Inches"
            offserLbl.text = "Current Offset In Inches"
        }
        print(Constant.IsDeviceConnect)
    }
    
    func calibrateAction () {
        let calibrateValue = Constant.Calibrate_Value
        if Constant.isMetricMeasurement {
            lblCalibrate.text = "\(calibrateValue)"
            Constant.HEIGHT_OFFSET = calibrateValue
        }else {
            lblCalibrate.text = cenToInc(cen: Double(calibrateValue))
            Constant.HEIGHT_OFFSET = Int((Double(calibrateValue)/2.5).rounded())
        }
        
        
    }
    func cenToInc(cen: Double) -> String {
        return String(format: "%.2f", (cen/2.5).rounded())
    }
    @IBAction func calibrateAction(_ sender: Any) {
        calibrateAction()
    }
    @objc func scanDevice() {
        print("Started Scanning!")
        //Could add service UUID here to scan for only relevant services
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        SwiftyBluetooth.scanForPeripherals(withServiceUUIDs: nil, timeoutAfter: 15) { [self] scanResult in
            switch scanResult {
            case .scanStarted:
                break
                    // The scan started meaning CBCentralManager scanForPeripherals(...) was called
                case .scanResult(let peripheral, let advertisementData, let RSSI):
                    print(peripheral.name)
                    print("ad", advertisementData)
                    print("rss", RSSI)
                    print("per", peripheral)
                    if self.CBPeripheralArray.count == 0 {
                        self.CBPeripheralArray.append(peripheral)
                        self.rssiArray.append(RSSI!)
                    }else {
                        for (i,cdArr) in self.CBPeripheralArray.enumerated() {
                        if cdArr.identifier == peripheral.identifier {
                            rssiArray[i] = RSSI!
                            tblView.reloadData()
                            tblView.isHidden = false
                            cancelBtn.isHidden = false
                            return
                        }else {

                        }
                    }
                        CBPeripheralArray.append(peripheral)
                        rssiArray.append(RSSI!)
                    }
                    
                    tblView.reloadData()
                    tblView.isHidden = false
                    cancelBtn.isHidden = false
                    // A peripheral was found, your closure may be called multiple time with a .ScanResult enum case.
                    // You can save that peripheral for future use, or call some of its functions directly in this closure.
            
                case .scanStopped(let error):
                    print(error)
                    // The scan stopped, an error is passed if the scan stopped unexpectedly
            }
        }
        
}
    @IBAction func cancelAction(_ sender: Any) {
        tblView.isHidden = true
        cancelBtn.isHidden = true
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Checking state")
        switch (central.state) {
        case .poweredOff:
            print("CoreBluetooth BLE hardware is powered off")
            
        case .poweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            bluetoothAvailable = true;
//            centralManager.scanForPeripherals(withServices: nil, options: nil)
            
        case .resetting:
            print("CoreBluetooth BLE hardware is resetting")
            
        case .unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
            
        case .unknown:
            print("CoreBluetooth BLE state is unknown");
            
        case .unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform");
            
        @unknown default:
            print("not found")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {


      }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(peripheral.state)
        if peripheral.state == .connected {
//            tblView.isHidden = true
//            cancelBtn.isHidden = true
            connectLbl.text = "Connected"
            connectLbl.textColor = UIColor.green
        }else {
//            tblView.isHidden = true
//            cancelBtn.isHidden = true
            connectLbl.text = "Tap button to connect to STADIA via BlueTooth"
            connectLbl.textColor = UIColor.red
        }
        
        
        
        peripheral.discoverServices([CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")])
        
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(error, peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
        peripheral.setNotifyValue(true, for: characteristic)
       
    }
    
}

extension BluetoothViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CBPeripheralArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if CBPeripheralArray[indexPath.row].name == nil {
            cell?.textLabel?.text = "No Name & \(rssiArray[indexPath.row])"
        }else {
            cell?.textLabel?.text = (CBPeripheralArray[indexPath.row].name ??  "No Name") + " & \(rssiArray[indexPath.row])"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        bluefruitPeripheral = CBPeripheralArray[indexPath.row]
//            bluefruitPeripheral.delegate = self
//        centralManager.connect(bluefruitPeripheral, options: nil)
        CBPeripheralArray[indexPath.row].connect(withTimeout: 5) { result in
            print(result)
            switch result {
            
            case .success:
                self.tblView.isHidden = true
                Constant.IsDeviceConnect = true
                self.cancelBtn.isHidden = true
                self.connectLbl.text = "Connected"
                self.connectLbl.textColor = UIColor.green
                self.getNotifed(somePeripheral: self.CBPeripheralArray[indexPath.row])
//                DispatchQueue.main.async {
//                    Thread.sleep(forTimeInterval: 0.150)
//
//                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.150) {
                   /*Do something after 0.002 seconds have passed*/
                    self.sendData(per: self.CBPeripheralArray[indexPath.row])
                }
                
//                Constant.PeripheralDevice = self.CBPeripheralArray[indexPath.row]
                
                self.CBPeripheralArray[indexPath.row].discoverServices(withUUIDs: nil) { result in
                    print("result", result)
                    switch result {
                    case .success(let services):
                        print(services, "service")
                        self.CBPeripheralArray[indexPath.row].setNotifyValue(toEnabled: true, forCharacWithUUID: Constant.notifyUUID, ofServiceWithUUID: Constant.serviceUUID) { (result) in
                            switch result {
                            case .success(let isNotifying):
                                print("isnotitifa",isNotifying)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    case .failure(let error):
                        print(error, "error")
                    }
                }
            case .failure(let error):
                Constant.IsDeviceConnect = false
                self.tblView.isHidden = true
                self.cancelBtn.isHidden = true
                self.connectLbl.text = "Tap button to connect to STADIA via BlueTooth"
                self.connectLbl.textColor = UIColor.red
            }
        }
    }
   
    private func sendData(per: SwiftyBluetooth.Peripheral) {
//        NotificationCenter.default.post(name: .sendData, object: nil)
            // Put your code which should be executed with a delay here
//            if Constant.dataCommand == "0" {
//                DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(200), execute: {
                if countLbl > 40 {
                    do {
                        print("write value",Constant.dataCommand)
                            let d = try self.writeValue(somePeripheral: per, dataString: Constant.dataCommand)
                        countLbl = 0
                        
                    }catch _ {
                        print("err")
                    }
                }else {
                    countLbl += 1
                }
                   
//                })
                
//            }else {
////                DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500), execute: {
//                DispatchQueue.global().async {
//                    do{
//
//                        _ = try self.writeValue(somePeripheral: per, dataString: Constant.dataCommand)
//                    }catch _ {
//                        print("err")
//                    }
//                        print(Constant.dataCommand)
//                }
//
//
//
////                })
//
//            }
        
        
    }
    
    func writeValue(somePeripheral:SwiftyBluetooth.Peripheral, dataString: String) throws -> Bool {
        let data = String(dataString).data(using: String.Encoding.utf8)!
        somePeripheral.writeValue(ofCharacWithUUID: Constant.writeUUID,
                                  fromServiceWithUUID: Constant.serviceUUID,
                              value: data) { result in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
                somePeripheral.disconnect { result in
                    print(result)
                    self.connectLbl.text = "Tap button to connect to STADIA via BlueTooth"
                    self.connectLbl.textColor = UIColor.red
                }
//                DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(100), execute: {
//                self.writeValue(somePeripheral: somePeripheral, dataString: dataString)
//                }) // An error happened while writting the data.
            }
        }
        return true
    }
    
    func getNotifed(somePeripheral:SwiftyBluetooth.Peripheral) {
        let peripheral = somePeripheral

        NotificationCenter.default.addObserver(forName: Peripheral.PeripheralCharacteristicValueUpdate,
                                                object: peripheral,
                                                queue: nil) { (notification) in
            let charac = notification.userInfo!["characteristic"] as! CBCharacteristic
            if charac.value?.count != 0 {
                
                var stringResponse = String(bytes: charac.value!, encoding: .utf8)!
                if stringResponse.contains("|") {
                   var splitValue = stringResponse.split(separator: "|")
                    StadiaService.stadiaService.callNotification(bettery: "\(splitValue[1])", distance: String(splitValue[0]))
                    
                    Constant.Calibrate_Value = Int(splitValue[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                    Constant.BetteryLbl = Int(splitValue[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                    
                    self.sendData(per: somePeripheral)
                }
                
            }
            
            
            if let error = notification.userInfo?["error"] as? SBError {
                // Deal with error
                print("error", error)
            }
        }
    }
    
    
}

