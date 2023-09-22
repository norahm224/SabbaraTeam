//rrr
//  GameStart.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 23/05/2023.
//

//import SwiftUI
//
//struct GameStart: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct GameStart_Previews: PreviewProvider {
//    static var previews: some View {
//        GameStart()
//    }
//}

import SwiftUI
import CoreMotion
import AVFoundation
import UIKit


struct GameStart: View {
    
    //var category: Rounds
    var categoryWords: [String]

    @StateObject private var motionManager = MotionManager()
   // @State var fruits = ["apple", "banana", "orange", "grape", "mango", "strawberry", "pineapple", "watermelon", "kiwi", "pear"]
    
    @State private var showHoldInView = true
    @State private var showReadyView = false
    @State private var showFruitView = false
    @State private var showRightView = false
    @State private var showWrongView = false
    @State private var showWellDoneView = false
    @State private var readyCountdown = 3
    @State private var fruitCountdown = 60
    @State private var isCountdownPaused = false
    @State private var showTimeIsUpView = false
    @State private var currentFruit = ""
    @State private var guessedWords: [String: Bool] = [:]
    @State private var score = 0 // Add score variable
    @State private var isCheating = false
    @State private var showCheatView = false
    private let rightFeedbackGenerator = UINotificationFeedbackGenerator()
    private let wrongFeedbackGenerator = UINotificationFeedbackGenerator()
    private let warningFeedbackGenerator = UINotificationFeedbackGenerator()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            
            VStack {
                if showHoldInView {
                    HoldInPositionView()
                } else if showReadyView {
                    //ReadyView(countdown1: readyCountdown)
                    ReadyView()
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                readyCountdown -= 1
                                if readyCountdown == 0 {
                                    timer.invalidate()
                                    showReadyView = false
                                    showFruitView = true
                                    getNextFruit()
                                    startFruitTimer()
                                }
                                
                            }
                        }
                    //                        .onAppear {
                    //                            //if showFruitView {
                    //                                startFruitTimer()
                    //
                    //                        }
                    // startFruitTimer()
                    
                } else if showFruitView && !showCheatView { // Only display FruitView if showCheatView is false
                    FruitView(fruit: $currentFruit, countdown2: $fruitCountdown, showRightView: $showRightView, showWrongView: $showWrongView, isCountdownPaused: $isCountdownPaused, onNextFruit: getNextFruit)
                        .onAppear {
                            UIApplication.shared.isIdleTimerDisabled = true // Disable idle timer (This is to prevent the phone from locking the screen while the fruits are displayed)
                            if showRightView || showWrongView {
                                isCountdownPaused = false
                                getNextFruit() // Move this line after setting isCountdownPaused to false
                            }
                        }
                        .onChange(of: self.fruitCountdown) { newValue in
                            if newValue <= 3 {
                                showRightView = false
                                showWrongView = false
                            }
                        }
                        .onChange(of: self.fruitCountdown) { newValue in
                            if newValue <= 3 {
                                showRightView = false
                                showWrongView = false
                            }
                        }
                } else if showCheatView { // Display CheatView when player is cheating
                    CheatView()
                } else if showRightView {
                    RightView()
                        .onAppear {
                            getNextFruit()
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                showRightView = false
                                showFruitView = true
                                startFruitTimer()
                            }
                            score += 1 // Increment score on correct guess
                        }
                } else if showWrongView {
                    WrongView()
                        .onAppear {
                            getNextFruit()
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                showWrongView = false
                                showFruitView = true
                                
                                startFruitTimer()
                            }
                        }
                } else if showTimeIsUpView {
                    TimeIsUpView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showTimeIsUpView = false
                                showWellDoneView = true
                                printResults()
                            }
                        }
                } else if showWellDoneView {
                    FirstCodeView(resetGame: resetGame , guessedWords: guessedWords, score: score)
                    //(resetGame: resetGame, score: score) // Pass score to WellDoneView
                }
            }
            //.rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            //        .frame(maxWidth: .infinity, maxHeight: .infinity)
            //        .background(Color.yellow)
            //        .edgesIgnoringSafeArea(.all)
            .onChange(of: motionManager.isPhoneInPosition) { newValue in
                if newValue && showHoldInView {
                    showHoldInView = false
                    showReadyView = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                resetGame()
            }
            //        .onAppear {
            //            //if showFruitView {
            //                startFruitTimer()
            //
            //        }
            //}
            
            ///////////
            ///
            
            .navigationBarItems(
               // trailing:
                leading:
                    
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
            
           // .navigationBarBackButtonHidden(true)
           // .navigationBarItems(leading: CustomNavEditRoundView())
            
        }//nav
    }
    
    private func getNextFruit() {
        var shuffledFruits = categoryWords//category.words
        shuffledFruits.shuffle()
        currentFruit = shuffledFruits.first ?? ""
    }
    
    private func startFruitTimer() {
        var timer: Timer?

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            self.fruitCountdown -= 1

            if self.fruitCountdown == 0 {
                timer?.invalidate()
                if !(showRightView || showWrongView) {
                    guessedWords[currentFruit] = false
                }
                self.showFruitView = false
                self.showCheatView = false // Reset showCheatView
                self.showTimeIsUpView = true
                SoundPlayeromnya.shared.playSound(named: "Times-up")
                warningFeedbackGenerator.notificationOccurred(.warning) // Trigger warning vibration
            } else {
                if self.motionManager.isTiltedRight {
                    timer?.invalidate()
                    guessedWords[currentFruit] = true
                    self.showFruitView = false
                    self.showRightView = true
                    rightFeedbackGenerator.notificationOccurred(.success) // Trigger right vibration
                    SoundPlayeromnya.shared.playSound(named: "SabbaraRight")
                    
                    
                    // Trigger right sound
                } else if self.motionManager.isTiltedLeft {
                    timer?.invalidate()
                    guessedWords[currentFruit] = false
                    self.showFruitView = false
                    self.showWrongView = true
                    wrongFeedbackGenerator.notificationOccurred(.error) // Trigger wrong vibration
                    SoundPlayeromnya.shared.playSound(named: "SabbaraWrong")
// Trigger right sound
                } else if self.motionManager.isCheating {
                    if !self.showCheatView {
                        SoundPlayeromnya.shared.playSound(named: "SabbaraCheating")
                        self.showCheatView = true
                        self.showFruitView = false
                    }
                    self.showRightView = false
                    self.showWrongView = false
                    self.isCountdownPaused = true
                } else {
                    self.showCheatView = false // Reset showCheatView if not cheating
                    self.showFruitView = true
                    self.isCountdownPaused = false
                }
            }
        }
    }

    
    private func printResults() {
        for (word, isCorrect) in guessedWords {
            let correctness = isCorrect ? "Correct" : "Incorrect"
            print("Word: \(word), Guess: \(correctness)")
        }
    }
    
     private func resetGame() {
        showHoldInView = true
        showReadyView = false
        showFruitView = false
        showRightView = false
        showWrongView = false
        showWellDoneView = false
        readyCountdown = 3
        fruitCountdown = 60
        guessedWords.removeAll()
        score = 0 // Reset score
        rightFeedbackGenerator.prepare() // Reset right feedback generator
        wrongFeedbackGenerator.prepare() // Reset wrong feedback generator
        warningFeedbackGenerator.prepare() // Reset time is up feedback generator
    }
    
    
    struct HoldInPositionView: View {
        @State private var isAnimating = false
        @State private var size = 0.8
        @State var rotationAngle: Angle = .degrees(0)
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        var body: some View {
            
            VStack {
                   VStack {
//
                       VStack {
                           Text(NSLocalizedString("Hold_Phone_Instructions", comment: ""))
                               .font(.custom("TufuliArabicDEMO-Medium", size: 40))
                               .foregroundColor(Color.black)
                               .multilineTextAlignment(.center)
                               .lineLimit(nil)
//                               .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                               .frame(width: UIScreen.main.bounds.height - 16)
                               .padding()
                       }
                       .padding(.leading, layoutDirection == .rightToLeft ? 100.0 : 0)
                       .padding(.trailing, layoutDirection == .rightToLeft ? 100.0 : 0)

                       VStack {
                           Image("rightWrong")
                               .resizable()
                               .frame(width: 240, height: 120)
                               .cornerRadius(1)
                               .rotationEffect(rotationAngle)
//                               .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                               .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
                               .onAppear {
                                   withAnimation(.linear(duration: 0.50).repeatForever(autoreverses: true)) {
                                       rotationAngle = Angle(degrees: 10)
                                   }
                               }
                               .padding(.trailing, layoutDirection == .rightToLeft ? 200.0 : 0)
                               .padding(.leading, layoutDirection == .rightToLeft ? 200.0 : 0)

                       }
                   }
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .background(Color("LYellow"))
                   .edgesIgnoringSafeArea(.all)
                   .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))

               }
        }
    }
    
    struct ReadyView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        @State private var readyCountdown = 3
        var body: some View {
            ZStack{
                    VStack{
                        Text(NSLocalizedString("Be_Ready", comment: ""))
                            .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.height - 16)
                            .padding()
                            .frame(width: UIScreen.main.bounds.height - 16)
                        Text("\(readyCountdown)")
                            .font(.system(size: 70, weight: .bold))
                            .foregroundColor(Color.black)
                            .padding()
                            .animation(.easeInOut(duration: 1))
                            .onAppear {
                                startCountdown()
                            }
                            
                    }
                }
            
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LYellow"))
            .edgesIgnoringSafeArea(.all)
        }
        private func startCountdown() {
            withAnimation {
                if readyCountdown > 0 {
                    SoundPlayeromnya.shared.playSound(named: "Countdown-start") // Play the sound
                    readyCountdown -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startCountdown()
                    }
                }
            }
        }
    }
    struct FruitView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        @Binding var fruit: String
        @Binding var countdown2: Int
        @Binding var showRightView: Bool
        @Binding var showWrongView: Bool
        @Binding var isCountdownPaused: Bool
        let onNextFruit: () -> Void
        
        var body: some View {
            VStack {
                Text(fruit)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.height - 16)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding()
                ZStack {
                    Circle()
                        .trim(from: 0, to: CGFloat(countdown2) / 60)
                        .stroke(Color("Lpink"), style: StrokeStyle(lineWidth: 15 , lineCap: .round))
                        .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
                        .animation(.linear(duration: 1))
                    
                    Text("\(countdown2)")
                        .font(.system(size: 40, weight: .bold))
                        .padding()
                        .transition(.opacity)
                        .foregroundColor(Color.black)
                        .animation(.easeInOut(duration: 0.5))
                }
                .frame(width: 100, height: 100) // Adjust the frame to make the circle smaller
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LYellow"))
            .edgesIgnoringSafeArea(.all)
            .onChange(of: self.countdown2) { newValue in
                if newValue <= 3 {
                    showRightView = false
                    showWrongView = false
                }
            }
            .onDisappear {
                isCountdownPaused = true
            }
            .onAppear {
                if showRightView || showWrongView {
                    onNextFruit()
                    isCountdownPaused = false
                }
            }
        }
    }
    
    
    
    
    
    struct RightView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        var body: some View {
            ZStack{
                VStack{
                    Text(NSLocalizedString("Right", comment: ""))
                        .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                        .frame(width: UIScreen.main.bounds.height - 16)
                        .padding()
                    //.background(Color.green)
                        .foregroundColor(.white)
                    //.cornerRadius(10)
                    Image("right").resizable()
                        .frame(width: 170, height: 150)
                }
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DGreen"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    
    struct WrongView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        var body: some View {
            ZStack{
                VStack{
                    Text(NSLocalizedString("Pass", comment: ""))
                        .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                        .frame(width: UIScreen.main.bounds.height - 16)
                        .padding()
                    //.background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Image("wrong").resizable()
                        .frame(width: 130, height: 150)
                }
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DPurple"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct TimeIsUpView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        var body: some View {
            ZStack{
                VStack{
                    Text(NSLocalizedString("Time_Is_Up", comment: ""))
                        .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                        .frame(width: UIScreen.main.bounds.height - 16)
                        .padding()
                    //.background(Color.green)
                        .foregroundColor(.white)
                    //.cornerRadius(10)
                    Image("time").resizable()
                        .frame(width: 150, height: 150)
                }
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("RedWarnning"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct CheatView: View {
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        var body: some View {
            ZStack {
                Text(NSLocalizedString("Do_NOT_CHEAT", comment: ""))
                    .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                    .foregroundColor(Color("RedWarnning"))
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
                    .frame(width: 800, height: 300)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("LYellow"))
                .edgesIgnoringSafeArea(.all)
            
        }

    }
//    struct PassToTeamTwoView: View {
//        @Environment(\.layoutDirection) private var layoutDirection
//            private var isRTL: Bool {
//                layoutDirection == .rightToLeft
//            }
//        var body: some View {
//            ZStack{
//                VStack{
//                    HStack{
//                        Text(NSLocalizedString("Pass_To", comment: "")) .foregroundColor(.white)
//                        Text(NSLocalizedString("Team2", comment: "")).foregroundColor(Color("Lpink"))
//                    }
//                    .font(.custom("TufuliArabicDEMO-Medium", size: 40))
//                    .frame(width: UIScreen.main.bounds.height - 16)
//                    .padding()
//
//                    Button(action: {}) {
//                        Text(NSLocalizedString("Start_Team2_Round", comment: ""))
//                    }
//                    .buttonStyle(BigButton3D())
//                    .modifier(BigAndMediumButtonTextModifier())
//                }
//            }
//            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color("LYellow"))
//            .edgesIgnoringSafeArea(.all)
//        }}
    
//    struct WellDoneView: View {
//        var resetGame: () -> Void
//            var score: Int // Add score variable
//        var body: some View {
//            VStack {
//                Text("Well Done!")
//                    .font(.title)
//                    .padding()
//                Text("Score: \(score)") // Display the score
//                Button(action: {
//                    resetGame()
//                }, label: {
//                    Text("Start Again")
//                        .font(.title)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                })
//
//            }
//        }
//    }
  
    
    
    //---------------------------------------------------------------------------------------

    //MARK: THIS IS THE PAGE OF RESULT
       
       struct FirstCodeView: View {
           var resetGame: () -> Void
           @State private var navigateToGameS = false
           @State private var navigateToMainPage = false
           let dictionary: [String: Bool] = [:]
           var guessedWords: [String: Bool]
           var score: Int
           
           var body: some View {
               NavigationView {
                   VStack {
                       let offset: CGFloat = 10
                       let Offset: CGFloat = 5
                       
                       ZStack {
                           Image("ResultboardFill")
                               .resizable()
                               .frame(width: 386, height: 64)
                           
                           HStack {
                               Text(NSLocalizedString("YourPoint:", comment: ""))
                               Text("\(score)")
                           }
                           .foregroundColor(.black)
                           //.bold()
                           .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                       }
                       
                       ZStack {
                           Rectangle()
                               .frame(width: 344, height: 415)
                               .foregroundColor(Color("LYellowShadow"))
                               .cornerRadius(10)
                               .offset(x: Offset, y: offset)
                           
                           Rectangle()
                               .frame(width: 344, height: 415)
                               .foregroundColor(Color("LYellow"))
                               .cornerRadius(10)
                               .padding(.bottom)
                           
                           ScrollView {
                               VStack(alignment: .center, spacing: 5) {
                                   ForEach(guessedWords.keys.sorted(), id: \.self) { key in
                                       let isCorrect = guessedWords[key] ?? false
                                       
                                       Text(key)
                                           .foregroundColor(isCorrect ? .green : .red)
                                           .padding()
                                   }
                               }
                               .frame(width: 340)
                           }
                           .frame(height: 380)
                       }
   //                    .padding()
                       
                       VStack{
                           Button(action: {
                               resetGame()
                               navigateToGameS = true
                           }, label: {
                               Text("Replay Round")
                               Image(systemName: "arrow.counterclockwise")
                                   .foregroundColor(.white)
                                   .padding(.leading, 200)
                           })
                           .buttonStyle(BigButton3D())
                           .modifier(BigAndMediumButtonTextModifier())
                           //.padding()
                           .padding(14)
                           //Spacer()
                           
                           Button {
                               navigateToMainPage = true
                           } label: {
                               Text("End Round")
                               
                           }
                           .foregroundColor(Color("Lpink"))
                           .buttonStyle(WhBigButton3D())
                           .modifier(BigAndMediumButtonTextModifier())
                           // .padding()
                       }.padding()
                       //Spacer()
                   }.padding()
                   
                   .navigationBarBackButtonHidden(true)
                   .toolbar {
                       ToolbarItem(placement: .principal) {
                           RCustomNavigationTitle()
                       }
                   }
               }
               .fullScreenCover(isPresented: $navigateToMainPage) {
                   MainPage()
               }
           }
       }

       
       
       struct RCustomNavigationTitle: View {
           var body: some View {
               VStack {
                   
                   Text(NSLocalizedString("Results", comment: ""))
                       .font(.custom("TufuliArabicDEMO-Medium", size: 28))
                       .foregroundColor(.black)
               }
           }
       }
}
//    struct GameStart_Previews: PreviewProvider {
//        static var previews: some View {
//            //GameStart()
//            GameStart(category: Rounds)
//        }
//    }
    

