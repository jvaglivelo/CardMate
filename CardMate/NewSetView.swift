//
//  NewSetView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//

import SwiftUI

var newSet = CardSet(cards: [Card](), title: "")


struct NewSetView: View {
    @State var setName:String = ""
    @State var cardNum = 1
    var passedSets:CardSets
    var body: some View {
        VStack(alignment: .center) {
            Text("CardMate")
                .fontWeight(.black)
                .font(.system(size: 28))
                .foregroundColor(.purple)

            Text("Create New Set")
                .fontWeight(.black)
                .font(.system(size: 18))
                .foregroundColor(.purple)
                
            
            HStack{
                Text("Set Name:")
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
                TextField("Enter your name", text: $setName, onCommit: {
                    newSet.title = setName
                })
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
            }
            HStack {
                Button(action: {
                    cardNum += 1
                    print(newSet.cards.count)
                }) {
                    Text("Add Card")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.purple))
                        .padding(.bottom)

                }
                Button(action: {
                    saveQuit(pSet: passedSets)
                }) {
                    Text("Save and Quit")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.purple))
                        .padding(.bottom)

                }

            }
            HStack{
                //Spacer()
                LazyVGrid(columns: singleGrid, content: {
                    ScrollView {
                            ForEach(1...cardNum, id: \.self) { item in
                                NewCardField()
                                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.1, alignment: .center)
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6, alignment: .center)
                })
            }
            Spacer()
        }.onAppear(){
            print(passedSets)
        }
    }
}

struct NewCardField: View {
    @State var cardWord:String = ""
    @State var cardDef:String = ""

    var body: some View {
        HStack{
            TextField("Enter word", text: $cardWord, onCommit: {
                createCard(word: cardWord, def: cardDef)
            })
                .frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
            TextField("Enter definition", text: $cardDef, onCommit: {
                createCard(word: cardWord, def: cardDef)
            })
                .frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height * 0.1, alignment: .center)
                
        }
    }
}

func createCard(word: String, def: String){
    if (!(word.isEmpty) && !(def.isEmpty)){
        print("Creating card for " + word + ":" + def)
        let newCard = Card(mainText: [word,def])
        newSet.cards.append(newCard)
    }
}

func saveQuit(pSet: CardSets){
    print("called")
    if !(newSet.cards.isEmpty){
        if !(newSet.title.isEmpty){
            var userSet = pSet
            userSet.sets.append(newSet)
            print("success")
            defaults.setValue(encodeSets(set: userSet), forKey: "userSets")
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = UIHostingController(rootView: MainView())
                window.makeKeyAndVisible()
            }
        }
    }else{
        tapGoBack()
    }
}

struct NewSetView_Previews: PreviewProvider {
    static var previews: some View {
        NewSetView(passedSets: CardSets(sets: [CardSet]()))
    }
}
