import SwiftUI
import UIKit

struct ProfileEditView: View {
    @Binding var user: UserProfile
    
    @State private var selectedTags: [String]
    @State private var subTags: [String]
    @State private var username: String
    @State private var age: String
    @State private var bio: String
    @State private var profileImage: UIImage
    
    // ❶ 保存時に画面を閉じるための変数
    @Environment(\.presentationMode) var presentationMode
    
    // メインタグ
    let allTags = [
        "スポーツ": ["バスケ", "サッカー", "テニス", "野球"],
        "音楽": ["ロック", "ポップ", "クラシック", "ジャズ"],
        "ゲーム": ["RPG", "FPS", "パズル", "シミュレーション"]
    ]
    
    // サブタグ(全パターン：4種類ずつ)
    let subTagOptions: [String: [String]] = [
        // スポーツ
        "バスケ":       ["ガチ", "エンジョイ", "3x3", "ストリート"],
        "サッカー":     ["ガチ", "エンジョイ", "フットサル", "フリーキック"],
        "テニス":       ["シングルス", "ダブルス", "ガチ", "エンジョイ"],
        "野球":         ["草野球", "バッティングセンター", "ガチ", "エンジョイ"],
        
        // 音楽
        "ロック":       ["メタル", "パンク", "オルタナ", "ハードロック"],
        "ポップ":       ["J-pop", "K-pop", "アイドル", "エレクトロ"],
        "クラシック":   ["ピアノ", "オーケストラ", "室内楽", "合唱"],
        "ジャズ":       ["スウィング", "フュージョン", "ビバップ", "ボサノバ"],
        
        // ゲーム
        "RPG":          ["JRPG", "オープンワールド", "ターン制", "アクションRPG"],
        "FPS":          ["ソロ", "チーム", "カジュアル", "バトロワ"],
        "パズル":       ["落ち物", "頭脳派", "アクションパズル", "協力プレイ"],
        "シミュレーション": ["戦略系", "街づくり", "経営", "VR"]
    ]
    
    // ❷ すでにある UserProfile から初期値を取得
    init(user: Binding<UserProfile>) {
        self._user = user
        self._selectedTags = State(initialValue: user.wrappedValue.tags)
        self._subTags = State(initialValue: user.wrappedValue.subTags)
        self._username = State(initialValue: user.wrappedValue.username)
        self._age = State(initialValue: String(user.wrappedValue.age))
        self._bio = State(initialValue: user.wrappedValue.bio)
        self._profileImage = State(initialValue: user.wrappedValue.profileImage)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // プロフィール画像
                    Button(action: {
                        // 画像変更ロジック
                    }) {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                    }
                    
                    // 名前
                    TextField("ユーザー名", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    // 年齢
                    TextField("年齢", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                    
                    // 自己紹介
                    TextEditor(text: $bio)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                        .padding(.horizontal)
                    
                    // タグ選択
                    Text("好きなタグを選択")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    ForEach(allTags.keys.sorted(), id: \.self) { category in
                        VStack(alignment: .leading) {
                            Text(category)
                                .font(.headline)
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(allTags[category]!, id: \.self) { tag in
                                        Button {
                                            selectTag(tag)
                                        } label: {
                                            Text(tag)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(
                                                    selectedTags.contains(tag)
                                                    ? Color.red
                                                    : Color.gray.opacity(0.2)
                                                )
                                                .foregroundColor(
                                                    selectedTags.contains(tag)
                                                    ? .white
                                                    : .black
                                                )
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // サブタグ表示 (選択済みのすべての mainTag に対応)
                    if !selectedTags.isEmpty {
                        Text("サブタグを選択")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        ForEach(selectedTags, id: \.self) { mainTag in
                            if let options = subTagOptions[mainTag] {
                                VStack(alignment: .leading) {
                                    Text("\(mainTag) の詳細")
                                        .font(.subheadline)
                                        .padding(.leading, 16)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(options, id: \.self) { subTag in
                                                Button {
                                                    toggleSubTag(subTag)
                                                } label: {
                                                    Text(subTag)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(
                                                            self.subTags.contains(subTag)
                                                            ? Color.blue
                                                            : Color.gray.opacity(0.2)
                                                        )
                                                        .foregroundColor(
                                                            self.subTags.contains(subTag)
                                                            ? .white
                                                            : .black
                                                        )
                                                        .clipShape(Capsule())
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 30)
                    
                    // 保存ボタン
                    Button(action: saveChanges) {
                        Text("保存")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                }
                .padding(.top)
            }
            .navigationBarTitle("プロフィール編集", displayMode: .inline)
        }
    }
    
    // メインタグを選択 or 解除
    private func selectTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll { $0 == tag }
        } else {
            selectedTags.append(tag)
        }
    }
    
    // サブタグを選択 or 解除
    private func toggleSubTag(_ subTag: String) {
        if subTags.contains(subTag) {
            subTags.removeAll { $0 == subTag }
        } else {
            subTags.append(subTag)
        }
    }
    
    // 保存処理 → 画面を閉じる
    private func saveChanges() {
        user.username = username
        user.age = Int(age) ?? user.age
        user.bio = bio
        user.profileImage = profileImage
        user.tags = selectedTags
        user.subTags = subTags
        
        // 前の画面に戻る
        presentationMode.wrappedValue.dismiss()
    }
}
