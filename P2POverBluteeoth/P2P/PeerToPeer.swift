//
//  PeerToPeer.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 14/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

protocol PeerToPeer {
    
    typealias PeerFoundClosureType = ((String?) -> Void)
    typealias BroadcastCallbackClosureType = ((Bool, Error?) -> Void)
    
    var isScanning: Bool {get}
    var isBroadcasting: Bool {get}
    
    func startBroadcast(callback: @escaping BroadcastCallbackClosureType)
    func scan(peerFound: @escaping PeerFoundClosureType)
    
    func stopBroadcast()
    func stopScan()
    
}
