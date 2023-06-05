//
//  CategoryCard.swift
//  Sabbara
//
//  Created by Rand Alhassoun on 05/06/2023.
//

import SwiftUI

struct CategoryCard: View {
var category: Rounds
@State private var showRoundDescription = false

var body: some View {
    ZStack {
        Button(action: {
            showRoundDescription = true
        }) {
            VStack {
                Image(category.image)
                    .resizable()
                    .frame(width: 98.47, height: 108.89)
                Text(category.name)
                    .padding(.horizontal)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 18))

                   //.font(.custom("BalooBhaijaan-Regular", size: 18))
                    .foregroundColor(Color.white)
            }
        } // end button
        .buttonStyle(Button3D(shadow: category.shadowColor, button: category.buttonColor))
        .fullScreenCover(isPresented: $showRoundDescription) {
                           MainRoundDescription(category: category)
                                    }
        
    }
}
}
//MARK: - Customize button style

struct Button3D: ButtonStyle {
var shadow: Color
var button: Color

func makeBody(configuration: Configuration) -> some View {
    ZStack {
        let xOffset: CGFloat = 5
        let yOffset: CGFloat = 8
    /* Shadow reoundRectangle*/
        RoundedRectangle(cornerRadius: 21)
            .frame(width: 168, height: 143)
            .foregroundColor(shadow)
            .offset(x: xOffset, y: yOffset)
        
        /* ReoundRectangle*/
        RoundedRectangle(cornerRadius: 21)
            .frame(width: 166, height: 146)
            .foregroundColor(button)
            .offset(x: configuration.isPressed ? xOffset : 0, y: configuration.isPressed ? yOffset : 0)
        
        configuration.label
            .offset(x: configuration.isPressed ? xOffset : 0, y: configuration.isPressed ? yOffset : 0)
    } // End of Zstack
} // End of view
} // End of struct

struct CategoryCard_Previews: PreviewProvider {
static var previews: some View {
CategoryCard(category: CategoryList[0])
}
}
