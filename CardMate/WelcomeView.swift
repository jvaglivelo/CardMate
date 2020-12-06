//
//  WelcomeView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            TitleView()
            WelcomeContainerView()
            Spacer(minLength: 30)
            
            Button(action: {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.blue))
                    .padding(.bottom)

            }
            .padding(.horizontal)

        })
    }
}
struct WelcomeDetailView: View {
    var title = "Welcome"
    var subTitle = "Here"
    var image = "car"
    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .accessibility(hidden: true)
            VStack(alignment: .center, spacing: nil, content: {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

            })
        })
        .padding(.top)
    }
}

struct WelcomeContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            WelcomeDetailView(title: "Match", subTitle: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.", image: "slider.horizontal.below.rectangle")

            WelcomeDetailView(title: "Precise", subTitle: "More precision with the steppers to get that 100 score.", image: "minus.slash.plus")

            WelcomeDetailView(title: "Score", subTitle: "A detailed score and comparsion of your gradient and the target gradient.", image: "checkmark.square")
        }
        .padding(.horizontal)
    }
}

struct TitleView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Text("Welcome to")
                .fontWeight(.black)
                .font(.system(size: 36))

            Text("CardMate")
                .fontWeight(.black)
                .font(.system(size: 36))
                .foregroundColor(.blue)
        })
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
