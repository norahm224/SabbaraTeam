//
//  MainRoundDescription.swift
//  sabar
//
//  Created by Nourah Almusaad on 30/05/2023.
//

import SwiftUI

struct MainRoundDescription: View {
  //  @Binding var selectedPlayMode: PlayMode?


    
    var category: Rounds
    
    @State private var showViewPlaywTeam = false
    @State private var showViewGameStart = false
    @Environment(\.presentationMode) var presentationMode
    
    var quickGame = "Quick Game"
    var playWithTeam = "Play with Team"
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundColor(category.shadowColor)
                        .frame(width: 215, height: 177)
                        .offset(x: 5, y: 8)
                    
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundColor(category.buttonColor)
                        .frame(width: 210, height: 177)
                    
                    Image(category.image)
                        .resizable()
                        .frame(width: 170, height: 140)
                }
                Text(category.name)
                    .bold()
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.black)
                    .padding()
                
                Text(category.description)
                    .foregroundColor(Color.black)
                
                    .multilineTextAlignment(.center)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                    .frame(width: 340, height: 88)
                    .border(Color.clear)
                Spacer()
                
                Button("Start play"){
                    showViewGameStart = true
                    //quickGame = "Quick Game"
                    
                }     .buttonStyle(BigButton3D())
                    .modifier(BigAndMediumButtonTextModifier())
                    .padding()
                    .fullScreenCover( isPresented: $showViewGameStart){
                        //GameStart()
                        GameStart(categoryWords: category.words)
                           }
                

                        Button("Play with Team") {
                            showViewPlaywTeam = true
                        }
                        .buttonStyle(GreenBigButton3D()).modifier(BigAndMediumButtonTextModifier())

                        //.buttonStyle(BigButton3D()
                                     
                        //.modifier(BigAndMediumButtonTextModifier())
//                        .fullScreenCover(isPresented: $showViewPlaywTeam) {
//                           // PlayWithTeam()
//                               }
                        .fullScreenCover(isPresented: $showViewPlaywTeam) {
                            //
                           // OmnyaTeams(categoryWords: category.words)
                            PlayWithTeam(categoryWords: category.words)
                            
                               }
                    }
//            .navigationBarItems(leading: CustomNavMainRoundDescription())
//            .navigationBarTitleDisplayMode(.inline)
//
            .navigationBarBackButtonHidden(true)
            //.navigationBarItems(leading: CustomNavigationTitle())

            .toolbar {
                ToolbarItem(placement: .principal) {
                           // Center navigation bar item
                    CustomNavMainRoundDescription()
                       }
            }

            
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Image("xmark")
                                .resizable()
                                .frame(width: 23, height: 24)
                                .foregroundColor(.white)
                                .padding()
                               
                        }
                     
                        .background(
                            Circle()
                                .fill(Color("Lpink"))
                                .frame(width: 42.16, height: 41)
                                
                        )
                        }
                   
                   
                )
            }
          
        }
    }

//struct MainRoundDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        //MainRoundDescription(category: CategoryList[0])
//        MainRoundDescription(selectedPlayMode: $selectedPlayMode, category: CategoryList[0])
//
//
//
//    }
//}



struct CustomNavMainRoundDescription: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("General round")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}
