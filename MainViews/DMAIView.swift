import SwiftUI

struct DMAIView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.id) { message in
                            AIChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages) { _ in
                    withAnimation {
                        scrollView.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }
            
            HStack {
                TextField("回答を入力...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
        .onAppear {
            startPersonalityTest()
        }
        .navigationTitle("AI 性格診断")
    }
    
    func startPersonalityTest() {
        if messages.isEmpty { // :white_check_mark: 重複しないようにチェック
            messages.append(Message(text: "こんにちは！AI 性格診断を始めます。", isAI: true))
            messages.append(Message(text: "最初の質問です。「あなたがリラックスできる時間はどんな時ですか？」", isAI: true))
        }
    }
    
    func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        let userMessage = Message(text: inputText, isAI: false)
        messages.append(userMessage)
        
        inputText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = generateAIResponse(for: userMessage.text)
            messages.append(Message(text: aiResponse, isAI: true))
        }
    }
    
    func generateAIResponse(for input: String) -> String {
        let responses = [
            "なるほど、それは興味深いですね！次の質問です。",
            "いいですね！もう少し詳しく教えてもらえますか？",
            "なるほど、では次の質問に進みましょう。",
            "興味深い回答です！次の質問に移りますね。"
        ]
        return responses.randomElement() ?? "なるほど！次の質問に進みます。"
    }
}

// :white_check_mark: AI チャット専用の吹き出し
struct AIChatBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isAI {
                Text(message.text)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .frame(maxWidth: 250, alignment: .leading)
            } else {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
                    .frame(maxWidth: 250, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isAI ? .leading : .trailing)
    }
}
