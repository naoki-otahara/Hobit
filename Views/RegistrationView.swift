import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            Text("新規会員登録")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding(.top, 40)
            
            Spacer().frame(height: 30)
            
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
            
            // パスワード(確認)入力
            SecureField("パスワード(確認)", text: $confirmPassword)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            Spacer().frame(height: 20)
            
            // 登録ボタン
            Button(action: {
                // パスワードの一致チェック
                if password != confirmPassword {
                    alertMessage = "パスワードが一致しません！？"
                    showingAlert = true
                    return
                }
                
                // ユーザー登録処理
                if UserDatabase.shared.registerUser(email: email, password: password) {
                    alertMessage = "登録成功でゲス！！！"
                } else {
                    alertMessage = "既に登録済みのメールアドレスです！？"
                }
                showingAlert = true
            }) {
                Text("登録する")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.horizontal, 30)
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
