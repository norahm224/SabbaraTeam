//
//  Results.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 24/05/2023.
//
//
//import SwiftUI
////import FirebaseAnalytics
////import Firebase
//
//
//struct Results: View {
//    
//    // MARK: - for now it a button to show different view
//    @State private var showFirstCode = false
//    @State private var showSecondCode = false
//    
//    var body: some View {
//        VStack {
//            if !showFirstCode && !showSecondCode {
//                Button("Show First Code") {
//                    showFirstCode = true
//                    showSecondCode = false
//                }
//                .padding()
//                
//                Button("Show Second Code") {
//                    showFirstCode = false
//                    showSecondCode = true
//                }
//                .padding()
//            }
//            
//            if showFirstCode {
//                FirstCodeView()
//            } else if showSecondCode {
//                SecondCodeView()
//            }
//        }
//    }
//}
//
//// Second code struct implementation

//struct FirstCodeView: View {
//    @State private var navigateToGameS = false
//    @State private var navigateToMainPage = false
//    let dictionary: [String: Bool] = [:]
//    var body: some View {
//        // First code struct implementation (quick game)
//        VStack{ //open vstack
//            let offset: CGFloat = 10
//            let Offset : CGFloat = 5
//
//           // Text(NSLocalizedString("Results", comment: ""))
//
////                .foregroundColor(Color.black)
////                .modifier(BigAndMediumButtonTextModifier())
//
//            ZStack{// open zstack
//                Image("ResultboardFill")
//                    .resizable()
//                    .frame(width: 386,height: 64)
//                Text(NSLocalizedString("Point", comment: ""))
//
//                    .foregroundColor(.black)
//                    .bold()
//                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//            }// end zstack
//
//
//            ZStack{ // open zstack
//
//                Rectangle()
//                    .frame(width:344,height: 423)
//                    .foregroundColor(Color("LYellowShadow"))
//                    .cornerRadius(10)
//                    .offset (x: Offset ,y: offset)
//
//
//                Rectangle()
//                    .frame(width:344,height: 423)
//                    .foregroundColor(Color("LYellow"))
//                    .cornerRadius(10)
//
//
//                ScrollView {
//
//                    ForEach(dictionary.keys.sorted(), id: \.self) { key in
//                        let isCorrect = dictionary[key] ?? false
//
//                        Text(key)
//                            .foregroundColor(isCorrect ? .green : .red)
//                            .padding()
//                    }
//
//                    .frame(width: 340)
//                }
//                .frame( height: 380)
//            }// end zstackm
//
//            .padding()
//
//
//
//            Button {
//               // trackButtonEvent2(buttonName: "Replay Round")
//                navigateToGameS = true
//            } label: {
//
//                Text("Replay Round")
//                Image(systemName: "arrow.counterclockwise")
//                    .foregroundColor(.white).padding(.leading,200)
//
//            }.buttonStyle(BigButton3D())
//                .modifier(BigAndMediumButtonTextModifier())
//                .padding()
//
//
//
//
//            Button {
//              //  trackButtonEvent2(buttonName: "End Round")
//                navigateToMainPage = true
//            } label: {
//
//                Text("End Round")
//
//            } .foregroundColor(Color("Lpink"))
//                .buttonStyle(WhBigButton3D())
//                .modifier(BigAndMediumButtonTextModifier())
//                .padding()
//
//
//            Spacer()
//
//
//        }// end vstack
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: RCustomNavigationTitle())
//
//
//        .fullScreenCover(isPresented: $navigateToGameS) {
//            //GameStart(categoryWords: <#[String]#>)
//            // GameStart(categoryWords: <#T##[String]#>)
//
//
//        }
//
//        .fullScreenCover(isPresented: $navigateToMainPage) {
//            MainPage()
//        }
//
//    }
//}
//
//
//
//struct SecondCodeView: View {
//    @State private var navigateToGame = false
//    @State private var navigateTomain = false
//    @State var showingBottomSheet = false
//    @State private var guessedWordsTeam1: [String: Bool] = [:]
//    @State private var guessedWordsTeam2: [String: Bool] = [:]
//    let offset: CGFloat = 10
//
//    var body: some View {
//        VStack {
////            Text("Results")
////                .foregroundColor(Color.black)
////                .modifier(BigAndMediumButtonTextModifier())
//           // Spacer()
//
//            ZStack {
//                Image("ResultboardTeams")
//                Circle()
//                    .frame(width: 94, height: 94)
//                    .foregroundColor(Color.black)
//                    .padding(.bottom)
//            }
//
//            HStack {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 350, height: 54)
//                        .foregroundColor(Color("LYellowShadow"))
//                        .offset(y: offset)
//
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 350, height: 54)
//                        .foregroundColor(Color("LYellow"))
//
//                    HStack {
//                        ZStack {
//                            Circle()
//                                .frame(width: 32, height: 32)
//                                .foregroundColor(Color("DPurple"))
//                            Image("SabbaraChar1")
//                                .resizable()
//                                .frame(width: 22.96, height: 19)
//                        }
//                        Text("Team 1")
//                        Spacer().frame(width: 90)
//                        Text("\(guessedWordsTeam1.count)")
//                        Button {
//                            showingBottomSheet.toggle()
//                        } label: {
//                            Image("Group 202")
//                        }
//                        .sheet(isPresented: $showingBottomSheet) {
//                            SBottomSheet(team1Dictionary: guessedWordsTeam1, team2Dictionary: guessedWordsTeam2)
//                                .presentationDetents([.medium])
//                                .presentationDragIndicator(.visible)
//                        }
//                    }
//                }
//                .padding()
//            }
//
//            HStack {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 350, height: 54)
//                        .foregroundColor(Color("LYellowShadow"))
//                        .offset(y: offset)
//
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 350, height: 54)
//                        .foregroundColor(Color("LYellow"))
//
//                    HStack {
//                        ZStack {
//                            Circle()
//                                .frame(width: 32, height: 32)
//                                .foregroundColor(Color("DGreen"))
//                            Image("SabbaraChar3")
//                                .resizable()
//                                .frame(width: 22.96, height: 19)
//                        }
//                        Text("Team 2")
//                        Spacer()
//                            .frame(width: 90)
//
//                        Text("\(guessedWordsTeam1.count)")
//                        Button {
//                           // trackButtonEvent2(buttonName: "Dropdown Result")
//                            showingBottomSheet.toggle()
//                        } label: {
//                            Image("Group 202")
//                        }
//                        .sheet(isPresented: $showingBottomSheet) {
//                            SBottomSheet(team1Dictionary: guessedWordsTeam1, team2Dictionary: guessedWordsTeam2)
//                                .presentationDetents([.medium])
//                                .presentationDragIndicator(.visible)
//                        }
//                    }
//                }
//                .padding()
//            }
//
//            Spacer().padding()
//
//            Button {
//               // trackButtonEvent2(buttonName: "Replay Round")
//                navigateToGame = true
//            } label: {
//                Text("Replay Round")
//                Image(systemName: "arrow.counterclockwise")
//                    .foregroundColor(.white).padding(.leading, 200)
//            }
//            .buttonStyle(BigButton3D())
//            .modifier(BigAndMediumButtonTextModifier())
//            .padding()
//
//            Button {
//               // trackButtonEvent2(buttonName: "End Round")
//                navigateTomain = true
//            } label: {
//                Text("End Round")
//            }
//            .foregroundColor(Color("Lpink"))
//            .buttonStyle(WhBigButton3D())
//            .modifier(BigAndMediumButtonTextModifier())
//            .padding()
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: RCustomNavigationTitle())
//        .fullScreenCover(isPresented: $navigateToGame) {
//            GameStart(categoryWords: <#[String]#>)
//        }
//        .fullScreenCover(isPresented: $navigateTomain) {
//            MainPage()
//        }
//        .overlay(
//            TeamDictionaryView(team1Dictionary: guessedWordsTeam1, team2Dictionary: guessedWordsTeam2)
//        )
//    }
//}
//
//struct TeamDictionaryView: View {
//    let team1Dictionary: [String: Bool]
//    let team2Dictionary: [String: Bool]
//    //let wordDictionary: [String: Bool]
//    var body: some View {
//        VStack {
//            ForEach(Array(team1Dictionary.keys.sorted()), id: \.self) { key in
//                let team1IsCorrect = team1Dictionary[key] ?? false
//                let team2IsCorrect = team2Dictionary[key] ?? false
//
//                HStack {
//                    Text(key)
//                        .foregroundColor(team1IsCorrect ? .green : .red)
//                        .padding()
//
//                    Spacer()
//
//                    Text(key)
//                        .foregroundColor(team2IsCorrect ? .green : .red)
//                        .padding()
//                }
//            }
//        }
//
//
//
//    }
//}
//
//struct SBottomSheet: View {
//    @State private var offset: CGFloat = 10
//    @State private var Offset: CGFloat = 5
//    let team1Dictionary: [String: Bool]
//    let team2Dictionary: [String: Bool]
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Image("ResultboardNotFill")
//                    .resizable()
//                    .frame(width: 386, height: 64)
//                HStack {
//                    Text("point")
//                        .foregroundColor(Color("Lpink"))
//                        .modifier(BigAndMediumButtonTextModifier())
//                        .overlay(
//                            Text("\(team1Dictionary.count)")
//                                .foregroundColor(Color("Lpink"))
//                                .modifier(BigAndMediumButtonTextModifier())
//                                .padding(.leading, -58)
//                        )
//                }
//            }
//            .padding(.top, 40)
//
//            VStack {
//                ZStack {
//                    Rectangle()
//                        .frame(width: 330, height: 331)
//                        .foregroundColor(Color("LYellowShadow"))
//                        .cornerRadius(10)
//                        .offset(x: Offset, y: offset)
//
//                    Rectangle()
//                        .frame(width: 330, height: 331)
//                        .foregroundColor(Color("LYellow"))
//                        .cornerRadius(10)
//
//                    ScrollView {
//                        VStack {
//                            ForEach(Array(team1Dictionary.keys.sorted()), id: \.self) { key in
//                                let team1IsCorrect = team1Dictionary[key] ?? false
//                                let team2IsCorrect = team2Dictionary[key] ?? false
//
//                                HStack {
//                                    Text(key)
//                                        .foregroundColor(team1IsCorrect ? .green : .red)
//                                        .padding()
//
//                                    Spacer()
//
//                                    Text(key)
//                                        .foregroundColor(team2IsCorrect ? .green : .red)
//                                        .padding()
//                                }
//                            }
//                        }
//                        .frame(width: 320)
//                    }
//                    .frame(height: 300)
//                }
//            }
//        }
//    }
//}
//
//
//
//
//struct RCustomNavigationTitle: View {
//    var body: some View {
//        VStack {
//           // Spacer()
//            Text(NSLocalizedString("Results", comment: ""))
//                .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//            //Spacer()
//        }
//    }
//}
//
//
////func trackButtonEvent2(buttonName: String) {
////    Analytics.logEvent("button_click", parameters: [
////        "button_name": buttonName
////    ])
////}
//
//
//









