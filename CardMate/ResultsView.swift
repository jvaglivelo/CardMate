//
//  ResultsView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/8/20.
//

import SwiftUI

struct ResultsView: View {
    @State var correct:Int
    @State var total:Int
    @State var incorrectCards:CardSet

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                
                //Title
                Text("CardMate")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.purple)

                Text("Results")
                    .fontWeight(.black)
                    .font(.system(size: 18))
                    .foregroundColor(.purple)

                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                
                //Card Count Text
                VStack {
                    Text("Score")
                        .fontWeight(.black)
                        .font(.system(size: 20))
                        .foregroundColor(.purple)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    Text(String(correct) + "/" + String(total))
                        .font(.system(size: 18))
                    
                    Text(String((Double(correct)/Double(total))*100.0) + "%")
                        .font(.system(size: 18))

                }
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                
                
                //Header
                if (incorrectCards.cards.count != 0){
                    incHeader()
                }
                
                //Table
                LazyVGrid(columns: singleGrid, content: {
                    ScrollView {
                        VStack{
                            ForEach(incorrectCards.cards, id: \.self) { card in
                                CardListField(word: card.mainText[0], def: card.mainText[1])
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .center)
                })

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


struct incHeader: View {
    var body: some View {
        VStack {
            Text("Incorrect Cards")
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.03)
            HStack {
                Text("Word")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

                Text("Definition")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }

        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(correct: 1, total: 2, incorrectCards: CardSet(cards: [Card(mainText: ["Error", "Error"])], title: "ERROR"))
    }
}
