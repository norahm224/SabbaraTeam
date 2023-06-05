//
//  Splash.swift
//  sabar
//
//  Created by Nourah Almusaad on 03/06/2023.
//

import SwiftUI

struct Splash: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State var rotationAngle: Angle = .degrees(0)
    @State private var showNewPage = false
    
  
//    @State var rotationAngle: Angle = .degrees(0)
//
//
//    @State private var showNewPage = false
    
    var body: some View {
        ZStack {
            if isActive {
                // ExploreCategories()
                MainPage()
                  
            } else {
                ZStack {
                    (Color("Lpink"))
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        
                        Image("SabbaraSplashRight")
                                   .resizable()
                                   .frame(width: 400, height: 400)
                                   .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 3 + 20,height: UIScreen.main.bounds.height / 4 - 1,  alignment: .leading)                                   .rotationEffect(rotationAngle)
                                .animation(Animation.easeInOut(duration: 0.50).repeatForever(autoreverses: true))
                                .onAppear {
                                    withAnimation(.linear(duration: 0.50).repeatForever(autoreverses: true)) {
                                        rotationAngle = Angle(degrees: 3)
                                    }
                                }
                     Spacer()
                        Text("Sabbara")
                            .font(.custom("TufuliArabicDEMO-Medium", size: 96))
                            .foregroundColor(.white)
                        Spacer()
                        
                        Image("SabbaraSplashLeft")
                            .resizable()
                            .frame(width: 400, height: 400)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2 - 60,height: UIScreen.main.bounds.height / 4 - 1,  alignment: .trailing)
                            .rotationEffect(rotationAngle)
                            .animation(Animation.easeInOut(duration: 0.50).repeatForever(autoreverses: true))
                            .onAppear {
                                withAnimation(.linear(duration: 0.50).repeatForever(autoreverses: true)) {
                                    rotationAngle = Angle(degrees: 3)
                                }
                            }
                          Spacer()
                      }
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    } .accentColor((Color("Lpink")))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SoundManager.instance.playSound(sound: .SabbaragameMusic)
            }
        }
    }
}


struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
