//
//  CustomisedRoundDescription.swift
//  sabar
//
//  Created by Nourah Almusaad on 30/05/2023.
//

import SwiftUI

struct CustomisedRoundDescription: View {
    @State private var showViewPlaywTeam = false
    @State private var showViewGameStart = false
    @State private var showViewEditRound = false

    var round: FetchedResults<Round>.Element

 //   @State private var showViewEditView = false
    @State private var isDeletePopupVisible = false

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack{
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundColor(Color(round.colorsShadow ?? "DGreenShadow"))
                        .frame(width: 215, height: 177)
                        .offset(x: 5, y: 8)
                    
                    RoundedRectangle(cornerRadius: 21)
                        .foregroundColor(Color(round.colors  ?? "DGreen"))
                        .frame(width: 210, height: 177)
                    
                    Image(round.images ?? "SabbaraChar4")
                        .resizable()
                        .frame(width: 170, height: 140)
                }
                .padding()
                
                //                Text("Gen Z")
                //Text((round.name!))
                Text(round.name ?? "")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 28))
                    .frame(width: 342, height: 85)
                    .border(Color.clear)
                //                    .bold()
                //                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                //                    .padding()
                //
                Text("This is your round , You can create and think in coomon words with your friend")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 18))  //Bold
                    .frame(width: 342, height: 85)
                    .border(Color.clear)
                Spacer()
                //     .padding()
                
                Button("Start play"){
                    //if round.is
                    if ((round.words?.isEmpty) != nil)
                    {
                    //if round.isEmpty{
                        showViewGameStart = true
                    }
                }
                .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
                .padding()
                .fullScreenCover( isPresented: $showViewGameStart){
                    //GameStart()
                    //GameStart(categoryWords: round.words)
                    GameStart(categoryWords: round.words ?? [""])
                }
                //                NavigationLink("", destination:  GameStart(), isActive: $showView)
                Button("Play with Team") {
                    showViewPlaywTeam.toggle()
                }
                .buttonStyle(GreenBigButton3D()).modifier(BigAndMediumButtonTextModifier())
                //Spacer()
                .fullScreenCover(isPresented: $showViewPlaywTeam) {
                    PlayWithTeam(categoryWords: round.words ?? [""])
                    //OmnyaTeams(categoryWords: round.words ?? [""])

                }
                
                // Additional content and styling using the passed data
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            //.navigationBarItems(leading: CustomNavigationTitle())

            .toolbar {
                ToolbarItem(placement: .principal) {
                           // Center navigation bar item
                    CustomNavigationTitle()
                       }
            }
                
                
            .navigationBarItems(
                
                leading:
                    Button(action: {
                        // showViewEditView
                        //EditOrDeleteCustomised(round: round)
                        //showViewEditRound.toggle()
                        isDeletePopupVisible = true

                        
                    }) {
                        ZStack {
                            Image(systemName:"trash" )
                                .resizable()
                                .frame(width: 27, height: 26)
                                .foregroundColor(.white)
                            //                            onTapGesture {
                            //                                //deleteWord(at: index)
                            //                                //EditOrDeleteCustomised()
                            //                               // EditOrDeleteCustomised(round: round)
                            //
                            //                            }
                                .padding()
                            
                        }
                        
                        .background(
                            Circle()
                                .fill(Color("Lpink"))
                                .frame(width: 42.16, height: 41)
                            
                        )
                        //                        .fullScreenCover(isPresented: $showViewPlaywTeam) {
                        //                            EditOrDeleteCustomised()
                        //                               }
                        
                                        
                        
                      

                        
                        
                    }
                
                
                , trailing:
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
        
        
    .overlay(
        ZStack{
            //  Color.black.opacity(0.5)
            //Color.red
            if isDeletePopupVisible {
                Color.black.opacity(isDeletePopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                    .ignoresSafeArea()
            }


            Group {

                if isDeletePopupVisible {
                    DeletePopupView(round: round, isPOPVisible:  $isDeletePopupVisible)
                    //DeletePopupView(isPOPVisible: $isDeletePopupVisible)
                        .frame(width: 304, height: 323)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 15)
                        ) // Add the overlay modifier to include the border
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }



        }
    )
//        .fullScreenCover(isPresented: $showViewEditRound) {
//            //PlayWithTeam()
//             EditOrDeleteCustomised(round: round)
//
//               }
      
    }
}


struct CustomNavigationTitle: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("  My round")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}



//struct CustomisedRoundDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomisedRoundDescription(round: <#FetchedResults<Round>.Element#>)
//    }
//}




//MARK: - Customize Delete user rounds PopUpView
struct DeletePopupView: View {
    var round: FetchedResults<Round>.Element
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.presentationMode) var presentationMode

    @State private var goMain = false

    @Binding var isPOPVisible: Bool // Use a binding to control the visibility of the popup

    var body: some View {

        VStack {
            HStack {
                Button(action: {
                    isPOPVisible = false // Set isPOPVisible to false to hide the popup
                }) {
                    Image("xmark")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.white)
                }

                .background(
                    Circle()
                        .fill(Color("Lpink"))
                        .frame(width: 42, height: 40)
                )
                .padding()

                Text("Attention")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Lpink"))
                    .padding(.trailing,50)

                    .frame(width: 200,height: 50)

            }    // End of HStack
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 8)
            )
            //   }
            Spacer()

            Text("Are sure to Delete round ?")
                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                .foregroundColor(Color.black)

                .padding(.bottom, 50)
                .padding()

            HStack {
                Button(action: {
                    // Delete round button action
                    deleteRound(round: round)
                    //goMain.toggle()

                }) {
                    Text("Delete round")
                        .font(.custom("TufuliArabicDEMO-Medium", size: 20))
                        .foregroundColor(.white)
                }
                .buttonStyle(RedButton3D()).modifier(BigAndMediumButtonTextModifier())
                //     .padding(.horizontal)

                Button(action: {
                    isPOPVisible = false // Hide the popup view
                }) {
                    Text("No")
                        .bold()
                        .font(.custom("TufuliArabicDEMO-Medium", size: 20))
                        .foregroundColor(.white)
                }
                .buttonStyle(SmallButton3D())
                .modifier(SmallButtonTextModifier())
                //   .padding(.horizontal)
            }

            Spacer()
        }

        .background(Color.white)
        .cornerRadius(10)
        .fullScreenCover(isPresented: $goMain) {
            ////                           MainRoundDescription(category: category) //
              MainPage() //

        }


    }


    private func deleteRound(round: Round) {
        withAnimation {
            managedObjContext.delete(round)
            DataController().save(context: managedObjContext)
            //self.presentationMode.wrappedValue.dismiss()

        }
    }

}
