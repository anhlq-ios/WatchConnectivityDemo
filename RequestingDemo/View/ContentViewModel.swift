//
//  ContentViewModel.swift
//  RequestingDemo
//
//  Created by Anh Lê on 12/04/2023.
//

import Foundation
protocol ContentViewModel: AnyObject, ObservableObject {
  func startReceivingMessage()
}
class ContentViewModelImpl: ContentViewModel {
  private var watchService: WatchService! = WatchServiceImpl()
  @Published var message: String?
  var counter = 0
  
  func startReceivingMessage() {
    watchService.delegate = self
  }
}

extension ContentViewModelImpl: WatchServiceDelegate {
  func didReceiveMessageFromWatch() {
    counter += 1
    message = "Did receive message \(counter)"
  }
}
