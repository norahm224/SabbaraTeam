//
//  AllModifiers.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 18/05/2023.
//

// MARK: - INSTRUCTIONS FOR ALL:
//This is how to use the modifier in your code:
//Button("ابدأ اللعب"){}.buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())

import SwiftUI
// MARK: - : BigAndMediumButton:
struct BigAndMediumButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundColor(.white)
            .font(.custom("TufuliArabicDEMO-Medium", size: 24))
        //.font(.system(size: 24))
        
    }}
struct BigButton3D: ButtonStyle {
    func makeBody (configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 10
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 350 , height: 58)
                . foregroundColor (Color("LpinkShadow"))
                .offset (y: offset)
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 350 , height: 58)
                .foregroundColor (Color("Lpink"))
                .offset (y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset (y: configuration.isPressed ? offset : 0)
        }
        //. compositingGroup()
    }}
struct MediumButton3D: ButtonStyle {
    func makeBody (configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 10
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 244.99 , height: 50)
                . foregroundColor (Color("LpinkShadow"))
                .offset (y: offset)
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 244.99 , height: 50)
                .foregroundColor (Color("Lpink"))
                .offset (y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset (y: configuration.isPressed ? offset : 0)
        }
        //. compositingGroup()
    }}
// MARK: - : SmallButton:
struct SmallButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundColor(.white)
            .font(.custom("TufuliArabicDEMO-Medium", size: 18))
        //.font(.system(size: 24))
        
    }}
struct SmallButton3D: ButtonStyle {
    func makeBody (configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 10
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 132 , height: 50)
                . foregroundColor (Color("LpinkShadow"))
                .offset (y: offset)
            RoundedRectangle (cornerRadius: 10)
                .frame(width: 132 , height: 50)
                .foregroundColor (Color("Lpink"))
                .offset (y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset (y: configuration.isPressed ? offset : 0)
        }
        //. compositingGroup()
    }}

struct AllModifiers: View {
    var body: some View {
        VStack{
            Button("ابدأ اللعب"){}.buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
            Button("حفظ"){}.buttonStyle(MediumButton3D()).modifier(BigAndMediumButtonTextModifier())
            Button("المتابعة"){}.buttonStyle(SmallButton3D()).modifier(SmallButtonTextModifier())

        }
            }
}


struct AllModifiers_Previews: PreviewProvider {
    static var previews: some View {
        AllModifiers()
    }
}
