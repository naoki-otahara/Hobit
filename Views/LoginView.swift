import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ログイン")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding(.top, 40)
            
            // メールアドレス入力
            TextField("メールアドレス", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            // パスワード入力
            SecureField("パスワード", text: $password)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            // ログインボタン
            Button(action: {
                if UserDatabase.shared.loginUser(email: email, password: password) {
                    alertMessage = "ログイン成功でゲス！！！"
                } else {
                    alertMessage = "ログイン失敗でゲス！？"
                }
                showingAlert = true
            }) {
                Text("ログインする")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.horizontal, 30)
            }
            
            Spacer().frame(height: 20)
            
            // 新規登録画面へのリンク
            NavigationLink(destination: RegistrationView()) {
                Text("アカウントをお持ちでないですか！？")
                    .foregroundColor(.black)
                    .underline()
            }
            
            Spacer()
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
