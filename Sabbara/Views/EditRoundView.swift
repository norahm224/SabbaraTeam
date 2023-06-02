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
    
    @State private var name = ""
    @State private var images = ""//"SabbaraChar1"
    @State private var colors = ""//"DGreen"
    @State private var colorsShadow = ""//"DGreenShadow"
    //colorsShadow
    @State private var words: [String] = []
    
    @State private var offset: CGFloat = 10
    @State private var Offset: CGFloat = 5
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                Text("Name")
                    .font(.title3)
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
                            name = round.name!
                            words = round.words ?? []
                            images = round.images!
                            colors = round.colors!
                            colorsShadow = round.colorsShadow!
                        }
                    
                }
            }//v
            .padding()
            //
            VStack(alignment: .leading){
                
                Text("words")
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
                    
                    
                    
                    //Section(header: Text("Words").font(.title3)){
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
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            deleteWord(at: index)
                                        }
                                    Spacer()
                                    
                                    
                                }//H
                            }//foreach
                            
                        }//v
                        .frame(width: 350)
                        
                    }                .frame(height: 350)
                    
                }//v
                
            }//v
            .padding()
            
            ZStack {
                
                
                
                RoundedRectangle (cornerRadius: 10)
                    .frame(width: 350 , height: 58)
                    . foregroundColor (Color("LYellowShadow"))
                    .offset (x: Offset,y: offset)
                RoundedRectangle (cornerRadius: 10)
                    .frame(width: 350 , height: 58)
                    .foregroundColor (Color("LYellow"))
                
                Button(action: addWord) {
                    Label("Add Word", systemImage: "plus.circle")
                }
                
            }
            
            
            Button("Submit") {
                DataController().editRound(Round: round, name: name, images: images, words: words, colors: colors, colorsShadow: colorsShadow, context: managedObjContext)
                dismiss()
            }
            .buttonStyle(BigButton3D()).modifier(BigAndMediumButtonTextModifier())
            
        }//v
    }
    
    private func addWord() {
        words.append("")
    }
    
    private func deleteWord(at index: Int) {
        words.remove(at: index)
    }
}

