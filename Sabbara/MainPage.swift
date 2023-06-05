//
//  MainPage.swift
//  sabar
//
//  Created by Nourah Almusaad on 04/06/2023.
//

import SwiftUI

struct MainPage: View {
    @State private var showSettingsPopUp = false
    @State var cat = ""
    
    
    //my
    @State private var isLinkActive = false
    @State private var showingAddView = false
    @State private var clickCount = 0
    @State private var isPopupShow = false
    
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    
    @State private var isPopupVisible = false
    
    
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var round: FetchedResults<Round>
    
    @State private var showRoundDescription = false
    
    //my
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                //                    if isPopupVisible {
                //                    Color.black.opacity(isPopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                //                    }
                VStack(alignment: .trailing) {
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack{
                            //
                            //                        if isPopupVisible {
                            //                            Color.black.opacity(isPopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                            //                        }
                            VStack{
                                BigingText()
                                //MyRound()
                                //{
                                //        NavigationView {
                                
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        Text("My round")
                                            .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                                            .foregroundColor(Color.black)
                                            .padding(.leading, 10)
                                        HStack (spacing: 15){
                                            
                                            Button(action: {
                                                
                                                if round.isEmpty{
                                                    showingAddView.toggle()
                                                    //print("rand right")
                                                }else{
                                                    //.onTapGesture {
                                                    //                                            ZStack {
                                                    //                                                if isPopupVisible {
                                                    //                                                    Color.black.opacity(isPopupVisible ? 0.5:0)
                                                    //                                                        .edgesIgnoringSafeArea(.all)
                                                    //                                                }
                                                    //                                            }
                                                    isPopupVisible = true
                                                    //}
                                                    //.padding()
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                            }) {
                                                Image("Plus")
                                                    .resizable()
                                                    .frame(width: 65, height: 65)
                                            }
                                            .buttonStyle(MainButton3D(shadowColor: Color("LYellowShadow"), buttonColor: Color("LYellow")))
                                            //}
                                            
                                            
                                            
                                            //                                    .overlay(
                                            //                                        Group {
                                            //
                                            //                                            if isPopupVisible {
                                            //                                                PopupView(isPOPVisible: $isPopupVisible)
                                            //                                                    .frame(width: 304, height: 323)
                                            //                                                    .overlay(
                                            //                                                        RoundedRectangle(cornerRadius: 20)
                                            //                                                            .stroke(Color.black, lineWidth: 15)
                                            //                                                    ) // Add the overlay modifier to include the border
                                            //                                                    .background(Color.white)
                                            //                                                    .cornerRadius(10)
                                            //                                            }
                                            //                                        }
                                            //                                )
                                            //
                                            
                                            ForEach(round) { round in
                                                // NavigationLink(destination: EditRoundView(round: round)) { //CustomisedRoundDescription
                                                NavigationLink(destination: CustomisedRoundDescription(round: round)) {
                                                    //HStack{
                                                    
                                                    ZStack {
                                                        Button(action: {
                                                            showRoundDescription = true
                                                        }) {
                                                            VStack {
                                                                Image(round.images ?? "SabbaraChar4")
                                                                    .resizable()
                                                                    .frame(width: 98.47, height: 108.89)
                                                                Text(round.name ?? "")
                                                                    .padding(.horizontal)
                                                                    .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                                                                
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        } // end button
                                                        .buttonStyle(Button3D(shadow: Color(round.colorsShadow ?? "DGreenShadow"), button: Color(round.colors ?? "DGreen")))
                                                        .fullScreenCover(isPresented: $showRoundDescription) {
                                                            // MainRoundDescription(category: category)
                                                            CustomisedRoundDescription(round: round)
                                                        }
                                                        
                                                        // }
                                                        
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                    HStack (spacing: 15){
                                        
                                        
                                    }//
                                    .frame(width: 350)
                                    
                                    
                                }
                                
                                .frame(width: 300 )
                                .fullScreenCover(isPresented: $showingAddView) {
                                    AddRoundView()
                                }
                                
                                .fullScreenCover(isPresented: $showingAddView) {
                                    AddRoundView()
                                }
                                
                                //}
                                //========================
                                GeneralRound()
                            }//v
                            
                            //
                            //                        if isPopupVisible {
                            //                            Color.black.opacity(isPopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                            //                                .ignoresSafeArea()
                            //                        }
                            
                            
                        }//z
                        //.ignoresSafeArea()
                        
                        
                    }
                    
                    // Spacer() // Add spacer to push the content to the top
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                    showSettingsPopUp = true
                    
                }) {
                    Image(systemName: "gearshape.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                        .foregroundColor(Color("Lpink"))
                }
                                    
                )
                .overlay(
                    Group {
                        if showSettingsPopUp {
                            SettingsPopUpView(isPresented: $showSettingsPopUp)
                        }
                    }
                )
                
                
                
                
                .overlay(
                    ZStack{
                        //  Color.black.opacity(0.5)
                        //Color.red
                        if isPopupVisible {
                            Color.black.opacity(isPopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                                .ignoresSafeArea()
                        }
                        
                        
                        Group {
                            
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
                        }
                        
                        
                        
                    }
                )
                
                
                //
                //                if isPopupVisible {
                //                    Color.black.opacity(isPopupVisible ? 0.5 : 0) .edgesIgnoringSafeArea(.all) // Black background when popup is shown
                //                        .ignoresSafeArea()
                //                }
            }//z
        } .navigationTitle(cat)
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}


struct BigingText: View {
    var body: some View {
        VStack(alignment:.leading){
            
            Text("Hello")
                .multilineTextAlignment(.leading)
                .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                .foregroundColor(Color.black)
            
            
            Text ("Choose one of amazing rounds or create your own round for more excitement")
                .multilineTextAlignment(.leading)
                .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                .foregroundColor(Color.black)
            
            
            
        }
        .padding()
    }
}
//MARK: - Customize button style

struct MainButton3D: ButtonStyle {
    var shadowColor: Color
    var buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let xOffset: CGFloat = 5
            let yOffset: CGFloat = 8
            /* Shadow reoundRectangle*/
            RoundedRectangle(cornerRadius: 21)
                .frame(width: 168, height: 143)
                .foregroundColor(shadowColor)
                .offset(x: xOffset, y: yOffset)
            
            /* ReoundRectangle*/
            RoundedRectangle(cornerRadius: 21)
                .frame(width: 166, height: 146)
                .foregroundColor(buttonColor)
                .offset(x: configuration.isPressed ? xOffset : 0, y: configuration.isPressed ? yOffset : 0)
            
            configuration.label
                .offset(x: configuration.isPressed ? xOffset : 0, y: configuration.isPressed ? yOffset : 0)
        } // End of Zstack
    } // End of view
    
} // End of struct

//MARK: - Customize User Round button
struct MyRound: View {
    @State private var isLinkActive = false
    @State private var showingAddView = false
    @State private var clickCount = 0
    @State private var isPopupShow = false
    
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    
    @State private var isPopupVisible = false
    
    
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var round: FetchedResults<Round>
    
    @State private var showRoundDescription = false
    
    //@State private var numRound = round.isEmpty
    
    // @State private var numRound = Round.con
    
    var body: some View {
        //        NavigationView {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("My round")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(Color.black)
                    .padding(.leading, 10)
                HStack (spacing: 15){
                    
                    Button(action: {
                        
                        if round.isEmpty{
                            showingAddView.toggle()
                            //print("rand right")
                        }else{
                            //.onTapGesture {
                            isPopupVisible = true
                            //}
                            //.padding()
                            
                            
                            
                        }
                        
                        
                        
                        // Handle Plus button action
                    }) {
                        Image("Plus")
                            .resizable()
                            .frame(width: 65, height: 65)
                    }
                    .buttonStyle(MainButton3D(shadowColor: Color("LYellowShadow"), buttonColor: Color("LYellow")))
                    //}
                    
                    
                    
                    .overlay(
                        Group {
                            
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
                        }
                    )
                    
                    
                    ForEach(round) { round in
                        // NavigationLink(destination: EditRoundView(round: round)) { //CustomisedRoundDescription
                        NavigationLink(destination: CustomisedRoundDescription(round: round)) {
                            //HStack{
                            
                            ZStack {
                                Button(action: {
                                    showRoundDescription = true
                                }) {
                                    VStack {
                                        Image(round.images ?? "SabbaraChar4")
                                            .resizable()
                                            .frame(width: 98.47, height: 108.89)
                                        Text(round.name ?? "")
                                            .padding(.horizontal)
                                            .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                                        
                                            .foregroundColor(Color.white)
                                    }
                                } // end button
                                .buttonStyle(Button3D(shadow: Color(round.colorsShadow ?? "DGreenShadow"), button: Color(round.colors ?? "DGreen")))
                                .fullScreenCover(isPresented: $showRoundDescription) {
                                    // MainRoundDescription(category: category)
                                    CustomisedRoundDescription(round: round)
                                }
                                
                                // }
                                
                            }
                        }
                        
                    }
                }
            }
            
            HStack (spacing: 15){
                
                
            }//
            .frame(width: 350)
            
            
        }
        .frame(width: 300 )
        .fullScreenCover(isPresented: $showingAddView) {
            AddRoundView()
        }
        
        .fullScreenCover(isPresented: $showingAddView) {
            AddRoundView()
        }
        
    }
    private func deleteRound(round: Round) {
        withAnimation {
            managedObjContext.delete(round)
            DataController().save(context: managedObjContext)
        }
    }
    
}



struct GeneralRound: View {
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 10)]
    // @State private var selectedCategory: Category?
    //@ObservedObject var CategoryList = RoundsViewModel() //rand added
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("General round")
                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                .foregroundColor(Color.black)
            
                .padding(.leading, 10)
            //MARK: - Hair
            //           CustomNavigationView(title: "Main") {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(CategoryList) { category in // viewModel
                    
                    CategoryCard(category: category)
                    
                    //   }
                    
                }//.padding()
            }
            
        }
        .padding()
        
    }
}


//MARK: - Customize SettingsPopUpView
struct SettingsPopUpView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.5)
                
                VStack {
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image("xmark")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            Circle()
                                .fill(Color("Lpink"))
                                .frame(width: 42, height: 40)
                        )
                        Spacer()
                        
                        Text("Settings")
                            .font(.custom("TufuliArabicDEMO-Medium", size: 30))
                            .foregroundColor(Color("Lpink"))
                            .padding(.trailing, 70)
                    }
                    .padding()
                    
                    SettingsView()
                    // Add your settings content here
                    
                    //                    Button(action: {
                    //                        isPresented = false
                    //                    }) {
                    //                        Button("حفظ"){}.buttonStyle(SaveButton3D()).modifier(SaveButtonTextModifier())
                    //                    }
                    //                    .padding(.bottom,50)
                }
                .frame(width: 304, height: 380)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 15)
                ) // Add the overlay modifier to include the border
                .background(Color.white)
                .cornerRadius(10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

//MARK: - Customize Save button
struct SaveButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
           // .bold()
            .foregroundColor(.white)
            .font(.custom("TufuliArabicDEMO-Medium", size: 24))
        //.font(.system(size: 24))
        
    }
    
}

struct SaveButton3D: ButtonStyle {
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
    }
    
}



//MARK: - Customize Limited rounds PopUpView
//struct PopupView: View {
//    @Binding var isPOPVisible: Bool // Use a binding to control the visibility of the popup
//    
//    
//    var body: some View {
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
//
//            Spacer()
//            
//            Text("You can create only one round, for more waiting for our next version")
//                .multilineTextAlignment(.center)
//                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//
//            Spacer().frame(height: 120)
//            
//            //print("not app")
//
//        }
//
//    }
//}
