//
//  CharacterCustomised.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 24/05/2023.
//
import SwiftUI

struct CharacterCustomised: View {
   @State private var selectedColor: Color = Color("DGreen")
   @State private var selectedShadow: Color = Color("DGreenShadow")
   @State private var selectedSabbara: Image = Image("SabbaraChar2")

   var body: some View {
       VStack {
           ZStack {
               RoundedRectangle(cornerRadius: 10)
                   .frame(width: 215, height: 177)
                   .foregroundColor(selectedShadow)
               //
                   .offset(x: 5, y: 10)

               RoundedRectangle(cornerRadius: 10)
                   .frame(width: 210, height: 177)
                   .foregroundColor(selectedColor)

               selectedSabbara
                   .resizable()
                   .frame(width: 140, height: 140)
                   .cornerRadius(1)
           }

           Text("GenZ")
               .font(.custom("BalooBhaijaan-Regular", size: 28))
               .foregroundColor(.black)
               .padding()

           VStack {
               Text("Choose your color")
                   .font(.title2)
                   .fontWeight(.regular)
                   .foregroundColor(.black)
                   .multilineTextAlignment(.trailing)

               HStack {
                   ZStack{
                       RoundedRectangle(cornerRadius: 10)
                           .frame(width: 71, height: 61)
                           .foregroundColor(Color("LYellowShadow"))
                           .offset(x:2.5 ,y: 5)

                       RoundedRectangle(cornerRadius: 10)
                           .frame(width:  69.21, height: 59.37)
                           .foregroundColor(Color("LYellow"))

                           .onTapGesture {
                               selectedColor = Color("LYellow")
                               selectedShadow = Color("LYellowShadow")
                           }
                   }

                   ZStack{

                       RoundedRectangle(cornerRadius: 10)
                           .frame(width: 71, height: 61)
                           .foregroundColor(Color("LpinkShadow"))
                           .offset(x:2.5 ,y: 5)

                       RoundedRectangle(cornerRadius: 10)
                           .frame(width:  69.21, height: 59.37)
                           .foregroundColor(Color("Lpink"))

                           .onTapGesture {
                               selectedColor = Color("Lpink")
                               selectedShadow = Color("LpinkShadow")
                           }
                   }

                   ZStack{
                       RoundedRectangle(cornerRadius: 10)
                           .frame(width: 71, height: 61)
                           .foregroundColor(Color("DPurpleShadow"))
                           .offset(x:2.5 ,y: 5)

                       RoundedRectangle(cornerRadius: 10)
                           .frame(width:  69.21, height: 59.37)
                           .foregroundColor(Color("DPurple"))

                           .onTapGesture {
                               selectedColor = Color("DPurple")
                               selectedShadow = Color("DPurpleShadow")
                           }
                   }

                   ZStack{
                       RoundedRectangle(cornerRadius: 10)
                           .frame(width: 71, height: 61)
                           .foregroundColor(Color("DGreenShadow"))
                           .offset(x:2.5 ,y: 5)

                       RoundedRectangle(cornerRadius: 10)
                           .frame(width:  69.21, height: 59.37)
                           .foregroundColor(Color("DGreen"))

                           .onTapGesture {
                               selectedColor = Color("DGreen")
                               selectedShadow = Color("DGreenShadow")
                           }
                   }
               } //HStackAllColors

//                Spacer()
           } //VStackColorsAndCactus
           .padding()
           VStack {
               Text("Choose your Sabbara")
                   .font(.title2)
                   .fontWeight(.regular)
                   .foregroundColor(.black)
                   .multilineTextAlignment(.trailing)

               HStack {

                   Image("SabbaraChar4")
                       .resizable()
                       .frame(width: 69.21, height: 57)
                       .cornerRadius(1)
                       .onTapGesture {
                           selectedSabbara = Image("SabbaraChar4")

                       }

                   Image("SabbaraChar3")
                       .resizable()
                       .frame(width: 69.21, height: 57)
                       .cornerRadius(1)
                       .onTapGesture {
                           selectedSabbara = Image("SabbaraChar3")
                       }

                   Image("SabbaraChar1")
                       .resizable()
                       .frame(width: 69.21, height: 57)
                       .cornerRadius(1)
                       .onTapGesture {
                           selectedSabbara = Image("SabbaraChar1")
                       }

                   Image("SabbaraChar2")
                       .resizable()
                       .frame(width: 44.88, height: 57)
                       .cornerRadius(1)

                       .onTapGesture {
                           selectedSabbara = Image("SabbaraChar2")
//                                .resizable()
//                                .frame(width: 44.88, height: 57) as! Image


                       }

               } //AllImagesHStack
               .padding(.leading)
           }
//            .padding(.bottom, 130.0)
           Spacer()

           HStack{

           ZStack{
                           Button("Back"){}.buttonStyle(SmallButton3D()).modifier(BigAndMediumButtonTextModifier())

           }
           .padding(30.0)



               ZStack{
                   Button("Next"){}.buttonStyle(SmallButton3D()).modifier(BigAndMediumButtonTextModifier())


                                               }


                                       } //Buttons
           .padding(.trailing)
       } //BigVStack
   } //allView

}


struct CharacterCustomised_Previews: PreviewProvider {
   static var previews: some View {
       CharacterCustomised()
   }
}
