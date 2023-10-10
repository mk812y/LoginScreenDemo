//
//  ContentView.swift
//  LoginScreenDemo
//
//  Created by Михаил Куприянов on 10.10.23..
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = LoginViewModel() //объявим экземпляр viewModel
    
    var body: some View {
        if !viewModel.authenticated {
            LoginView(viewModel: viewModel)
        } else {
            VStack {
                Text("Hello, \(viewModel.user.name)!")
                    .font(.largeTitle)
                Button("Log Out") {
                    viewModel.logOut()
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
