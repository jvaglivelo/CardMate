//
//  SettingsView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/7/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                
                //Title
                Text("CardMate")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.purple)
                    .padding()
                
                //Erase All Button
                VStack{
                    Text("Erase All Sets")
                        .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
                    Button(action: {
                        defaults.setValue(CardSets(sets: [CardSet]()), forKey: "userSets")
                        print(newSet.cards.count)
                    }) {
                        Text("Erase")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.purple))
                            .padding(.bottom)

                    }
                }
                Spacer()
                
                //Return Button
                Button(action: {
                    tapGoBack()
                }) {
                    Text("Go Back")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.purple))
                        .padding(.bottom)

                }

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
