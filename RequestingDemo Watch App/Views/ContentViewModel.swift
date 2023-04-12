//
//  ContentViewModel.swift
//  RequestingDemo Watch App
//
//  Created by Anh Lê on 11/04/2023.
//

import Foundation

protocol ContentViewModel: AnyObject, ObservableObject {
  var counter: Int { get }
  func startPolling()
  func stopPolling()
  func requestFromPhone()
}

class ContentViewModelImpl: ContentViewModel {
  private var pollingProcessor: PollingProcessor! = PollingProcessorImpl()
  private var phoneService: PhoneService! = PhoneSerivceImpl()
  
  @Published var counter: Int = 0
  
  func startPolling() {
    pollingProcessor.delegate = self
    pollingProcessor.startPolling()
  }
  
  func stopPolling() {
    counter = 0
    pollingProcessor.stopPolling()
  }
  func requestFromPhone() {
    phoneService.startRequesting { [weak self] data in
      DispatchQueue.main.async {
        self?.counter += 1
      }
    }
  }
}

extension ContentViewModelImpl: PollingProcessorDelegate {
  func pollingDidUpdate() {
    counter += 1
  }
}
