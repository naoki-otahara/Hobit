import SwiftUI

struct UserProfile {
    var profileImage: UIImage
    var username: String
    var age: Int
    var bio: String
    var tags: [String]
    var subTags: [String] // :white_check_mark: `subTags` を追加
    
    // 仮のデータ
    static func example() -> UserProfile {
        return UserProfile(
            profileImage: UIImage(systemName: "person.circle") ?? UIImage(),
            username: "テストユーザー",
            age: 25,
            bio: "よろしくお願いします！",
            tags: ["バスケ", "ロック", "ゲーム"],
            subTags: ["ガチ", "エンジョイ"] // :white_check_mark: `subTags` の初期データ
        )
    }
}
