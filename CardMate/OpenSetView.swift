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
    @State private var mainText = ""
    @State private var subText = ""
    @State private var defHidden:Bool = true
    @State private var btnText:String = "Show"
    
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
                    if direction == "left" {
                        if (cardCount != 0){
                        cardCount -= 1
                        passedCards.cards[cardCount].side = 0
                        mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                        subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]
                        }
                    }else if direction == "right" {
                        if (passedCards.cards.count > cardCount+1){
                            cardCount += 1
                            passedCards.cards[cardCount].side = 0
                            mainText = passedCards.cards[cardCount].mainText[passedCards.cards[cardCount].side]
                            subText = passedCards.cards[cardCount].subText[passedCards.cards[cardCount].side]

                        }
                    }
                })
                .onTapGesture(count: 1){
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
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.115)
                
                //Card Count Text
                Text(String(cardCount+1) + "/" + String(passedCards.cards.count))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                //Buttons
                HStack {
                    Button(action: {
                        defHidden.toggle()
                        if (defHidden){
                            btnText = "Show"
                        }else{
                            btnText = "Hide"
                        }
                    }) {
                        Text(btnText)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))

                    }
                    Button(action: {
                        tapLearnView(pSet: passedCards)
                    }) {
                        Text("Learn")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))

                    }

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
                
                //Header
                HStack {
                    Text("Word")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

                    Text("Definition")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
                
                //Word List
                CardListTable(pCards: passedCards, dHidden: defHidden)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct CardListTable: View {
    var pCards:CardSet
    var dHidden:Bool
    var body: some View {
        
        //Table
        LazyVGrid(columns: singleGrid, content: {
            ScrollView {
                VStack{
                    ForEach(pCards.cards, id: \.self) { card in
                        if(dHidden){
                            CardListField(word: card.mainText[0], def: "****")
                        }else {
                            CardListField(word: card.mainText[0], def: card.mainText[1])

                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .center)
        })

    }
}

struct CardListField: View {
    var word:String
    var def:String

    var body: some View {
        HStack{
            Text(word)
                .frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
            Text(def)
                .frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height * 0.1, alignment: .center)
                
        }
    }
}

func tapGoBack() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: MainView())
        window.makeKeyAndVisible()
    }
}

//function to go to OpenSetView
func tapLearnView(pSet: CardSet) {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: LearnView(passedCards: pSet))
        window.makeKeyAndVisible()
    }
}

struct OpenSetView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSetView(passedCards: CardSet(cards: [Card(mainText: ["Error", "Error"])], title: "ERROR"))
    }
}
