//
//  ViewController.swift
//  Stadia
//
//  Created by Sohel on 5/9/21.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}

