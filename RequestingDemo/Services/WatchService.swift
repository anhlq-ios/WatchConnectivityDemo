//
//  WatchService.swift
//  RequestingDemo
//
//  Created by Anh Lê on 12/04/2023.
//

import Foundation
import WatchConnectivity

protocol WatchServiceDelegate: AnyObject {
  func didReceiveMessageFromWatch()
}
protocol WatchService {
  var delegate: WatchServiceDelegate? { get set }
}

class WatchServiceImpl: NSObject, WatchService {
  
  weak var delegate: WatchServiceDelegate?
  
  private let session = WCSession.default
  
  override init() {
    super.init()
    if (WCSession.isSupported()) {
        session.delegate = self
        session.activate()
    }
  }
}

extension WatchServiceImpl: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    if let message = message["Demo"] as? Int {
      replyHandler(["Phone": message])
      delegate?.didReceiveMessageFromWatch()
    }
  }
}
