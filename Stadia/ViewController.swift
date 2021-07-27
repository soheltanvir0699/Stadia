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
    @IBOutlet weak var lblTermsCon: UILabel!
    
    @IBOutlet weak var lblInstr: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblInstr.layer.addWaghaBorder(edge: .bottom, color: UIColor.init(red: 63/255, green: 226/255, blue: 199/255, alpha: 1), thickness: 1)
        lblTermsCon.layer.addWaghaBorder(edge: .bottom, color: UIColor.init(red: 63/255, green: 226/255, blue: 199/255, alpha: 1), thickness: 1)
        Constant.IsDeviceConnect = false
        
    }
    
    func setupAudio() {
      let audioSession = AVAudioSession.sharedInstance()
        _ = try? audioSession.setCategory(AVAudioSession.Category.playback, options: .duckOthers)
      _ = try? audioSession.setActive(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}

