//
//  SettingsViewController.swift
//  Stadia
//
//  Created by Sohel on 5/10/21.
//

import UIKit
import AVFoundation
import UICheckbox_Swift
class SettingsViewController: UIViewController {

    @IBOutlet weak var btnImp: radioButton!
    @IBOutlet weak var lblSlider: UILabel!
    @IBOutlet weak var checkBOx: UICheckbox!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnMet: radioButton!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if Constant.isMetricMeasurement {
            btnMet.radioSelected = true
            btnImp.radioSelected = false
        }else {
            btnMet.radioSelected = false
            btnImp.radioSelected = true
        }
        checkBOx.isSelected = Constant.SoundAlert
        slider.value = Float(Constant.seekbarValue)/100.0
        lblSlider.text = "\(Int(Constant.seekbarValue))"
        checkBOx.onSelectStateChanged = { (checkbox, selected) in
            print("Clicked - \(selected)")
            Constant.SoundAlert = selected
        }
    }
    

    func playSound() {
        guard let url = Bundle.main.url(forResource: "stadiaexample", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    @IBAction func playBtnAction(_ sender: Any) {
        player?.stop()
        playSound()
        
    }
    
    
    @IBAction func immetAct(_ sender: Any) {
        btnMet.radioSelected = false
        btnImp.radioSelected = true
        Constant.isMetricMeasurement = false
        print(Constant.isMetricMeasurement)
        
    }
    @IBAction func metAct(_ sender: Any) {
        btnMet.radioSelected = true
        btnImp.radioSelected = false
        Constant.isMetricMeasurement = true
        print(Constant.isMetricMeasurement)
    }
    @IBAction func metAction(_ sender: radioButton) {
//        btnMet.radioSelected = false
    }
    @IBAction func immetAction(_ sender: radioButton) {
//        btnImp.radioSelected = true
//        print("dddd")
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        print(sender.value)
        lblSlider.text = "\(Int(sender.value*100))"
        Constant.seekbarValue = Int(sender.value * 100)
        
    }
    
}
