////
////  AllPopUps.swift
////  sabar
////
////  Created by Nourah Almusaad on 24/05/2023.
////
//
import SwiftUI

struct AllPopUps: View {
    @State private var isPopupVisible = false
    @State private var isDeletePopupVisible = false
    @State private var isFinishPopupVisible = false
    
    var body: some View {
        VStack {
            /* Limited round */
            Text("Click round")
                .onTapGesture {
                    isPopupVisible = true
                }
                .padding()
            
            if isPopupVisible {
                PopupView(isPOPVisible: $isPopupVisible)
                    .frame(width: 304, height: 323)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 15)
                    ) // Add the overlay modifier to include the border
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
            /* Delete round */
//            Text("Delete round")
//                .onTapGesture {
//                    isDeletePopupVisible = true
//                }
//                .padding()
//
//            if isDeletePopupVisible {
//               // DeletePopupView(isPOPVisible: $isDeletePopupVisible)
//                    .frame(width: 304, height: 323)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.black, lineWidth: 15)
//                    ) // Add the overlay modifier to include the border
//                    .background(Color.white)
//                    .cornerRadius(10)
//            }
            
            /* Delete round */
            Text("Finish round")
                .onTapGesture {
                    isFinishPopupVisible = true
                }
                .padding()
            
            if isFinishPopupVisible {
                FinishRoundPopupView(isPOPVisible: $isFinishPopupVisible)
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
}


//MARK: - Customize Limited rounds PopUpView
struct PopupView: View {
    @Binding var isPOPVisible: Bool // Use a binding to control the visibility of the popup
    
    @State private var showAlert = false

    var body: some View
    {
        ZStack{
            Color.black.opacity(0.5).ignoresSafeArea()
            

           //
           // Color.gray // Set the background color to gray

           // Color.white.opacity(showAlert ? 0.3 : 1.0)
            //Color.black.opacity(0.5).ignoresSafeArea()

           // Color.black.opacity(0.5)

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
            .background(Color.white)
            .cornerRadius(10)

            //   }
            
            Spacer()
            
            Text("You can create only one round, for more waiting for our next version")
                .multilineTextAlignment(.center)
                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
            
            Spacer().frame(height: 120)
            
            //print("not app")
            
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 15)
                .background(Color.white)
                .cornerRadius(10)
        )
        .background(Color.white)
        .cornerRadius(10)
            //.frame(width: 304, height: 562)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 15)
                ) // Add the overlay modifier to include the border
//                .background(Color.white)
//                .cornerRadius(10)

    }
    }
}


//
////MARK: - Customize Delete user rounds PopUpView
//struct DeletePopupView: View {
//    var round: FetchedResults<Round>.Element
//    @Environment(\.managedObjectContext) var managedObjContext
//    @Environment(\.presentationMode) var presentationMode
//
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
//        .background(Color.white)
//        .cornerRadius(10)
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

//MARK: - Customize Finish rounds PopUpView
struct FinishRoundPopupView: View {
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
            
            Text("Are sure to finish round ?")
                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                .padding(.bottom, 50)
                .padding()
            
            HStack {
                Button(action: {
                    // Delete round button action
                }) {
                    Text("Finish round")
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
        
    }
}

struct AllPopUps_Previews: PreviewProvider {
    static var previews: some View {
        AllPopUps()
    }
}
