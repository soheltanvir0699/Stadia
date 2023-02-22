//
//  HeightViewController.swift
//  Stadia
//
//  Created by Sohel on 5/9/21.
//

import UIKit

class HeightViewController: UIViewController {

    @IBOutlet weak var btryLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var btrView: BatteryIndicator!
    @IBOutlet weak var betterCondition: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(getData(_:)), name: .sendData, object: nil)
    }
    @objc func getData(_ notification: Notification) {
        print("get data lllll")
        guard let isAlert = notification.userInfo?["isAlert"] as? Bool else{
          // do something with your is alert
            return
          }
        guard let distance = notification.userInfo?["distance"] as? String else{
          // do something with your distance
            return
          }
        guard let battery = notification.userInfo?["battery"] as? String else{
          // do something with your battery
            return
          }
        if !distance.isEmpty {
            
            print(battery)
            let mbattery = Double(battery.trimmingCharacters(in: .whitespacesAndNewlines))
            btrView.precentCharged = (mbattery!)
            if distance.contains("STANDBY") {
                heightLbl.text = distance
                betterCondition.isHidden = true
            }else {
                if isAlert {
                    
                }else {
                    betterCondition.isHidden = true
                }
                heightLbl.text = ""+distance
            }
        }else {
            
        }
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        btrView.precentCharged = Double(Constant.BetteryLbl)
        btrView.animatedReveal = true
        
    }
    
    @IBAction func activeModeAction(_ sender: Any) {
        Constant.dataCommand = "0"
    }
    
    @IBAction func standByAction(_ sender: Any) {
        Constant.dataCommand = "1"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
