//
//  ContentView.swift
//  RequestingDemo Watch App
//
//  Created by Anh Lê on 10/04/2023.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var contentViewModel = ContentViewModelImpl()
  
  var body: some View {
    VStack {
      Text("\(contentViewModel.counter)")
        .font(.headline)
      Button("Start polling") {
        contentViewModel.startPolling()
      }
      Button("Start requesting") {
        contentViewModel.requestFromPhone()
      }
      Button("Stop polling") {
        contentViewModel.stopPolling()
      }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
