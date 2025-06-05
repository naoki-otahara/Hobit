import SwiftUI

struct DiscoverySettingsView: View {
    @State private var selectedPrefectureIndex = 0
    @State private var selectedCityIndex = 0
    @State private var selectedDistrictIndex = 0
    @State private var minDistanceSliderValue = 1.0
    @State private var maxDistanceSliderValue = 100.0
    @State private var minAgeSliderValue = 16.0
    @State private var maxAgeSliderValue = 100.0
    @State private var selectedMBTIIndex = 0
    @State private var selectedRelationshipTypeIndex = 0
    
    let prefectures = [
        "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
        "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
        "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
        "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
        "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
        "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
        "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
    ]
    
    let cities = ["市区町村を選択"] // 実際はデータ連携するか別途用意
    let districts = ["地区を選択"] // 同上
    let relationshipTypes = ["ガチ勢", "エンジョイ勢", "友達作り", "暇つぶし", "チャット相手", "まだわからない"]
    let mbtiTypes = [
        "INTJ 建築家", "INTP 論理学者", "ENTJ 指揮官", "ENTP 討論者",
        "INFJ 提唱者", "ENFJ 主人公", "INFP 仲介者", "ENFP 運動家",
        "ISTJ 管理者", "ISFJ 擁護者", "ESTJ 幹部", "ESFJ 領事",
        "ESTP 起業家", "ISTP 巨匠", "ISFP 冒険家", "ESFP エンターテイナー"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 全体カード
                    VStack(spacing: 20) {
                        // タイトル
                        Text("ディスカバリー設定")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 16)
                        
                        Divider()
                        
                        // 現在地設定
                        settingsSection(title: "現在地設定") {
                            VStack(spacing: 12) {
                                customPicker(label: "都道府県", selection: $selectedPrefectureIndex, options: prefectures)
                                customPicker(label: "市区町村", selection: $selectedCityIndex, options: cities)
                                customPicker(label: "地区", selection: $selectedDistrictIndex, options: districts)
                            }
                        }
                        
                        // 距離設定
                        settingsSection(title: "距離設定 (\(Int(minDistanceSliderValue))km 〜 \(Int(maxDistanceSliderValue))km)") {
                            VStack(spacing: 8) {
                                HStack {
                                    Text("最小距離")
                                    Slider(value: $minDistanceSliderValue, in: 1...100, step: 1)
                                        .accentColor(.blue)
                                }
                                HStack {
                                    Text("最大距離")
                                    Slider(value: $maxDistanceSliderValue, in: 1...100, step: 1)
                                        .accentColor(.blue)
                                }
                            }
                        }
                        
                        // 年齢設定
                        settingsSection(title: "年齢設定 (\(Int(minAgeSliderValue))歳 〜 \(Int(maxAgeSliderValue))歳)") {
                            VStack(spacing: 8) {
                                HStack {
                                    Text("最小年齢")
                                    Slider(value: $minAgeSliderValue, in: 16...100, step: 1)
                                        .accentColor(.purple)
                                }
                                HStack {
                                    Text("最大年齢")
                                    Slider(value: $maxAgeSliderValue, in: 16...100, step: 1)
                                        .accentColor(.purple)
                                }
                            }
                        }
                        
                        // MBTI設定
                        settingsSection(title: "MBTI設定") {
                            customPicker(label: "MBTI", selection: $selectedMBTIIndex, options: mbtiTypes)
                        }
                        
                        // 求めるもの人物設定
                        settingsSection(title: "求めるもの人物") {
                            customPicker(label: "人物タイプ", selection: $selectedRelationshipTypeIndex, options: relationshipTypes)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
                    .padding()
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    // 共通のセクションヘッダーとコンテンツをまとめるビュー
    private func settingsSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            content()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    // 共通のPickerスタイル
    private func customPicker(label: String, selection: Binding<Int>, options: [String]) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Picker("", selection: selection) {
                ForEach(0..<options.count, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
}

struct DiscoverySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverySettingsView()
    }
}
