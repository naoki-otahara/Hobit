import SwiftUI

struct MainTabView: View {
    // タブの選択状態 (0=ホーム, 1=DM(人間), 2=DM(AI), 3=プロフィール)
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // タブ0: スワイプ(ホーム)
            // SwipeViewに selectedTab をバインディングで渡す
            SwipeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "flame.fill") // Tinder風に炎アイコン
                    Text("ホーム")
                }
                .tag(0)
            
            // タブ1: DM(人間)
            DMHumanView()
                .tabItem {
                    Image(systemName: "person.2.fill") // 人アイコン
                    Text("DM(人間)")
                }
                .tag(1)
            
            // タブ2: DM(AI人格診断)
            DMAIView()
                .tabItem {
                    Image(systemName: "sparkles") // 好きなアイコンを選んで
                    Text("DM(AI)")
                }
                .tag(2)
            
            // タブ3: プロフィール編集
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("プロフィール")
                }
                .tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
