# P2P | Peer to peer connect over bluetooth
A small library to find near by users over bluetooth.

[![Swift Version][swift-image]][swift-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Features

- [x] Scan near by users
- [x] Set visibibility to ON/OFF

## Requirements

- iOS 9.0+
- Xcode 9.0

## Installation

#### Manually
1. Download and drop ```P2P``` in your project.
2. Congratulations!  

## Usage example

```swift
// Instance of the manager
// Make sure to reatain the instance till you need to scan or enable visibility
let p2pManager: PeerToPeer = P2PManager(withName: "string to be visible over blutooth")

p2pManager.startBroadcast { (isStartedBroadcasting, error) in
  if isStartedBroadcasting {
    print("now should be visible to a scanner")
  }
}

p2pManager.scan { (foundPeerName) in
    print(foundPeerName)
}

```

## Contribute

We would love you for the contribution to **peer-to-peer-connect-over-bluetooth**.

[swift-image]:https://img.shields.io/badge/swift-4.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
