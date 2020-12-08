//
//  LearnView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/8/20.
//

import SwiftUI

private var cardCount = 0
private var correct = 0
var wrongSet = CardSet(cards: [Card](), title: "")

struct LearnView: View {
    @State var passedCards:CardSet
    @State private var mainText = ""
    @State private var subText = ""
    @State private var cardWord = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                
                //Title
                Text("CardMate")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.purple)
                    .padding()
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                
                //Card
                LazyHGrid(rows: singleGrid, alignment: .center) {
                    VStack {
                        Text(mainText)
                            .font(.system(size: 30))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/6, alignment: .center)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                    }.onAppear(){
                        mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                        subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                    }
                    .frame(width: UIScreen.main.bounds.size.width / 1.05, height: UIScreen.main.bounds.height/3, alignment: .center)
                    .background(Color(UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)))
                    .padding(10)
                    .cornerRadius(40)
                }.gesture(DragGesture()
                    .onEnded { value in
                    let direction = detectDirection(value: value)
                    if direction == "right" {
                        if (passedCards.cards.count > cardCount+1){
                            cardCount += 1
                            passedCards.cards[cardCount].side = 0
                            mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                            subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]

                        }
                    }
                })
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.115)
                
                //Card Count Text
                Text(String(cardCount+1) + "/" + String(passedCards.cards.count))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                //Buttons
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)

                VStack {
                    Text("Enter Definition:")
                    TextField("Definition", text: $cardWord, onCommit: {
                        passedCards.cards[cardCount].side = 1
                        mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                        subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]

                        if (mainText.lowercased() == cardWord.lowercased()){
                            print("correct")
                            correct += 1
                        }else{
                            print("incorrect")
                            wrongSet.cards.append(passedCards.cards[cardCount])
                        }
                        let nextDelay = DispatchQueue(label: "nextDelay", qos: .userInitiated)
                        nextDelay.asyncAfter(deadline: .now() + .milliseconds(3000))
                        {
                            DispatchQueue.main.async(){
                                print("called")
                                cardWord = ""
                                if (passedCards.cards.count > cardCount+1){
                                    cardCount += 1
                                    passedCards.cards[cardCount].side = 0
                                    mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                                    subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                                }else {
                                    print("Done")
                                    goToResults(cor: correct, total: passedCards.cards.count)
                                    correct = 0
                                    wrongSet = CardSet(cards: [Card](), title: "")
                                    cardCount = 0

                                }
                            }
                        }
                    })
                    .multilineTextAlignment(TextAlignment.center)
                }

                Spacer()
                HStack {
                    Button(action: {
                        tapGoBack()
                    }) {
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
    }
}

//function to go to OpenSetView
func goToResults(cor: Int, total: Int) {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: ResultsView(correct: cor, total: total, incorrectCards: wrongSet))
        window.makeKeyAndVisible()
    }
}


struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView(passedCards: CardSet(cards: [Card(mainText: ["Error", "Error"])], title: "ERROR"))
    }
}
