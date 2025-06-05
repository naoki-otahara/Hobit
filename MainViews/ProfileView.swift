import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var isEditing = false
    @State private var user = UserProfile.example() // :white_check_mark: `UserProfile` に `subTags` 追加済み
    
    var body: some View {
        VStack {
            Image(uiImage: user.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .padding()
            
            Text(user.username)
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(user.age) 歳")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(user.bio)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            // :white_check_mark: 選択されたタグの表示
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
            }.padding()
            
            // :white_check_mark: サブタグの表示
            if !user.subTags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.subTags, id: \.self) { subTag in
                            Text(subTag)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                }.padding()
            }
            
            Spacer()
            
            // :white_check_mark: 編集ボタン
            Button(action: {
                isEditing = true
            }) {
                Text("プロフィールを編集")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isEditing) {
            ProfileEditView(user: $user) // :white_check_mark: `@Binding` で渡す
        }
    }
}
