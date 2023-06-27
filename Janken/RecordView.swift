import SwiftUI

struct RecordView: View {
    
    @State private var isAlert = false
    @Binding var winningStreak: Int
    @Binding var numMatch: Int
    @Binding var numWin: Int
    @Binding var numLose: Int
    @Binding var numAiko: Int
    @Binding var winRate: Int
    @Binding var mostWinningStreak: Int
    
    var body: some View {
        VStack {
            Text("戦績")
                .font(.largeTitle)
                .padding()
            Text("対戦数：\(numMatch)")
            Text("勝利数：\(numWin)")
            Text("敗北数：\(numLose)")
            Text("あいこ数：\(numAiko)")
            Text("勝率：\(winRate)%")
            Text("現在の連勝数：\(winningStreak)")
            Text("過去最高連勝数：\(mostWinningStreak)")
            Button(action: {
                self.isAlert = true
            }) {
                Text("リセット").padding()
            }.alert(isPresented: $isAlert) {
                Alert(title: Text("データは完全に失われます"),
                      message: Text("本当に戦績をリセットしますか？"),
                      primaryButton: .cancel(Text("やめとく")),
                      secondaryButton: .destructive(Text("リセット！"),
                                                    action: {
                    UserDefaults.standard.removeObject(forKey: "numMatch")
                    UserDefaults.standard.removeObject(forKey: "numWin")
                    UserDefaults.standard.removeObject(forKey: "numLose")
                    UserDefaults.standard.removeObject(forKey: "numAiko")
                    UserDefaults.standard.removeObject(forKey: "winRate")
                    UserDefaults.standard.removeObject(forKey: "mostWinningStreak")
                }))
            }
        }.font(.title)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(winningStreak: .constant(0), numMatch: .constant(0), numWin: .constant(0), numLose: .constant(0), numAiko: .constant(0), winRate: .constant(0), mostWinningStreak: .constant(0))
    }
}
