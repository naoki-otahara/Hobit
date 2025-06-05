import SwiftUI
import UIKit

// MARK: - カスタムのトップタブバー
struct TopTabBar: View {
    @Binding var selectedSegment: Int
    @State private var showDiscoverySettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 40) {
                // おすすめタブ
                Button(action: {
                    selectedSegment = 0
                }) {
                    VStack {
                        Text("おすすめ")
                            .font(.headline)
                            .foregroundColor(selectedSegment == 0 ? .blue : .gray)
                        // アクティブなタブに下線を表示
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedSegment == 0 ? .blue : .clear)
                    }
                }
                
                // 相手からタブ
                Button(action: {
                    selectedSegment = 1
                }) {
                    VStack {
                        Text("相手から")
                            .font(.headline)
                            .foregroundColor(selectedSegment == 1 ? .blue : .gray)
                        // アクティブなタブに下線を表示
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedSegment == 1 ? .blue : .clear)
                    }
                }
                
                // 設定ボタン
                Button(action: {
                    showDiscoverySettings.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .sheet(isPresented: $showDiscoverySettings) {
                    DiscoverySettingsView()
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            .padding(.bottom, 10)
            .background(Color(.systemGray6)) // 背景色をライトグレーに変更
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
        }
    }
}





// MARK: - マッチング成立画面(黄色基調 & ハートの代わりに✖️)
struct MatchCompleteView: View {
    // sheetを閉じるための環境変数
    @Environment(\.presentationMode) var presentationMode
    
    // 「メッセージを送る」でタブをDM(人間)=1に切り替えるため
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            // 背景を黄色系のグラデーション
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("マッチング成立しました！")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("おめでとうございます！")
                    .font(.title3)
                    .foregroundColor(.white)
                
                // ユーザーアイコン & xマーク
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text("相手")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        )
                    
                    // ハートの代わりに✖️
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text("自分")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        )
                }
                .padding(.vertical, 20)
                
                // ボタン
                VStack(spacing: 15) {
                    // 「メッセージを送る」ボタン
                    Button(action: {
                        // DM(人間)=1に切り替え → sheetを閉じる
                        selectedTab = 1
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("メッセージを送る")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    
                    // 「続ける」ボタン
                    Button(action: {
                        // ホーム=0へ戻る → sheetを閉じる
                        selectedTab = 0
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("続ける")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 40)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - UIKitのカードスワイプ画面
class SwipeViewController: UIViewController {
    // 表示するカードのデータ
    var profiles: [String] = ["User A", "User B", "User C", "User D"]
    var currentIndex: Int = 0
    
    // リワインド用に直前に消したカードのインデックス
    var lastRemovedCardIndex: Int? = nil
    
    // 現在表示中のカードビュー
    var cardView: UIView?
    
    // 「マッチ成立」コールバック(相手からタブでライク時に呼び出す)
    var onMatchComplete: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCardView()
    }
    
    // カードセットアップ
    func setupCardView() {
        cardView?.removeFromSuperview()
        
        guard currentIndex < profiles.count else {
            print("すべてのカードがなくなったでゲス！ currentIndex=\(currentIndex)")
            return
        }
        
        let frame = CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 500)
        let newCard = UIView(frame: frame)
        newCard.backgroundColor = .systemBlue
        newCard.layer.cornerRadius = 10
        newCard.layer.shadowOpacity = 0.3
        newCard.layer.shadowRadius = 5
        
        let label = UILabel(frame: newCard.bounds)
        label.text = profiles[currentIndex]
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        newCard.addSubview(label)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        newCard.addGestureRecognizer(pan)
        
        newCard.alpha = 0
        view.addSubview(newCard)
        UIView.animate(withDuration: 0.3) {
            newCard.alpha = 1
        }
        
        cardView = newCard
        print("setupCardView: カード表示 → \(profiles[self.currentIndex]) (index=\(self.currentIndex))")
    }
    
    // スワイプ操作
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view else { return }
        let translation = gesture.translation(in: view)
        let direction: CGFloat = (translation.x >= 0) ? 1 : -1
        let percent = abs(translation.x) / view.bounds.width
        
        switch gesture.state {
        case .changed:
            card.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
                .rotated(by: direction * 0.4 * percent)
            let alpha = min(0.3, percent)
            if direction > 0 {
                view.backgroundColor = UIColor.systemPink.withAlphaComponent(alpha)
            } else {
                view.backgroundColor = UIColor.systemBlue.withAlphaComponent(alpha)
            }
        case .ended:
            if abs(translation.x) > 100 {
                animateSwipe(card: card, direction: direction)
            } else {
                UIView.animate(withDuration: 0.3) {
                    card.transform = .identity
                    self.view.backgroundColor = .white
                }
            }
        default:
            break
        }
    }
    
    // スワイプ確定
    func animateSwipe(card: UIView, direction: CGFloat) {
        let offset = direction * view.bounds.width
        UIView.animate(withDuration: 0.3, animations: {
            card.center.x += offset
            card.alpha = 0
        }) { _ in
            card.removeFromSuperview()
            self.lastRemovedCardIndex = self.currentIndex
            print("animateSwipe: \(direction > 0 ? "ライク" : "ノンライク")でカード消去。currentIndex=\(self.currentIndex)")
            self.currentIndex += 1
            self.view.backgroundColor = .white
            self.setupCardView()
        }
    }
    
    // MARK: - ボタン操作
    
    func rewindAction() {
        print("rewindAction: リワインドボタンが押された")
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = .white
            }
            guard let last = self.lastRemovedCardIndex else {
                print("rewindAction: リワインドできるカードがないでゲス！")
                return
            }
            self.currentIndex = last
            self.lastRemovedCardIndex = nil
            self.setupCardView()
        }
    }
    
    func dislikeAction() {
        print("dislikeAction: ノンライクボタンが押された")
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = .white
            }
            if let card = self.cardView {
                self.animateSwipe(card: card, direction: -1)
            }
        }
    }
    
    func likeAction() {
        print("likeAction: ライクボタンが押された")
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = .white
            }
            if let card = self.cardView {
                self.animateSwipe(card: card, direction: 1)
            }
            
            // 「相手から」タブでライクしたときにマッチング成立とする例
            self.onMatchComplete?()
        }
    }
}

// MARK: - SwiftUIでUIKitのViewControllerをラップする
struct SwipeViewWrapper: UIViewControllerRepresentable {
    @Binding var selectedSegment: Int
    var onViewControllerReady: ((SwipeViewController) -> Void)?
    
    func makeUIViewController(context: Context) -> SwipeViewController {
        let vc = SwipeViewController()
        onViewControllerReady?(vc)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SwipeViewController, context: Context) {
        // "相手から"タブ(=1)なら "Like X", "Like Y", "Like Z" を表示
        if selectedSegment == 0 {
            uiViewController.profiles = ["User A", "User B", "User C", "User D"]
        } else {
            uiViewController.profiles = ["Like X", "Like Y", "Like Z"]
        }
        uiViewController.currentIndex = 0
        uiViewController.lastRemovedCardIndex = nil
        uiViewController.setupCardView()
    }
}

// MARK: - メイン画面(SwipeView)
struct SwipeView: View {
    @State private var selectedSegment: Int = 0
    @State private var vcRef: SwipeViewController? = nil
    
    // マッチング成立画面を表示するフラグ
    @State private var showMatchComplete = false
    
    // 「メッセージを送る」ボタンから DM(人間)=1 へ飛ぶために MainTabView の selectedTab を反映
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            TopTabBar(selectedSegment: $selectedSegment)
            
            ZStack {
                SwipeViewWrapper(selectedSegment: $selectedSegment) { vc in
                    self.vcRef = vc
                    print("SwipeView: vcRef is set")
                    
                    // 「相手から」タブ(=1) でライク時にマッチング成立
                    vc.onMatchComplete = {
                        if selectedSegment == 1 {
                            showMatchComplete = true
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            Spacer().frame(height: 30)
            
            HStack(spacing: 50) {
                Button {
                    vcRef?.rewindAction()
                } label: {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 60, height: 60)
                }
                
                Button {
                    vcRef?.dislikeAction()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 60)
                }
                
                Button {
                    vcRef?.likeAction()
                } label: {
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(width: 60, height: 60)
                }
            }
            .padding(.bottom, 40)
        }
        // シート: マッチング成立
        .sheet(isPresented: $showMatchComplete) {
            // MatchCompleteView に selectedTab を渡す
            MatchCompleteView(selectedTab: $selectedTab)
        }
    }
}


// MARK: - アプリエントリーポイント
@main
struct SwipeUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
