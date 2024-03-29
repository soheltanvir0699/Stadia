//
//  ViewController.swift
//  Stadia
//
//  Created by Sohel on 5/9/21.
//

import UIKit
import AVKit
import CoreAudio

class ViewController: UIViewController {
//    @IBOutlet weak var lblTermsCon: UILabel!
    
    @IBOutlet weak var lblInstr: UIButton!
    @IBOutlet weak var lblTermsCon: UIButton!
//    @IBOutlet weak var lblInstr: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblInstr.layer.addWaghaBorder(edge: .bottom, color: UIColor.init(red: 63/255, green: 226/255, blue: 199/255, alpha: 1), thickness: 1)
        lblTermsCon.layer.addWaghaBorder(edge: .bottom, color: UIColor.init(red: 63/255, green: 226/255, blue: 199/255, alpha: 1), thickness: 1)
        Constant.IsDeviceConnect = false
        
    }
    
    @IBAction func termsAndCondition(_ sender: Any) {
        let rateUrl = "https://skeeterenterprises.com/terms-and-conditions"
        if UIApplication.shared.canOpenURL(URL.init(string: rateUrl)!) {
            UIApplication.shared.open(URL.init(string: rateUrl)!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func instruction(_ sender: Any) {
        let rateUrl = "https://skeeterenterprises.com/stadia-instructions"
        if UIApplication.shared.canOpenURL(URL.init(string: rateUrl)!) {
            UIApplication.shared.open(URL.init(string: rateUrl)!, options: [:], completionHandler: nil)
        }
    }
    func setupAudio() {
      let audioSession = AVAudioSession.sharedInstance()
        _ = try? audioSession.setCategory(AVAudioSession.Category.playback, options: .duckOthers)
      _ = try? audioSession.setActive(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}

