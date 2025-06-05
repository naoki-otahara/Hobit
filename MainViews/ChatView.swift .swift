import SwiftUI

struct ChatView: View {
    let userName: String
    
    // チャット履歴（仮）
    @State private var chatHistory: [ChatBubble] = [
        ChatBubble(isMe: false, text: "こんばんは"),
        ChatBubble(isMe: true,  text: "こんばんはは"),
        ChatBubble(isMe: false, text: "おしゃべりしたいです、\n！")
    ]
    @State private var message: String = ""
    
    // プッシュ通知パネルを表示するフラグ
    @State private var showPushNotice = true
    
    // Navigationを戻るためにEnvironment変数を使う
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // 上部バー
            HStack {
                // ◀︎ ボタン（押したら前の画面(DMHumanView)に戻る）
                Button(action: {
                    // これで前の画面に戻る
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(.blue) // 色はお好みで
                }
                
                Spacer()
                
                // ユーザーアイコン & 名前
                VStack(spacing: 2) {
                    // アイコン
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text(userName.prefix(1)) // 1文字だけ
                                .font(.headline)
                                .foregroundColor(.black)
                        )
                    // 名前
                    Text(userName)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                // ビデオ通話ボタン
                Image(systemName: "video.fill")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
                
                // その他メニューボタン
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            
            Divider()
            
            // 通知を促すパネル
            if showPushNotice {
                VStack {
                    Text("\(userName)さんが返信したら通知を受け取れるよ")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.top, 8)
                    Text("メッセージが届いたらすぐわかるように通知をオンにしよう")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    
                    Button(action: {
                        // 通知許可を求めるアクション
                    }) {
                        Text("プッシュ通知を許可する")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.pink)
                            .cornerRadius(20)
                    }
                    .padding(.vertical, 8)
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .overlay(
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                // 閉じるアクション
                                withAnimation {
                                    showPushNotice = false
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(8)
                            Spacer()
                        }
                    }
                )
            }
            
            // チャット履歴表示
            ScrollView {
                VStack(spacing: 10) {
                    // 「〜〜さんとマッチしました」的情報を表示（仮）
                    Text("2025/02/25に\(userName)さんとマッチしました")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    ForEach(chatHistory) { bubble in
                        HStack {
                            if bubble.isMe {
                                Spacer()
                                Text(bubble.text)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            } else {
                                Text(bubble.text)
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 8)
            }
            
            // 入力エリア
            HStack {
                // GIF、音楽などのボタンエリア（仮）
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Image(systemName: "camera.on.rectangle.fill")
                    }
                    Button(action: {}) {
                        Text("GIF")
                            .font(.caption2)
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    Button(action: {}) {
                        Image(systemName: "music.note")
                    }
                }
                .foregroundColor(.gray)
                
                TextField("メッセージを入力", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: {
                    guard !message.isEmpty else { return }
                    // 送信
                    let newBubble = ChatBubble(isMe: true, text: message)
                    chatHistory.append(newBubble)
                    message = ""
                }) {
                    Text("送信")
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.white)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

// MARK: - モデルなど
struct ChatBubble: Identifiable {
    let id = UUID()
    let isMe: Bool
    let text: String
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userName: "ゆる")
    }
}
