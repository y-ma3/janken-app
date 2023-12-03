import SwiftUI

struct ContentView: View {
    
    @State private var showingRecordModal = false
    @State private var playerHand = 0
    @State private var computerHand = 0
    @State private var text = "じゃんけん・・・"
    @AppStorage("winningStreak") var winningStreak = 0
    @AppStorage("numMatch") var numMatch = 0
    @AppStorage("numWin") var numWin = 0
    @AppStorage("numLose") var numLose = 0
    @AppStorage("numAiko") var numAiko = 0
    @AppStorage("winRate") var winRate = 0
    @AppStorage("mostWinningStreak") var mostWinningStreak = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                self.showingRecordModal.toggle()
            }){
                Image(systemName: "line.3.horizontal.circle")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 30,height: 30)
            }
            .sheet(isPresented: $showingRecordModal) {
                RecordView(winningStreak: self.$winningStreak, numMatch: self.$numMatch, numWin: self.$numWin, numLose: self.$numLose, numAiko: self.$numAiko, winRate: self.$winRate, mostWinningStreak: self.$mostWinningStreak)
            }.padding()
            
            VStack {
                Image("oldman_face")
                    .resizable()
                    .scaledToFit()
                //            相手の手
                if (computerHand == 0) {
                    Image("janken_gu")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 180))
                } else if (computerHand == 1) {
                    Image("janken_choki")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 180))
                } else if (computerHand == 2) {
                    Image("janken_pa")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 180))
                }
                
                Text(text)
                    .font(.title)
                Text("\(winningStreak)連勝中！")
                    .font(.title)
                
                //            自分の手
                if (playerHand == 0) {
                    Image("janken_gu")
                        .resizable()
                        .scaledToFit()
                } else if (playerHand == 1) {
                    Image("janken_choki")
                        .resizable()
                        .scaledToFit()
                } else if (playerHand == 2) {
                    Image("janken_pa")
                        .resizable()
                        .scaledToFit()
                }
                // ボタン
                HStack {
                    Button(action: {
                        playerHand = 0
                        self.computerHand = chooseComputerHand()
                        self.text = determineVictoryOrDefeat(playerHand: self.playerHand, computerHand: self.computerHand)
                        storeRecord(playerHand: self.playerHand, computerHand: self.computerHand)
                    }) {
                        Image("janken_gu_tab")
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        playerHand = 1
                        self.computerHand = chooseComputerHand()
                        self.text = determineVictoryOrDefeat(playerHand: self.playerHand, computerHand: self.computerHand)
                        storeRecord(playerHand: self.playerHand, computerHand: self.computerHand)
                    }) {
                        Image("janken_choki_tab")
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        playerHand = 2
                        self.computerHand = chooseComputerHand()
                        self.text = determineVictoryOrDefeat(playerHand: self.playerHand, computerHand: self.computerHand)
                        storeRecord(playerHand: self.playerHand, computerHand: self.computerHand)
                    }) {
                        Image("janken_pa_tab")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

func chooseComputerHand() -> Int {
    let random = Int.random(in: 0..<3)
    let computerHand = random
    return computerHand
}

func determineVictoryOrDefeat(playerHand:Int, computerHand:Int) -> String {
    var result = ""
    let playerHandTemp = playerHand + 1
    
    if (playerHand == computerHand) {
        result = "ぽん...あいこです"
    } else if ((playerHand == 2 && computerHand == 0) || (playerHandTemp == computerHand)) {
        result = "ぽん...あなたの勝ちです"
    } else {
        result = "ぽん...あなたの負けです"
    }
    return result
}

func storeRecord(playerHand:Int, computerHand:Int) {
    let playerHandTemp = playerHand + 1
    @AppStorage("winningStreak") var winningStreak = 0
    @AppStorage("numMatch") var numMatch = 0
    @AppStorage("numWin") var numWin = 0
    @AppStorage("numLose") var numLose = 0
    @AppStorage("numAiko") var numAiko = 0
    @AppStorage("winRate") var winRate = 0
    @AppStorage("mostWinningStreak") var mostWinningStreak = 0
    
//    あいこ
    if (playerHand == computerHand) {
        numMatch += 1
        numAiko += 1
//    勝ち
    } else if ((playerHand == 2 && computerHand == 0) || (playerHandTemp == computerHand)) {
        winningStreak += 1
        numMatch += 1
        numWin += 1
        if (winningStreak > mostWinningStreak) {
            mostWinningStreak = winningStreak
        }
//    負け
    } else {
        winningStreak = 0
        numMatch += 1
        numLose += 1
    }
    winRate = numWin * 100 / numMatch
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
