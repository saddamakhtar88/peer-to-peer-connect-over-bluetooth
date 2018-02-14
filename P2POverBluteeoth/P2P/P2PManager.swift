//
//  P2PManager.swift
//  P2POverBluteeoth
//
//  Created by Saddam on 14/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

class P2PManager: NSObject, PeerToPeer {
    
    private static let serviceID: CBUUID = CBUUID(string: "42EE2599-360F-4D09-8D4A-A1D9B4F9B320")
    
    private var centralManager: CBCentralManager?
    private var peripheralManager: CBPeripheralManager?
    
    private var centralManagerStateChanged: ((CBManagerState)->Void)?
    private var peripheralManagerStateChanged: ((CBManagerState)->Void)?
    
    
    fileprivate var peerFound: PeerFoundClosureType?
    fileprivate var broadcastCallback: BroadcastCallbackClosureType?
    
    private var scanStatus: ((Bool, Error?) -> Void)?
    
    private let name: String
    
    init(withName name: String) {
        self.name = name
    }
    
    var isBroadcasting: Bool {
        return peripheralManager?.isAdvertising ?? false
    }
    
    var isScanning: Bool {
        return centralManager?.isScanning ?? false
    }
    
    func startBroadcast(callback: @escaping BroadcastCallbackClosureType) {
        peripheralManager?.stopAdvertising()
        peripheralManager = CBPeripheralManager(delegate: self,
                                                queue: nil)
        peripheralManagerStateChanged = { [weak self] state in
            if state == .poweredOn {
                self?.broadcastCallback = callback
                self?.peripheralManager?.startAdvertising([CBAdvertisementDataLocalNameKey : self!.name,
                                                           CBAdvertisementDataServiceUUIDsKey: [P2PManager.serviceID]])
            }
        }
    }
    
    func stopBroadcast() {
        peripheralManager?.stopAdvertising()
    }
    
    func scan(peerFound: @escaping PeerFoundClosureType) {
        centralManager?.stopScan()
        centralManager = CBCentralManager(delegate: self,
                                          queue: nil)
        
        centralManagerStateChanged = { [weak self] state in
            if state == .poweredOn {
                self?.peerFound = peerFound
                self?.centralManager!.scanForPeripherals(withServices: [P2PManager.serviceID],
                                                         options: nil)
            }
        }
    }
    
    func stopScan() {
        centralManager?.stopScan()
    }
    
}

extension P2PManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralManagerStateChanged?(central.state)
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        
        peerFound?(peripheral.name)
    }
    
}

extension P2PManager: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        peripheralManagerStateChanged?(peripheral.state)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        broadcastCallback?(error == nil , error)
    }
}
