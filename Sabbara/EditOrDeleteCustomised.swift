//
//  EditOrDeleteCustomised.swift
//  Sabbara
//
//  Created by Rand Alhassoun on 05/06/2023.
//

import SwiftUI

struct EditOrDeleteCustomised: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    var round: FetchedResults<Round>.Element

//    let count = Round.words.count

    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    @State private var showViewEditRound = false
    @State private var DeleteRound = false

    @Environment(\.managedObjectContext) var managedObjContext

    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var round: FetchedResults<Round>

    @State private var words: [String] = []

    @Environment(\.dismiss) var dismiss


    @State private var isDeletePopupVisible = false

    
    var body: some View {
        ZStack{
        NavigationView{
            //ZStack{
            VStack{
                // let count = round.words.count
                
                //                HStack(){
                //                    Spacer()
                //
                //                    Button(action: {
                //                        self.presentationMode.wrappedValue.dismiss()
                //                    }) {
                //
                //                        Image("xmark")
                //                            .resizable()
                //                            .frame(width: 23, height: 24)
                //                            .foregroundColor(.white)
                //                            .padding()
                //                    }.background(
                //                        Circle()
                //                            .fill(Color("Lpink"))
                //                            .frame(width: 42.16, height: 41)
                //
                //                    )
                //                    //.navigationBarBackButtonHidden(true)
                //                    //.navigationBarItems(leading: EmptyView())
                //                    //Spacer()
                //                }
                
                
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
                // .padding()
                
                Text((round.name!))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))  //Bold
                //.frame(width: 342, height: 58)
                    .border(Color.clear)
                    .padding()
                
                VStack(alignment: .leading){
                    // ScrollView{
                    
                    Text("Words")
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .font(.custom("TufuliArabicDEMO-Medium", size: 18))  //Bold
                    //.frame(width: 342, height: 58)
                        .border(Color.clear)
                    
                    //.font(.title3)
                    //.padding()
                    
                    ZStack {
                        
                        
                        
                        RoundedRectangle (cornerRadius: 10)
                            . foregroundColor (Color("LYellowShadow"))
                            .frame(width: 350 , height: 200)
                            .offset (x: Offset,y: offset)
                        RoundedRectangle (cornerRadius: 10)
                            .foregroundColor (Color("LYellow"))
                            .frame(width: 350 , height: 200)
                        
                        
                        
                        //Section(header: Text("Words").font(.title3)){
                        ScrollView {
                            VStack{
                                //                            ForEach(words.indices, id: \.self) { index in
                                
                                //ForEach(round.words?.indices, id: \.self) { index in
                                
                                
                                ForEach(round.words ?? [], id: \.self) { word in
                                    HStack {
                                        Spacer()
                                        Text(word)
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.center)
                                            .font(.custom("TufuliArabicDEMO-Medium", size: 24))  //Bold
                                            .frame(width: 342, height: 58)
                                            .border(Color.clear)
                                        
                                        //.frame(width: 300, height: 58)
                                        Spacer()
                                    }//h
                                }//for each
                            }//v
                            .frame(width: 350)
                        }//scroll
                        .frame(height: 200)
                        
                    }//z
                    
                    
                }//v
                .padding()
//                
//                Button("Edit Round"){
//                    //dismiss()
//                    
//                    showViewEditRound = true
//                    
//                    
//                    //dismiss()
//                    //dismiss()
//                    
//                    
//                }
//                .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
//                .padding()
                .fullScreenCover( isPresented: $showViewEditRound){
                    EditRoundView(round: round)
                }
                
                Button(action: {
                    deleteRound(round: round)
                    //isDeletePopupVisible = true
                    
                }) {
                    
                    Text("Delete Round")
                }
                .foregroundColor(Color("Lpink"))
                .buttonStyle(WhBigButton3D()).modifier(BigAndMediumButtonTextModifier())
                //.padding()
                //            .fullScreenCover( isPresented: $DeleteRound){
                //                deleteRound(round: round)
                //                   // (round: round)
                //                       }
                //                if isDeletePopupVisible {
                //                    DeletePopupView(isPOPVisible: $isDeletePopupVisible)
                //                        .frame(width: 304, height: 323)
                //                        .overlay(
                //                            RoundedRectangle(cornerRadius: 20)
                //                                .stroke(Color.black, lineWidth: 15)
                //                        ) // Add the overlay modifier to include the border
                //                        .background(Color.white)
                //                        .cornerRadius(10)
                //                }
                
                //                Group {
                //
                //                    if isDeletePopupVisible {
                //                        DeletePopupView(isPOPVisible: $isDeletePopupVisible)
                //                            .frame(width: 304, height: 323)
                //                            .overlay(
                //                                RoundedRectangle(cornerRadius: 20)
                //                                    .stroke(Color.black, lineWidth: 15)
                //                            ) // Add the overlay modifier to include the border
                //                            .background(Color.white)
                //                            .cornerRadius(10)
                //                    }
                //                }
                
                
                
                
                
            }//v final
            //.navigationTitle("Edit Round")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomNavEditOrDeleteCustomised())
            
            
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
            
            
            
            
            //}
            
        }
            
//        .overlay(
//            ZStack{
//                //  Color.black.opacity(0.5)
//                //Color.red
//                if isDeletePopupVisible {
//                    Color.black.opacity(isDeletePopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
//                        .ignoresSafeArea()
//                }
//                
//                
//                Group {
//                    
//                    if isDeletePopupVisible {
//                        DeletePopupView(round: round, isPOPVisible:  $isDeletePopupVisible)
//                        //DeletePopupView(isPOPVisible: $isDeletePopupVisible)
//                            .frame(width: 304, height: 323)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.black, lineWidth: 15)
//                            ) // Add the overlay modifier to include the border
//                            .background(Color.white)
//                            .cornerRadius(10)
//                    }
//                }
//                
//                
//                
//            }
//        )
    }


    }
    
    private func deleteRound(round: Round) {
        withAnimation {
            managedObjContext.delete(round)
            DataController().save(context: managedObjContext)
            self.presentationMode.wrappedValue.dismiss()

        }
    }
    
    
    
    
    
    
    
    
    
    //================
}


struct CustomNavEditOrDeleteCustomised: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("  Edit Round")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}


//struct EditOrDeleteCustomised_Previews: PreviewProvider {
//    static var previews: some View {
//        EditOrDeleteCustomised(round: <#T##FetchedResults<Round>.Element#>)
//    }
//}



//
////MARK: - Customize Delete user rounds PopUpView
//struct DeletePopupView: View {
//    var round: FetchedResults<Round>.Element
//    @Environment(\.managedObjectContext) var managedObjContext
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var goMain = false
//
//    @Binding var isPOPVisible: Bool // Use a binding to control the visibility of the popup
//
//    var body: some View {
//
//        VStack {
//            HStack {
//                Button(action: {
//                    isPOPVisible = false // Set isPOPVisible to false to hide the popup
//                }) {
//                    Image("xmark")
//                        .resizable()
//                        .frame(width: 23, height: 23)
//                        .foregroundColor(.white)
//                }
//
//                .background(
//                    Circle()
//                        .fill(Color("Lpink"))
//                        .frame(width: 42, height: 40)
//                )
//                .padding()
//
//                Text("Attention")
//                    .font(.custom("TufuliArabicDEMO-Medium", size: 40))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(Color("Lpink"))
//                    .padding(.trailing,50)
//
//                    .frame(width: 200,height: 50)
//
//            }    // End of HStack
//            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.black, lineWidth: 8)
//            )
//            //   }
//            Spacer()
//
//            Text("Are sure to Delete round ?")
//                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//                .foregroundColor(Color.black)
//
//                .padding(.bottom, 50)
//                .padding()
//
//            HStack {
//                Button(action: {
//                    // Delete round button action
//                    deleteRound(round: round)
//                    goMain.toggle()
//
//                }) {
//                    Text("Delete round")
//                        .font(.custom("TufuliArabicDEMO-Medium", size: 20))
//                        .foregroundColor(.white)
//                }
//                .buttonStyle(RedButton3D()).modifier(BigAndMediumButtonTextModifier())
//                //     .padding(.horizontal)
//
//                Button(action: {
//                    isPOPVisible = false // Hide the popup view
//                }) {
//                    Text("No")
//                        .bold()
//                        .font(.custom("TufuliArabicDEMO-Medium", size: 20))
//                        .foregroundColor(.white)
//                }
//                .buttonStyle(SmallButton3D())
//                .modifier(SmallButtonTextModifier())
//                //   .padding(.horizontal)
//            }
//
//            Spacer()
//        }
//
//        .background(Color.white)
//        .cornerRadius(10)
//        .fullScreenCover(isPresented: $goMain) {
//            ////                           MainRoundDescription(category: category) //
//              MainPage() //
//
//        }
//
//
//    }
//
//
//    private func deleteRound(round: Round) {
//        withAnimation {
//            managedObjContext.delete(round)
//            DataController().save(context: managedObjContext)
//            self.presentationMode.wrappedValue.dismiss()
//
//        }
//    }
//
//}
