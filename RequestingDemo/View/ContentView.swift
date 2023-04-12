//
//  ContentView.swift
//  RequestingDemo
//
//  Created by Anh Lê on 10/04/2023.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = ContentViewModelImpl()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Text(viewModel.message ?? "Hello, world!")
        }
        .padding()
        .onAppear {
          viewModel.startReceivingMessage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
