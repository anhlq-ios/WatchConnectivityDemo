//
//  WebService.swift
//  RequestingDemo Watch App
//
//  Created by Anh Lê on 11/04/2023.
//

import Foundation

protocol PollingProcessorDelegate: AnyObject {
  func pollingDidUpdate()
}

protocol PollingProcessor {
  var delegate: PollingProcessorDelegate? { get set }
  func startPolling()
  func stopPolling()
}

class PollingProcessorImpl: PollingProcessor {
  private enum Constants {
    static let timerTimeInterval: TimeInterval = 3
  }
  private var timer: Timer?
  private var phoneService: PhoneService! = PhoneSerivceImpl()
  
  weak var delegate: PollingProcessorDelegate?
  
  func startPolling() {
    fireNextTimer()
  }
  
  func stopPolling() {
    stopTimer()
  }
  
  @objc
  private func fireTimer() {
    phoneService.startRequesting { [weak self] _ in
      self?.delegate?.pollingDidUpdate()
    }
    stopTimer()
    fireNextTimer()
  }
  
  private func fireNextTimer() {
    timer = Timer.scheduledTimer(timeInterval: Constants.timerTimeInterval,
                                 target: self,
                                 selector: #selector(fireTimer),
                                 userInfo: nil,
                                 repeats: false)
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
}
