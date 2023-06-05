//
//  AddRoundView2.swift
//  CoreTestSabbara
//
//  Created by Rand Alhassoun on 28/05/2023.
//

import SwiftUI


import SwiftUI

//let images = ["SabbaraChar1", "SabbaraChar2", "SabbaraChar3"]

struct AddRoundView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var selectedImage = "SabbaraChar2"//"SabbaraChar1"
    @State private var words = [String]()
    @State private var colors = "DGreen"
    @State private var colorsShadow = "DGreenShadow"
    
    //
    @State private var newWord = ""
    @State private var errorMessage = ""
    @State private var isEnteringImages = false
    @State private var isEnteringWords = true
    
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    //@Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView {
            VStack{
            if isEnteringWords {
                NameEntryView(name: $name, nextAction: {
                    isEnteringWords = false
                    isEnteringImages = true
                    
                    //                    submitAction()
                })
                //.navigationBarHidden(true)
            } else if isEnteringImages {
                ImageSelectionView(selectedImage: $selectedImage, selectedcolors: $colors, selectedcolorsShadow: $colorsShadow, nextAction: {
                    isEnteringImages = false
                    submitAction()
                    
                    //isEnteringWords = true
                },BackAction: {
                    isEnteringWords = true
                    
                    //                    isEnteringImages = false
                    //submitAction()
                    
                })
                //.navigationBarHidden(true)
            } else {
                WordEntryView(words: $words, newWord: $newWord, errorMessage: $errorMessage, submitAction: submitAction)
                
                //.navigationBarHidden(true)
            }
            
           // CustomNavAddRoundView(title: "EditxxxRound")
            
            
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
                
                    //.navigationBarBackButtonHidden(true)
                    //.navigationBarItems(leading: CustomNavEditRoundView())
                    

                
                
                
            )
//
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: CustomNavAddRoundView())

            .navigationBarBackButtonHidden(true)
            //.navigationBarItems(leading: CustomNavigationTitle())

            .toolbar {
                ToolbarItem(placement: .principal) {
                           // Center navigation bar item
                    CustomNavAddRoundView()
                       }
            }
            
    }


    }
    
    private func submitAction() {
        if words.count >= 20 { // Check if minimum word count is met
            DataController().addRound(
                name: name,
                images: selectedImage,
                words: words,//colorsShadow
                colors: colors,
                colorsShadow: colorsShadow,
                context: managedObjContext)
            dismiss()
            
        } else {
            errorMessage = NSLocalizedString("Minimum word count not met. Please enter at least 20 words.", comment: "")

        }
    }
}

struct ImageSelectionView: View {
    @Binding var selectedImage: String
    @Binding var selectedcolors: String
    @Binding var selectedcolorsShadow: String
    

    var nextAction: () -> Void
    var BackAction: () -> Void

//    var BackAction: () -> Void
//
//    var nextAction: () -> Void
    @State private var selectedColor: Color = Color("DGreen")
    @State private var selectedShadow: Color = Color("DGreenShadow")
    @State private var selectedSabbara: Image = Image("SabbaraChar2")
    //@State private var selectedImage: String = "SabbaraChar2"//Image("SabbaraChar2")
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            //MARK: -
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
                
                
                Spacer()
                VStack(alignment: .leading){
                    Text("Choose your color")
                        .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                        .foregroundColor(.black)

                        //.font(.title2)
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
                Spacer()
                VStack(alignment: .leading){
                    Text("Choose your Sabbara")
                        .font(.custom("TufuliArabicDEMO-Medium", size: 24))
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
            //MARK: -
            
            HStack{
               
                Button("Next") {
                    nextAction()
                }
                
                .buttonStyle(SmallButton3D()).modifier(SmallButtonTextModifier())
                
                Button("Back") {
                    BackAction()
                    //nextAction()
                }
                .foregroundColor(Color("Lpink"))
                .buttonStyle(WhSmallButton3D()).modifier(BigAndMediumButtonTextModifier())

            }
            
        }
        .padding()
    }
}

struct NameEntryView: View {
    @Binding var name: String
    var nextAction: () -> Void
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    @Environment(\.presentationMode) var presentationMode


    
    var body: some View {
        
        VStack(/*alignment: .leading*/){



            //Spacer()
            VStack(alignment: .leading){
                Text("Round Name")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.black)


                //.padding()
                ZStack {
                    
                    let offset: CGFloat = 10
                    RoundedRectangle (cornerRadius: 10)
                        .frame(width: 350 , height: 58)
                        . foregroundColor (Color("LYellowShadow"))
                        .offset (x: Offset,y: offset)
                    RoundedRectangle (cornerRadius: 10)
                        .frame(width: 350 , height: 58)
                        .foregroundColor (Color("LYellow"))
                    
                    TextField("Round Name", text: $name)
                        .frame(width: 340 , height: 58)
                        .padding()
                        .onChange(of: name) { newValue in
                            // Trim the input to remove leading/trailing white spaces
                            _ = newValue.trimmingCharacters(in: .whitespaces)

                            // Check the character count and update the text accordingly
                            if name.count > 11 {
                                name = String(name.prefix(11))
                            }
                        }

                    
                }
            }
            Text("Maximum 10 letters")
                .font(.custom("TufuliArabicDEMO-Medium", size: 18))

            Spacer()
            Spacer()
            HStack{

                Button("Next") {
                    nextAction()
                  if name.count < 1 {
                        name = NSLocalizedString("Your game", comment: "")
                        print(name.count)
                    }
                    
                }
                .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())

            }

        }.padding()
            .padding()
    }
}

struct WordEntryView: View {
    @Binding var words: [String]
    @Binding var newWord: String
    @Binding var errorMessage: String
    var submitAction: () -> Void
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            
//            HStack(){
//                Spacer()
//
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//
//                Image("xmark")
//                    .resizable()
//                    .frame(width: 23, height: 24)
//                    .foregroundColor(.white)
//                    .padding()
//            }.background(
//                Circle()
//                    .fill(Color("Lpink"))
//                    .frame(width: 42.16, height: 41)
//
//            )
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: EmptyView())
//        }

            VStack(alignment: .leading){
                
                
                Text("Words")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.black)

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
                            TextField("Word", text: $newWord)
                            //.textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            
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
                                //.padding()
                            }
                            
                        }.frame(width: 350)
                        
                    } .frame(height: 350)
                    
                }//z
            }//v
            Spacer()

            
            Button(action: {
                                    addWord()
            
            }) {
                HStack{
                    Image("Plus")
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text("Add Word")
                    
                 
                }
            }
            
                        .buttonStyle(AddWordButton3D())
                        .modifier(BigAndMediumButtonTextModifier())
//
//            Button("Add Word") {
//                //submitAction()
//                addWord()
//            }
//            .buttonStyle(AddWordButton3D())
//            .modifier(BigAndMediumButtonTextModifier())


            
            
            
            Text(errorMessage)
                .font(Font.custom("TufuliArabicDEMO-Medium", size: 18))
                //.font(.title3)
                .foregroundColor(.red)
                .padding()
            
            Button("Submit") {
                submitAction()
            }
            .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
            
        }
        .padding()
    }
    
    
    private func deleteWord(at index: Int) {
        words.remove(at: index)
    }
    
    
    private func addWord() {
        if !newWord.isEmpty {
            words.append(newWord)
            newWord = ""
        }
    }
}

struct AddRoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoundView()
    }
}



struct CustomNavAddRoundView: View {
    var body: some View {
        //Spacer()
//Text("  ")
        Text("  Create Round")
            .font(.custom("TufuliArabicDEMO-Medium", size: 26))
            .foregroundColor(Color.black)
        //Spacer()

    }
}
