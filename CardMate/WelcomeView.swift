//
//  WelcomeView.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//
//  Credits : https://medium.com/better-programming/creating-an-apple-like-splash-screen-in-swiftui-fdeb36b47e81

import SwiftUI

let defaults = UserDefaults.standard

func tapContinue() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: MainView())
        window.makeKeyAndVisible()
    }
}


struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            TitleView()
            WelcomeContainerView()
            Spacer(minLength: 30)
            
            Button(action: {
                tapContinue()
                defaults.setValue(false, forKey: "newUser")
            })
            {
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

        }).onAppear(){
            if (defaults.value(forKey: "newUser") == nil){
                defaults.setValue(true, forKey: "newUser")
            }else if (defaults.bool(forKey: "newUser") == false){
                tapContinue()
            }
        }
    }
}
struct WelcomeDetailView: View {
    var title = ""
    var subTitle = ""
    var image = ""
    
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
            WelcomeDetailView(title: "Study", subTitle: "", image: "slider.horizontal.below.rectangle")

            WelcomeDetailView(title: "Learn", subTitle: "", image: "minus.slash.plus")

            WelcomeDetailView(title: "Master", subTitle: "", image: "checkmark.square")
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
