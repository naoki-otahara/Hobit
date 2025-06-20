# 🎯 Hobit - 趣味でつながる友達マッチングアプリ

Engineer Guild ハイレベルハッカソンにて開発。  
**Hobit** は「趣味」を通じて友達と出会えるマッチングアプリです。  
恋愛目的ではなく、**共通の趣味を持つ人同士がつながる**ことを目的とした、カジュアルかつ実用的なSNSプラットフォームです。

---

## 📱 アプリ概要

**Hobit** は、同じ趣味を持つ仲間を見つけたい人のためのマッチングアプリです。  
「趣味」という共通点をベースに、カジュアルな利用者からガチ勢まで、誰もが気軽に交流できる仕組みを提供します。

---

## 🎯 主なターゲット層

- 趣味を共有できる友達を探している 18〜30代の方
- 同じ熱量で趣味を語り合いたい人
- 恋愛目的ではなく、純粋に趣味でつながりたい人
- コミュニケーションの壁を感じている人
- 趣味を通じて新しい交友関係を築きたい人
- 特定の趣味に熱中しているが、共有相手がいない人

---

## 💡 ターゲットのニーズ

- 同じ趣味を持つ友達を簡単に見つけたい
- 趣味に没頭できる仲間がいない孤独感を解消したい
- コミュニケーションのハードルを下げるきっかけが欲しい
- 趣味レベル（カジュアル or ガチ勢）によるマッチング精度を高めたい
- 恋愛よりも「趣味友達」重視のマッチングを求めている

---

## 🛠️ 技術構成

- **フロントエンド**：Swift
- **UI設計**：Figmaによるプロトタイピング
- **アーキテクチャ**：ウォーターフォールモデルに基づく段階的開発
- **主なページ構成**:
  - `/`：トップページ
  - `/login`：ログイン画面
  - `/register`：新規登録画面
  - `/matching`：趣味によるマッチング画面
  - `/profile`：プロフィール編集画面

---

## 🧑‍💻 開発担当領域

- UI設計・画面遷移設計・全体監修
- フロントエンド開発全般（Swift）
- コミュニケーション設計（ユーザーが直感的に操作できるUXを重視）
- チーム開発におけるGitHubのブランチ運用・PR管理

---

## 📂 ディレクトリ構成（簡略）

```

Hobit/
├── public/
│   └── index.html
├── src/
│   ├── assets/         # アイコン・画像素材
│   ├── components/     # 共通コンポーネント
│   ├── pages/          # 各ページ（ログイン・マッチング等）
│   ├── types/          # 型定義
│   ├── App.tsx
│   └── main.tsx
├── .gitignore
├── package.json
├── README.md
└── tsconfig.json

```

---

## 🚀 今後の展望（例）

- Firebase や Supabase との連携によるバックエンド実装
- マッチング精度向上のための趣味分類・タグ機能の強化
- 趣味グループチャット機能の追加
- プッシュ通知対応（PWA化）

---


