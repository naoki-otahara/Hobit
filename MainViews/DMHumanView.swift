import SwiftUI

struct DMHumanView: View {
    // 仮の「新しいマッチ」ユーザー一覧
    @State private var newMatches: [MatchUser] = [
        MatchUser(name: "み",    imageName: "person.crop.circle.fill"),
        MatchUser(name: "みそら", imageName: "person.crop.circle.fill"),
        MatchUser(name: "ぱる",  imageName: "person.crop.circle.fill"),
        MatchUser(name: "ゆり",  imageName: "person.crop.circle.fill"),
        MatchUser(name: "のあ",  imageName: "person.crop.circle.fill"),
    ]
    
    // 仮の「メッセージ」一覧
    @State private var messageList: [MessageItem] = [
        MessageItem(userName: "ゆる",       imageName: "cup.and.saucer.fill", lastMessage: "!"),
        MessageItem(userName: "Team match", imageName: "flame.fill",          lastMessage: "こんにちは"),
        MessageItem(userName: "ゆい",       imageName: "person.crop.circle.fill", lastMessage: "ありがとうございます笑"),
        MessageItem(userName: "ゆり",       imageName: "person.crop.circle.fill", lastMessage: "こんにちは"),
        MessageItem(userName: "のあ",       imageName: "person.crop.circle.fill", lastMessage: "こんにちはです")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // 上部 Tinderロゴ
                    HStack {
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.pink)
                                .font(.title2)
                            Text("match")
                                .foregroundColor(.pink)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    // 新しいマッチ
                    Text("新しいマッチ")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.leading, 16)
                        .padding(.top, 10)
                    
                    // 横スクロール
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(newMatches) { match in
                                VStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.pink.opacity(0.1))  // 淡いピンク
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Image(systemName: match.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.pink)
                                                .padding(10)
                                        )
                                    Text(match.name)
                                        .foregroundColor(.black)
                                        .font(.caption)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 8)
                    
                    // メッセージ一覧
                    Text("メッセージ")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.leading, 16)
                        .padding(.top, 8)
                    
                    // リスト
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(messageList) { msg in
                                NavigationLink(destination: ChatView(userName: msg.userName)) {
                                    HStack {
                                        Circle()
                                            .fill(Color.blue.opacity(0.1)) // 淡いブルー
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Image(systemName: msg.imageName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(.blue)
                                                    .padding(8)
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(msg.userName)
                                                .foregroundColor(.black)
                                                .font(.body)
                                            Text(msg.lastMessage)
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                        }
                                        Spacer()
                                        // 返信しようボタン
                                        Button(action: {
                                            // ボタン押下時のアクション
                                        }) {
                                            Text("返信しよう")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.blue)
                                                .cornerRadius(12)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Divider()
                                    .background(Color.gray.opacity(0.3))
                                    .padding(.leading, 70)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// 仮のデータモデル
struct MatchUser: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct MessageItem: Identifiable {
    let id = UUID()
    let userName: String
    let imageName: String
    let lastMessage: String
}

struct DMHumanView_Previews: PreviewProvider {
    static var previews: some View {
        DMHumanView()
    }
}
