//
//  EditRoundView.swift
//  CoreTestSabbara
//
//  Created by Rand Alhassoun on 24/05/2023.



import SwiftUI

struct EditRoundView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var round: FetchedResults<Round>.Element
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: []) var fetchedResults: FetchedResults<Round>
    
    @State private var name = ""
    @State private var selectedImage = "SabbaraChar2"
    @State private var colors = "DGreen"
    @State private var colorsShadow = "DGreenShadow"
    @State private var words: [String] = []
    
    @State private var newWord = ""
    @State private var errorMessage = ""
    
    @State private var goMain = false

    
    @State private var isEnteringImages = false
    @State private var isEnteringWords = true
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack{
                
            if isEnteringWords {
                
                EditNameView(name: $name, nextAction: {
                    isEnteringWords = false
                    isEnteringImages = true
                }, round: round)
                
                
                //.navigationBarHidden(true)
            } else if isEnteringImages {
                
                EditImageView(selectedImage: $selectedImage, selectedcolors: $colors, selectedcolorsShadow: $colorsShadow, nextAction: {
                    isEnteringImages = false
                    submitEditAction()
                    //MainPage()

                }, BackAction: {
                    isEnteringWords = true
                    
                }, round: round)
                //.navigationBarHidden(true)
            } else {
                EditWordView(words: $words, newWord: $newWord, errorMessage: $errorMessage, submitEditAction: submitEditAction, round: round)
                
                //MainPage()

                    //.navigationBarHidden(true)
            }
            
 
            
        }       // .navigationTitle("Edit Round")
                .padding()
            
                    .fullScreenCover(isPresented: $goMain) {
                        ////                           MainRoundDescription(category: category) //
                          MainPage() //
                        
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

        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomNavEditRoundView())
        

        }//.navigationTitle("Edit Round")
    }
    
    private func submitEditAction() {
        if words.count >= 20 { // Check if minimum word count is met

            DataController().editRound(Round: round, name: name, images: selectedImage, words: words, colors: colors, colorsShadow: colorsShadow, context: managedObjContext)
            goMain.toggle()
            
           // dismiss()
          

            
        } else {
            errorMessage = NSLocalizedString("Minimum word count not met. Please enter at least 20 words.", comment: "")
                

        }
    }


}

//MARK: - Name
struct EditNameView: View {
    @Binding var name: String
    var nextAction: () -> Void
    
    var round: FetchedResults<Round>.Element // Uncomment and define the round variable
    

    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    var body: some View {
        
        VStack(/*alignment: .leading*/){
            //Spacer()
            
            VStack(alignment: .leading){
                Text("Name")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(Color.black)
                    .padding()
                
                ZStack {
                    
                    let offset: CGFloat = 10
                    RoundedRectangle (cornerRadius: 10)
                        .frame(width: 350 , height: 58)
                        . foregroundColor (Color("LYellowShadow"))
                        .offset (x: Offset,y: offset)
                    RoundedRectangle (cornerRadius: 10)
                        .frame(width: 350 , height: 58)
                        .foregroundColor (Color("LYellow"))
                    
                    
                    TextField("\(round.name!)", text: $name)
                        .frame(width: 340 , height: 58)
                        .onAppear {
                            name = round.name!}
                }

            }//v
                //}
                .padding()
            
            
            Text("Maximum 10 letters")
                .font(.custom("TufuliArabicDEMO-Medium", size: 18))
                .foregroundColor(Color.black)

                //.font(.caption2)
            Spacer()
            Spacer()
            HStack{

                Button("Next") {
                    nextAction()
                }
                .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())

            }
        }.padding()

    }
}


//MARK: - Image

struct EditImageView: View {

    @Binding var selectedImage: String
    @Binding var selectedcolors: String
    @Binding var selectedcolorsShadow: String



    var nextAction: () -> Void
    var BackAction: () -> Void

    
    var round: FetchedResults<Round>.Element // Uncomment and define the round variable


    @State private var selectedColor: Color = Color("DGreen")
    @State private var selectedShadow: Color = Color("DGreenShadow")
    @State private var selectedSabbara: Image = Image("SabbaraChar2")
    //@State private var selectedImage: String = "SabbaraChar2"//Image("SabbaraChar2")

    var body: some View {
        VStack {


                     
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 215, height: 177)
                        .foregroundColor(selectedShadow)

                        .offset(x: 5, y: 10)

                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 210, height: 177)
                        .foregroundColor(selectedShadow)

                    selectedSabbara
                        .resizable()
                        .frame(width: 140, height: 140)
                        .cornerRadius(1)
                }


                VStack {
                    Text("Choose your color")
                        .font(.custom("TufuliArabicDEMO-Medium", size: 24))

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
                                    selectedcolors = "LYellow"
                                    selectedShadow = Color("LYellowShadow")
                                    selectedcolorsShadow = "LYellowShadow"
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
                                    selectedcolors = "Lpink"
                                    selectedShadow = Color("LpinkShadow")
                                    selectedcolorsShadow = "LpinkShadow"
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
                                    selectedcolors = "DPurple"
                                    selectedShadow = Color("DPurpleShadow")
                                    selectedcolorsShadow = "DPurpleShadow"
                                    
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
                                    selectedcolors = "DGreen"
                                    selectedShadow = Color("DGreenShadow")
                                    selectedcolorsShadow = "DGreenShadow"
                                }
                        }
                    } //HStackAllColors

     //                Spacer()
                } //VStackColorsAndCactus
                .padding()
                VStack {
                    Text("Choose your Sabbara")
                        .font(.custom("TufuliArabicDEMO-Medium", size: 24))

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
                                selectedImage = "SabbaraChar4"

                            }

                        Image("SabbaraChar3")
                            .resizable()
                            .frame(width: 69.21, height: 57)
                            .cornerRadius(1)
                            .onTapGesture {
                                selectedSabbara = Image("SabbaraChar3")
                                selectedImage = "SabbaraChar3"

                            }

                        Image("SabbaraChar1")
                            .resizable()
                            .frame(width: 69.21, height: 57)
                            .cornerRadius(1)
                            .onTapGesture {
                                selectedSabbara = Image("SabbaraChar1")
                                selectedImage = "SabbaraChar1"

                            }

                        Image("SabbaraChar2")
                            .resizable()
                            .frame(width: 44.88, height: 57)
                            .cornerRadius(1)

                            .onTapGesture {
                                selectedSabbara = Image("SabbaraChar2")
                                selectedImage = "SabbaraChar2"



                            }

                    } //AllImagesHStack
                    .padding(.leading)
                }
                Spacer()
                .padding(.trailing)
            }

            HStack{

                Button("Next") {
                    nextAction()
                }
                .buttonStyle(SmallButton3D()).modifier(SmallButtonTextModifier())
                
                Button("Back") {
                    //nextAction()
                    BackAction()
                    

                }
                .foregroundColor(Color("Lpink"))
                .buttonStyle(WhSmallButton3D()).modifier(BigAndMediumButtonTextModifier())

            }

        }
        .padding()
    }
}

//MARK: - Image

struct EditWordView: View {
    @Binding var words: [String]
    @Binding var newWord: String
    @Binding var errorMessage: String
    var submitEditAction: () -> Void
    
    //@State private var goMain = false

    var round: FetchedResults<Round>.Element
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    @Environment(\.presentationMode) var presentationMode

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
//            VStack(alignment: .leading) {
//                Text("Words")
//                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//                    .foregroundColor(Color.black)
//                    .padding()
//
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color("LYellowShadow"))
//                        .frame(width: 350, height: 350)
//                        .offset(x: Offset, y: offset)
//
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color("LYellow"))
//                        .frame(width: 350, height: 350)
//
//                    ScrollView {
//                        VStack {
//                            ForEach(words.indices, id: \.self) { index in
//                                HStack {
//                                    Spacer()
//
//                                    TextField("Word \(index + 1)", text: $words[index])
//                                        .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//
//                                        .frame(width: 300, height: 58)
//
//                                    Spacer()
//
//                                    Image(systemName: "trash.circle.fill")
//                                        .resizable()
//                                        .frame(width: 25, height: 25)
//                                        .foregroundColor(.red)
//                                        .onTapGesture {
//                                            deleteWord(at: index)
//                                        }
//
//                                    Spacer()
//                                }
//                            }
//                        }
//                        .frame(width: 350)
//                    }
//                    .frame(height: 350)
//                }
//            }
            
            VStack(alignment: .leading){
                
                
                Text("Words")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))

                    //.modifier(BigAndMediumButtonTextModifier())

                    .font(.title3)
                    .padding()
                
                ZStack {
                    
                    
                    RoundedRectangle (cornerRadius: 10)
                        . foregroundColor (Color("LYellowShadow"))
                        .frame(width: 350 , height: 350)
                        .offset (x: Offset,y: offset)
                    RoundedRectangle (cornerRadius: 10)
                        .foregroundColor (Color("LYellow"))
                        .frame(width: 350 , height: 350)
                    
                    
                    ScrollView {
                        
                        VStack{
                            ForEach(words.indices, id: \.self) { index in
                                
                                
                                HStack{
                                    Spacer()
                                    
                                    TextField("Word \(index + 1)", text: $words[index])
                                        .frame(width: 300 , height: 58)
                                    
                                    
                                    Spacer()
                                    Image(systemName:"trash.circle.fill" )
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color("Lpink"))
                                        .onTapGesture {
                                            deleteWord(at: index)
                                        }
                                    Spacer()
                                    
                                    
                                }//H
                            }
                            
                        }.frame(width: 350)
                        
                    } .frame(height: 350)
                    
                }//z
            }//v
            Spacer()

            .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 58)
                    .foregroundColor(Color("LYellowShadow"))
                    .offset(x: Offset, y: offset)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 58)
                    .foregroundColor(Color("LYellow"))
                
                Button(action: addWord) {
                    Label("Add Word" , systemImage: "plus.circle")
                }
                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                .foregroundColor(Color.black)
            }
            
            Text(errorMessage)
                .font(Font.custom("TufuliArabicDEMO-Medium", size: 18))
                //.font(.title3)
                .foregroundColor(.red)
                .padding()
            
            Button("Submit") {
                submitEditAction()


                

            }
            .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
            
            
        }
        
//        .fullScreenCover(isPresented: $goMain) {
////                           MainRoundDescription(category: category)
//            MainPage()
//                                    }
        
        .padding()
        .onAppear {
            words = round.words ?? []
        }
    }
    
    private func deleteWord(at index: Int) {
        words.remove(at: index)
    }
    private func addWord() {
        words.append("")
    }


    
}



struct CustomNavEditRoundView: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("  Edit Round")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}
