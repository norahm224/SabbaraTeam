//
//  PlayWithTeam.swift
//  sabar
//
//  Created by Nourah Almusaad on 03/06/2023.
//

import SwiftUI

struct PlayWithTeam: View {


    //var category: Rounds

    var categoryWords: [String]


    @State private var showView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Game rules ")
                    .foregroundColor(Color.black)

                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .padding(30)
                Text("This games make to divide memebers to two team and choose one to be team leader and friends, member try to explain the word to their team leader ")
                    .foregroundColor(Color.black)

                    .multilineTextAlignment(.center)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 20))
                    .padding()
                
                HStack {
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("DGreenShadow"))
                                .frame(width: 126.49, height: 127.23)
                                //.offset(x: 5, y: 10)

                            Circle()
                                .foregroundColor(Color("DGreen"))
                                .frame(width: 129.71, height: 131.28)
                            
                            Image("SabbaraChar3")
                                .resizable()
                                .frame(width: 96.68, height: 79.41)
                            
                        }
                        Text("Team 1")
                            .foregroundColor(Color.black)

                            .font(.custom("TufuliArabicDEMO-Medium", size: 20))
                    }
                    
                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("DPurpleShadow"))
                                .frame(width: 126.49, height: 127.23)
                                //.offset(x: 5, y: 10)
                            
                            Circle()
                                .foregroundColor(Color("DPurple"))
                                .frame(width: 129.71, height: 131.28)
                            
                            Image("SabbaraChar1")
                                .resizable()
                                .frame(width: 96.68, height: 79.41)
                            
                        }
                        Text("Team 2")
                            .foregroundColor(Color.black)

                            .font(.custom("TufuliArabicDEMO-Medium", size: 20))
                    }
                }
                .padding(40)
                Spacer()
                Button("Start play"){
                    showView.toggle()
                }    .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
                    .padding()
                    .modifier(BigAndMediumButtonTextModifier())
                    .padding()
//                NavigationLink("", destination:  OmnyaTeams(categoryWords: categoryWords ), isActive: $showView)
               // Spacer()
                    .fullScreenCover( isPresented: $showView){
                        //GameStart()
                        //GameStart(categoryWords: round.words)
                        OmnyaTeams(categoryWords: categoryWords)
                    }
            }
            //showView

//            .fullScreenCover( isPresented: $showView){
//                //GameStart()
//                //GameStart(categoryWords: round.words)
//                OmnyaTeams(categoryWords: round.words ?? [""])
//            }

            .navigationBarBackButtonHidden(true)
            //.navigationTitle(PlayWithTeamTitel())
               
            .toolbar {
                ToolbarItem(placement: .principal) {
                           // Center navigation bar item
                           PlayWithTeamTitel()
                       }
            }
            
            
            
            
            
            
            
            //.navigationBarItems(leading: PlayWithTeamTitel())
            

            //.navigationBarTitleDisplayMode(.inline)
            //.foregroundColor(Color.black)
            //.padding()
            
            //Spacer()

            //.font(.custom("TufuliArabicDEMO-Medium", size: 24))
   

           
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


struct PlayWithTeamTitel: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("  Play With Team")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}

//
//struct PlayWithTeam_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayWithTeam()
//    }
//}
