//
//  LoginView.swift
//  LoginScreenDemo
//
//  Created by Михаил Куприянов on 10.10.23..
//

import SwiftUI
struct LoginView: View {
    @Bindable var viewModel: LoginViewModel //обертка Bindable позволит передавать в св-ва viewModel текстовые поля
//    @State private var username = ""  после создания модели, эти 3 св-ва нам уже не нужны
//    @State private var password = ""
//    private var isLoginButtonDisabled: Bool {
//        username.isEmpty || password.isEmpty
//    }
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.03)
                .ignoresSafeArea()
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 100)
                VStack(spacing: 15) {
//                    TextField("Username", text: $username) //после появления LoginViewModel передадим уже поля модели
                    TextField("Username", text: $viewModel.user.name)
                        .customStyle()
    //                    .padding()                                        //специально оставил закоментированным
    //                    .frame(width: 300)                                //чтобы яснее было понятно
    //                    .background(.gray.opacity(0.1))                   //зачем был создан customStyle
    //                    .clipShape(RoundedRectangle(cornerRadius: 15))    //и TFStyleViewModifier
//                    SecureField("Password", text: $password)
                    SecureField("Password", text: $viewModel.user.password)
                        .customStyle()
    //                    .padding()
    //                    .frame(width: 300)
    //                    .background(.gray.opacity(0.1))
    //                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding()
//                ButtonView(isDisabled: isLoginButtonDisabled) { //extract SubView //также поменяем на св-ва из LoginViewModel
                ButtonView(isDisabled: viewModel.isLogginButtonDisabled) {
                    viewModel.logIn()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
//создали кастомный модификатор
struct TFStyleViewModifier: ViewModifier { //заменяем дублирование кода для TextField и SecureField тк они одинаковые и два раза писать код и дублировать его плохо, поэтому создаем свой модификатор для полей
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 300)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
//сделаем его расширением для возможности использовать как стиль полей
extension View {
    func customStyle() -> some View {
        modifier(TFStyleViewModifier())
    }
}

struct ButtonView: View {
    let isDisabled: Bool
    let action: () -> Void //добавим тут action для кнопки, как ничего не принимающее и отдающее замыкание, чтобы при инициализации кнопки, развернуть это замыкание и прописать в нем какое либо действие
    
    var body: some View {
        Button(action: action) {
            Text("Sign In")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
        }
        .frame(width: 300, height: 60)
        .background(
            LinearGradient(
                colors: isDisabled ? [.gray.opacity(0.5)] : [.orange, .blue.opacity(0.5)],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .disabled(isDisabled)
    }
}
