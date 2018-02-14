//
//  ViewController.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 14/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnVisibility: UIButton!
    @IBOutlet weak var btnScan: UIButton!
    
    @IBOutlet weak var lblFoundNames: UILabel!
    
    let p2pManager: PeerToPeer = P2PManager(withName: UIDevice.current.name)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = UIDevice.current.name
        self.btnVisibility.setTitle("Visibility - OFF", for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnScan_Tapped(_ sender: UIButton) {
        
        p2pManager.scan { (peerName) in
            guard peerName != nil else {return}
            self.lblFoundNames.text = (self.lblFoundNames.text?.isEmpty == true ? "Found\n" : self.lblFoundNames.text!) + "\n" + peerName!
        }
        
    }
    
    @IBAction func btnVisibility_tapped(_ sender: UIButton) {
        if p2pManager.isBroadcasting {
            p2pManager.stopBroadcast()
            self.btnVisibility.setTitle("Visibility - OFF", for: .normal)
        } else {
            p2pManager.startBroadcast { (isStartedBroadcasting, error) in
                if isStartedBroadcasting {
                    self.btnVisibility.setTitle("Visibility - ON", for: .normal)
                } else {
                    self.btnVisibility.setTitle("Visibility - Error", for: .normal)
                }
            }
        }
    }
    
    
}

