//
//  OpenSetView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//

import SwiftUI

private var cardCount = 0

struct OpenSetView: View {
    @State var passedCards:CardSet

    @State var mainText = ""
    @State var subText = ""
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("CardMate")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.purple)
                    .padding()
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                LazyHGrid(rows: singleGrid, alignment: .center) {
                    VStack {
                        Text(mainText)
                            .font(.system(size: 30))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/6, alignment: .center)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                        //Text(subText)
                    }.onAppear(){
                        mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                        subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                    }
                    .onTapGesture(count: 1){
                        print("tapped")
                        if passedCards.cards[cardCount].side == 0 {
                            passedCards.cards[cardCount].side = 1
                            mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                            subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                        }else {
                            passedCards.cards[cardCount].side = 0
                            mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                            subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                        }
                    }
                    .gesture(DragGesture()
                            .onEnded { value in
                              let direction = detectDirection(value: value)
                              if direction == "left" {
                                print("left")
                                if (cardCount != 0){
                                    cardCount -= 1
                                    passedCards.cards[cardCount].side = 0
                                    mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                                    subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]

                                }

                              }else if direction == "right" {
                                print("right")
                                if (passedCards.cards.count > cardCount+1){
                                    cardCount += 1
                                    passedCards.cards[cardCount].side = 0
                                    mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                                    subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]

                                }
                              }
                            }
                          )

                    .frame(width: UIScreen.main.bounds.size.width / 1.05, height: UIScreen.main.bounds.height/3, alignment: .center)
                    .background(Color(UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)))
                    .padding(10)
                    .cornerRadius(40)
                }
                LazyVGrid(columns: singleGrid, content: {
                    ScrollView {
                        VStack{
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .center)
                })
            }
            //Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct OpenSetView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSetView(passedCards: CardSet(cards: [Card](), title: ""))
    }
}
