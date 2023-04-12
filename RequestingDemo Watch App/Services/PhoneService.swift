//
//  PhoneService.swift
//  RequestingDemo Watch App
//
//  Created by Anh Lê on 12/04/2023.
//

import Foundation
import WatchConnectivity

protocol PhoneServiceDelegate {
  
}

protocol PhoneService: AnyObject {
  func startRequesting(_ requestHandler: (([String: Any]) ->Void)?)
  func stopRequesting()
}

class PhoneSerivceImpl: NSObject, PhoneService {
  private let session = WCSession.default
  
  func startRequesting(_ requestHandler: (([String: Any]) ->Void)?) {
    //
    if WCSession.isSupported() {
      session.delegate = self
      session.activate()
    }
    session.sendMessage(["Demo": 1], replyHandler: requestHandler)
  }
  func stopRequesting() {
    //
  }
}

extension PhoneSerivceImpl: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    print("Session did active to state \(activationState) with error \(error?.localizedDescription ?? "")")
  }
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    print("Reachability did change to \(session.isReachable)")
  }
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    print("Watch did receive message from iPhone \(message)")
  }
}
