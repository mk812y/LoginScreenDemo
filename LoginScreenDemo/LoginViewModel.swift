//
//  LoginViewModel.swift
//  LoginScreenDemo
//
//  Created by Михаил Куприянов on 10.10.23..
//

import Observation
import SwiftUI

@Observable //добавим макрос для отслеживания изменений в св-вах класса и обновлять интерфейс при изменении этих значений
final class LoginViewModel {
    var user = User()
    var authenticated = false //для отслеживания входа пользователя
    
    private var sampleUsername = "Username"
    private var samplePassword = "Password"
    
    var isLogginButtonDisabled: Bool { //вынесем эту логику из View в данную ViewModel - LoginViewModel
        user.name.isEmpty || user.password.isEmpty
    }
    
    func logIn () {
        guard user.name == sampleUsername, user.password == samplePassword else {
            return
        }
        toggleAuthentication()
//        withAnimation { заменим дубли на
//            authenticated.toggle()
//        }
    }
    
    func logOut() {
        user.name = ""
        user.password = ""
        toggleAuthentication()
//        withAnimation {
//            authenticated.toggle()
//        }
    }
    
    private func toggleAuthentication() {
        withAnimation {
            authenticated.toggle()
        }
    }
}
