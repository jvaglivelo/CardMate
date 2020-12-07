//
//  ContentView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//

import SwiftUI

var singleGrid = [GridItem()]

var homeCards = CardSet(cards: [Card(mainText: ["Welcome to CardMate", "The controls are simple"], subText: ["Tap to flip", "Swipe right for the next card"]), Card(mainText: ["You can also swipe left to go back", "You can try it if you want"]), Card(mainText: ["Thats pretty much all the controls", "Enjoy!"], subText: ["You can create card sets below", ""])], title: "Home Set")

var cardCount = 0

var userSets:CardSets = CardSets(sets: [CardSet]())

func detectDirection(value: DragGesture.Value) -> String {
    if value.startLocation.x < value.location.x - 24 {
        return "left"
        }else if value.startLocation.x > value.location.x + 24 {
        return "right"
    }
    return "?"
  }

func tapNewSet() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: NewSetView())
        window.makeKeyAndVisible()
    }
}

struct MainView: View {
    @State var mainText = homeCards.cards[cardCount].mainText[homeCards.cards[cardCount].side]
    @State var subText = homeCards.cards[cardCount].subText[homeCards.cards[cardCount].side]
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("CardMate")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
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
                        Text(subText)
                    }
                    .onTapGesture(count: 1){
                        print("tapped")
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
                    .gesture(DragGesture()
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
                            }
                          )

                    .frame(width: UIScreen.main.bounds.size.width / 1.05, height: UIScreen.main.bounds.height/3, alignment: .center)
                    .background(Color(UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)))
                    .padding(10)
                    .cornerRadius(40)
                }
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                HStack {
                    Button(action: {
                        tapNewSet()
                    }) {
                        Text("New Set")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.blue))
                            .padding(.bottom)

                    }
                    Button(action: {
                        // What to perform
                    }) {
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.blue))
                            .padding(.bottom)

                    }

                }
                //Spacer()
                LazyVGrid(columns: singleGrid, content: {
                    ScrollView {
                        VStack{
                            ForEach(userSets.sets, id: \.self) { item in
                                Text(item.title)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                })
            }
            //Spacer()
        }.onAppear(){
            if defaults.value(forKey: "userSets") != nil {
                userSets = decodeSet(data: defaults.value(forKey: "userSets") as! Data)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
        }
    }
}
