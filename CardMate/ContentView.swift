//
//  ContentView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//
//  Credits : https://stackoverflow.com/questions/59109138/how-to-implement-a-left-or-right-draggesture-that-trigger-a-switch-case-in-swi

import SwiftUI

var singleGrid = [GridItem()]
private var homeCards = CardSet(cards: [Card(mainText: ["Welcome to CardMate", "The controls are simple"], subText: ["Tap to flip", "Swipe right for the next card"]), Card(mainText: ["You can also swipe left to go back", "You can try it if you want"]), Card(mainText: ["Card Sets will appear below", "To remove one, you can hold down on it"], subText: ["", ""]),Card(mainText: ["Thats pretty much all the controls", "Enjoy!"], subText: ["You can create card sets below", ""])], title: "Home Set")
private var cardCount = 0


//Detect direction card was swiped
func detectDirection(value: DragGesture.Value) -> String {
    //calculate whether left or right based off swipe locations
    if value.startLocation.x < value.location.x - 24 {
        return "left"
        }else if value.startLocation.x > value.location.x + 24 {
        return "right"
    }
    return "?"
  }

//function to go to NewSetView
func tapNewSet(set: CardSets) {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: NewSetView(passedSets: set))
        window.makeKeyAndVisible()
    }
}

//function to go to OpenSetView
func tapOpenSet(passSet: CardSet) {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: OpenSetView(passedCards: passSet))
        window.makeKeyAndVisible()
    }
}

//function to go to SettingsView
func tapSettings() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: SettingsView())
        window.makeKeyAndVisible()
    }
}


struct MainView: View {
    @State private var mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
    @State private var subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]
    @State private var userSets:CardSets = CardSets(sets: [CardSet]())
    @State private var showAlert = false
    @State private var deleteSet = CardSet(cards: [Card](), title: "")
    
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
                        Text(subText)
                            .foregroundColor(.black)

                    }
                    .frame(width: UIScreen.main.bounds.size.width / 1.05, height: UIScreen.main.bounds.height/3, alignment: .center)
                    .background(Color(UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)))
                    .padding(10)
                    .cornerRadius(40)
                }.gesture(DragGesture()
                            .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == "left" {
                                print("left")
                                if (cardCount != 0){
                                cardCount -= 1
                                homeCards.cards[cardCount].side = 0
                                mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
                                subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]
                                }
                            }else if direction == "right" {
                                print("right")
                                if (homeCards.cards.count > cardCount+1){
                                    cardCount += 1
                                    homeCards.cards[cardCount].side = 0
                                    mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
                                    subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]

                                }
                            }
                        })
                .onTapGesture(count: 1){
                    if homeCards.cards[cardCount].side == 0 {
                        homeCards.cards[cardCount].side = 1
                        mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
                        subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]
                    }else {
                        homeCards.cards[cardCount].side = 0
                        mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
                        subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]
                    }
                }

                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                Text(" ")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                //Buttons
                HStack {
                    Button(action: {
                        tapNewSet(set: userSets)
                    }) {
                        Text("New Set")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))

                    }
                    Button(action: {
                        tapSettings()
                    }) {
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))

                    }

                }
                
                //Set List
                LazyVGrid(columns: singleGrid, content: {
                    ScrollView {
                        VStack{
                            ForEach(userSets.sets, id: \.self) { item in
                                Text(item.title)
                                    .padding()
                                    .font(.title)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                    .onTapGesture {
                                        tapOpenSet(passSet: item)
                                    }
                                    .onLongPressGesture {
                                        deleteSet = item
                                        showAlert = true
                                    }.alert(isPresented: $showAlert) {
                                        Alert(title: Text("Are you sure you want to delete this set?"), message: Text(deleteSet.title + " set will be gone forever..."), primaryButton: .destructive(Text("Delete")) {
                                                if let index = userSets.sets.firstIndex(of: deleteSet) {
                                                    userSets.sets.remove(at: index)
                                                    defaults.setValue(encodeSets(set: userSets), forKey: "userSets")
                                                }
                                        }, secondaryButton: .cancel())
                                    }

                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .center)
                }).onAppear(){
                    if defaults.value(forKey: "userSets") != nil {
                        userSets = decodeSet(data: defaults.value(forKey: "userSets") as! Data)
                    }
                    print(userSets.sets.count)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
        }
    }
}
