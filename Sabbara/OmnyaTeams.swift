


//
//  OmnyaTeams.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 08/06/2023.
//

import SwiftUI
import CoreMotion
import AVFoundation

enum TeamNumber22 {
    case firstTeam
    case secondTeam
}

//SoundPlayeromnya.shared.playSound(named: "Countdown-start")
struct OmnyaTeams: View {
    
    @StateObject private var motionManager = MotionManager()
    @State private var showHoldInViewTeams = true
    @State private var showReadyViewTeams = false
    @State private var showFruitViewTeams = false
    @State private var showRightViewTeams = false
    @State private var showWrongViewTeams = false
    @State private var showWellDoneViewTeams = false
    @State private var readyCountdownTeams = 3
    @State private var fruitCountdownTeams = 60
    @State private var isCountdownPausedTeams = false
    @State private var showTimeIsUpViewTeams = false
    @State private var currentFruitTeams = ""
    
    @State private var guessedWordsTeam1: [String: Bool] = [:]
    @State private var guessedWordsTeam2: [String: Bool] = [:]
    @State private var team1Gamescore = 0
    @State private var team2Gamescore = 0
    @State private var isTeam1TurnTeams = true
    @State private var isCheatingTeams = false
    @State private var showCheatViewTeams = false
    private let rightFeedbackGeneratorTeams = UINotificationFeedbackGenerator()
    private let wrongFeedbackGeneratorTeams = UINotificationFeedbackGenerator()
    private let warningFeedbackGeneratorTeams = UINotificationFeedbackGenerator()
    
    @State private var selectedTeam: TeamNumber22? = .firstTeam
    
    var categoryWords: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{

        VStack {
            if showHoldInViewTeams {
                HoldInPositionViewTeams(selectedTeam: isTeam1TurnTeams ? .firstTeam : .secondTeam)
            } else if showReadyViewTeams {
                ReadyViewTeams()
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            readyCountdownTeams -= 1
                            if readyCountdownTeams == 0 {
                                timer.invalidate()
                                showReadyViewTeams = false
                                showFruitViewTeams = true
                                getNextFruitTeams()
                                startFruitTimerTeams()
                            }
                        }
                    }
            } else if showFruitViewTeams && !showCheatViewTeams {
                FruitViewTeams(fruit: $currentFruitTeams, countdown2Teams: $fruitCountdownTeams, showRightViewTeams: $showRightViewTeams, showWrongViewTeams: $showWrongViewTeams, isCountdownPausedTeams: $isCountdownPausedTeams, onNextFruitTeams: getNextFruitTeams)
                    .onAppear {
                        UIApplication.shared.isIdleTimerDisabled = true // Disable idle timer (This is to prevent the phone from locking the screen while the fruits are displayed)
                        if showRightViewTeams || showWrongViewTeams {
                            isCountdownPausedTeams = false
                            getNextFruitTeams()
                        }
                    }
                    .onChange(of: self.fruitCountdownTeams) { newValue in
                        if newValue <= 3 {
                            showRightViewTeams = false
                            showWrongViewTeams = false
                        }
                    }
            } else if showCheatViewTeams {
                CheatViewTeams().onAppear{
                }
            } else if showRightViewTeams {
                RightViewTeams()
                    .onAppear {
                        getNextFruitTeams()
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            showRightViewTeams = false
                            showFruitViewTeams = true
                            startFruitTimerTeams()
                        }
                        if let selectedTeam = selectedTeam {
                            switch selectedTeam {
                            case .firstTeam:
                                team1Gamescore += 1
                            case .secondTeam:
                                team2Gamescore += 1
                            }
                        }
                        //score += 1 // Increment score on correct guess
                    }
            } else if showWrongViewTeams {
                WrongViewTeams()
                    .onAppear {
                        getNextFruitTeams()
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            showWrongViewTeams = false
                            showFruitViewTeams = true
                            startFruitTimerTeams()
                        }
                        if let selectedTeam = selectedTeam {
                            switch selectedTeam {
                            case .firstTeam:
                                team1Gamescore += 1
                            case .secondTeam:
                                team2Gamescore += 1
                            }
                        }
                        
                    }
                
            } else if showTimeIsUpViewTeams {
                TimeIsUpViewTeams()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showTimeIsUpViewTeams = false
                            showWellDoneViewTeams = true
                            printResultsTeams()
                        }
                    }
                
            } else if isTeam1TurnTeams {
                PassToTeamTwoViewTeams(isTeam1TurnTeams: $isTeam1TurnTeams, firstresetGameTeams: firstresetGameTeams)
                //                    .onAppear {
                //                        isTeam1TurnTeams = false
                //                    }
            } else if showWellDoneViewTeams {
                // WellDoneViewTeams(guessedWordsTeam1: guessedWordsTeam1, guessedWordsTeam2: guessedWordsTeam2, team1Gamescore: team1Gamescore, team2Gamescore: team2Gamescore, secondresetGameTeams: secondresetGameTeams)
                SecondCodeView(guessedWordsTeam1: guessedWordsTeam1, guessedWordsTeam2: guessedWordsTeam2, team1Gamescore: team1Gamescore, team2Gamescore: team2Gamescore, secondResetGameTeams: secondresetGameTeams)
            }
        }
        .onChange(of: motionManager.isPhoneInPosition) { newValue in
            if newValue && showHoldInViewTeams {
                showHoldInViewTeams = false
                showReadyViewTeams = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            firstresetGameTeams()
            //secondresetGameTeams()
        }
            
            
            
            
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
            

    }
    }
    
    //---------------------------------------------//
    
    private func getNextFruitTeams() {
        var shuffledFruits = categoryWords//category.words
        shuffledFruits.shuffle()
        currentFruitTeams = shuffledFruits.first ?? ""
    }
    private func secondresetGameTeams() {
        showHoldInViewTeams = true
        showReadyViewTeams = false
        showFruitViewTeams = false
        showRightViewTeams = false
        showWrongViewTeams = false
        showWellDoneViewTeams = false
        readyCountdownTeams = 3
        fruitCountdownTeams = 60
        //isCountdownPausedTeams = false
        // showTimeIsUpViewTeams = false
        currentFruitTeams = ""
        //guessedWords = [:]
        guessedWordsTeam1 = [:]
        guessedWordsTeam2 = [:]
        team1Gamescore = 0
        team2Gamescore = 0
        isTeam1TurnTeams = true
        isCheatingTeams = false
        showCheatViewTeams = false
        selectedTeam = .firstTeam
        
    }
    private func firstresetGameTeams() {
        showHoldInViewTeams = true
        showReadyViewTeams = false
        showFruitViewTeams = false
        showRightViewTeams = false
        showWrongViewTeams = false
        showWellDoneViewTeams = true
        readyCountdownTeams = 3
        fruitCountdownTeams = 60
        //isCountdownPausedTeams = false
        // showTimeIsUpViewTeams = false
        currentFruitTeams = ""
        //guessedWords = [:]
        //guessedWordsTeam1 = [:]
        //guessedWordsTeam2 = [:]
        //team1Gamescore = 0
        //team2Gamescore = 0
        //isTeam1TurnTeams = false
        //score = 0
        isCheatingTeams = false
        showCheatViewTeams = false
        selectedTeam = .secondTeam
    }
    
    private func printResultsTeams() {
        print("Guessed Words (Team 1): \(guessedWordsTeam1)")
        print("Guessed Words (Team 2): \(guessedWordsTeam2)")
        print("Team 1 Gamescore: \(team1Gamescore)")
        print("Team 2 Gamescore: \(team2Gamescore)")
    }
    
    
    
    struct HoldInPositionViewTeams: View {
        var selectedTeam: TeamNumber22
        @State private var isAnimating = false
        @State private var size = 0.8
        @State var rotationAngle: Angle = .degrees(0)
        @Environment(\.layoutDirection) private var layoutDirection
            private var isRTL: Bool {
                layoutDirection == .rightToLeft
            }
        
        
        var body: some View {
            switch selectedTeam {
            case .firstTeam:
                
                VStack {
                       VStack {
                           ZStack {
                               RoundedRectangle(cornerRadius: 60)
                                   .frame(width: 220, height: 60)
                                   .foregroundColor(Color("Lpink"))
                               HStack(spacing: 20) {
                                   Text(NSLocalizedString("Team1", comment: ""))
                                       .font(.custom("TufuliArabicDEMO-Medium", size: 28))
                                   ZStack {
                                       Image("SabbaraChar1")
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                           .background(
                                               Circle()
                                                   .fill(Color("DGreen"))
                                                   .frame(width: 45, height: 45)
                                           )
                                   }//ZStack
                               }//HStack
                           }//ZStack
    //                       .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                           .padding(.leading, layoutDirection == .rightToLeft ? 100.0 : 0)
                           .padding(.trailing, layoutDirection == .rightToLeft ? 100.0 : 0)

                           
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
                

            case .secondTeam:
                
                VStack {
                       VStack {
                           ZStack {
                               RoundedRectangle(cornerRadius: 60)
                                   .frame(width: 220, height: 60)
                                   .foregroundColor(Color("Lpink"))
                               HStack(spacing: 20) {
                                   //Text(NSLocalizedString("Team1", comment: ""))
                                                          
                                   Text(NSLocalizedString("Team2", comment: ""))

                                       .font(.custom("TufuliArabicDEMO-Medium", size: 28))
                                   ZStack {
                                       Image("SabbaraChar3")
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                           .background(
                                               Circle()
                                                   .fill(Color("DPurple"))
                                                   .frame(width: 45, height: 45)
                                           )
                                   }//ZStack
                               }//HStack
                           }//ZStack
    //                       .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                           .padding(.leading, layoutDirection == .rightToLeft ? 100.0 : 0)
                           .padding(.trailing, layoutDirection == .rightToLeft ? 100.0 : 0)

                           
                           VStack {
                               Text(NSLocalizedString("Hold_Phone_Instructions", comment: ""))
                                   .foregroundColor(Color.black)
                                   .font(.custom("TufuliArabicDEMO-Medium", size: 40))
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
    }

    
    struct ReadyViewTeams: View {
        @Environment(\.layoutDirection) private var layoutDirection
        private var isRTL: Bool {
            layoutDirection == .rightToLeft
        }
        @State private var readyCountdownTeams = 3
        var body: some View {
            ZStack{
                VStack{
                    Text(NSLocalizedString("Be_Ready", comment: ""))
                        .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.height - 16)
                        .padding()
                        .frame(width: UIScreen.main.bounds.height - 16)
                    Text("\(readyCountdownTeams)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.black)
                        .padding()
                        .animation(.easeInOut(duration: 1))
                        .onAppear {
                            startCountdownTeams()
                        }
                    
                }
            }
            
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LYellow"))
            .edgesIgnoringSafeArea(.all)
        }
        private func startCountdownTeams() {
            withAnimation {
                if readyCountdownTeams > 0 {
                    SoundPlayeromnya.shared.playSound(named: "Countdown-start") // Play the sound
                    readyCountdownTeams -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startCountdownTeams()
                    }
                }
            }
        }
    }
    
    private func startFruitTimerTeams() {
        var isCheatingSoundPlaying = false
        
        var timer: Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            self.fruitCountdownTeams -= 1
            
            if self.fruitCountdownTeams == 0 {
                timer?.invalidate()
                if !(showRightViewTeams || showWrongViewTeams) {
                    // guessedWords[currentFruit] = false
                    //  if selectedPlayModeTeams == .playWithTeam {
                    
                    if selectedTeam == .firstTeam {
                        guessedWordsTeam1[currentFruitTeams] = false
                    } else if selectedTeam == .secondTeam {
                        guessedWordsTeam2[currentFruitTeams] = false
                    }
                    //  }
                }
                self.showFruitViewTeams = false
                self.showTimeIsUpViewTeams = true
                //self.isTeam1TurnTeams = true
                self.showCheatViewTeams = false
                warningFeedbackGeneratorTeams.notificationOccurred(.warning) // Trigger warning vibration
                SoundPlayeromnya.shared.playSound(named: "Times-up")
            } else {
                if self.motionManager.isTiltedRight {
                    timer?.invalidate()
                    //guessedWords[currentFruit] = true
                    // if selectedPlayMode == .playWithTeam {
                    if selectedTeam == .firstTeam {
                        guessedWordsTeam1[currentFruitTeams] = true
                    } else if selectedTeam == .secondTeam {
                        guessedWordsTeam2[currentFruitTeams] = true
                    }
                    // }
                    self.showFruitViewTeams = false
                    self.showRightViewTeams = true
                    rightFeedbackGeneratorTeams.notificationOccurred(.success) // Trigger right vibration
                    SoundPlayeromnya.shared.playSound(named: "SabbaraRight") // Trigger right sound
                }
                else if self.motionManager.isTiltedLeft {
                    timer?.invalidate()
                    //guessedWords[currentFruitTeams] = false
                    //if selectedPlayMode == .playWithTeam {
                    if selectedTeam == .firstTeam {
                        guessedWordsTeam1[currentFruitTeams] = false
                    } else if selectedTeam == .secondTeam {
                        guessedWordsTeam2[currentFruitTeams] = false
                    }
                    //}
                    self.showFruitViewTeams = false
                    self.showWrongViewTeams = true
                    wrongFeedbackGeneratorTeams.notificationOccurred(.error) // Trigger wrong vibration
                    SoundPlayeromnya.shared.playSound(named: "SabbaraWrong") // Trigger right sound
                }
                else if self.motionManager.isCheating {
                    
                    if !self.showCheatViewTeams {
                        self.showCheatViewTeams = true
                        self.showFruitViewTeams = false
                        SoundPlayeromnya.shared.playSound(named: "SabbaraCheating")
                    }
                    
                    self.showRightViewTeams = false
                    self.showWrongViewTeams = false
                    self.isCountdownPausedTeams = true
                } else
                {
                    self.showCheatViewTeams = false // Reset showCheatView if not cheating
                    self.showFruitViewTeams = true
                    self.isCountdownPausedTeams = false
                    //getNextFruit()
                }
            }
        }
    }
    
    struct FruitViewTeams: View {
        @Environment(\.layoutDirection) private var layoutDirection
        private var isRTL: Bool {
            layoutDirection == .rightToLeft
        }
        @Binding var fruit: String
        @Binding var countdown2Teams: Int
        @Binding var showRightViewTeams: Bool
        @Binding var showWrongViewTeams: Bool
        @Binding var isCountdownPausedTeams: Bool
        let onNextFruitTeams: () -> Void
        
        var body: some View {
            VStack {
                Text(fruit)
                    .font(.custom("TufuliArabicDEMO-Medium", size: 70))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.height - 16)
                    .padding()
                ZStack {
                    Circle()
                        .trim(from: 0, to: CGFloat(countdown2Teams) / 60)
                        .stroke(Color("Lpink"), style: StrokeStyle(lineWidth: 15 , lineCap: .round))
                        .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
                        .animation(.linear(duration: 1))
                    
                    Text("\(countdown2Teams)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.black)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5))
                }
                .frame(width: 100, height: 100) // Adjust the frame to make the circle smaller
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LYellow"))
            .edgesIgnoringSafeArea(.all)
            .onChange(of: self.countdown2Teams) { newValue in
                if newValue <= 3 {
                    showRightViewTeams = false
                    showWrongViewTeams = false
                }
            }
            .onDisappear {
                isCountdownPausedTeams = true
            }
            .onAppear {
                if showRightViewTeams || showWrongViewTeams {
                    onNextFruitTeams()
                    isCountdownPausedTeams = false
                }
            }
        }
    }
    
    struct RightViewTeams: View {
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
    
    struct WrongViewTeams: View {
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
                    Image("time").resizable()
                        .frame(width: 130, height: 150)
                }
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DPurple"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    struct PassToTeamTwoViewTeams: View {
        @Environment(\.layoutDirection) private var layoutDirection
        private var isRTL: Bool {
            layoutDirection == .rightToLeft
        }
        @Binding var isTeam1TurnTeams: Bool
        let firstresetGameTeams: () -> Void
        var body: some View {
            ZStack {
                VStack {
                    HStack {
                        Text(NSLocalizedString("Pass_To", comment: ""))
                            .foregroundColor(Color.black)
                        Text(NSLocalizedString("To_Team2", comment: ""))
                            .foregroundColor(Color("Lpink"))
                    }
                    .font(.custom("TufuliArabicDEMO-Medium", size: 40))
                    .frame(width: UIScreen.main.bounds.height - 16)
                    .padding()
                    
                    Button(action: {
                        firstresetGameTeams()
                        isTeam1TurnTeams = false
                    }) {
                        Text(NSLocalizedString("Start_Team2_Round", comment: ""))
                    }
                    .buttonStyle(BigButton3D())
                    .modifier(BigAndMediumButtonTextModifier())
                }
            }
            .rotationEffect(Angle(degrees: isRTL ? 90 : -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LYellow"))
            .edgesIgnoringSafeArea(.all)
        }
    }
//
//    struct WellDoneViewTeams: View {
//        let guessedWordsTeam1: [String: Bool]
//        let guessedWordsTeam2: [String: Bool]
//        let team1Gamescore: Int
//        let team2Gamescore : Int
//        let secondresetGameTeams: () -> Void
//        
//        var body: some View {
//            VStack {
//                // Display the guessed words for each team
//                ForEach(guessedWordsTeam1.sorted(by: { $0.0 < $1.0 }), id: \.key) { fruit, guessed in
//                    Text("Team1 result: \(fruit): \(guessed ? "Correct" : "Incorrect")")
//
//                }
//
//
//                ForEach(guessedWordsTeam2.sorted(by: { $0.0 < $1.0 }), id: \.key) { fruit, guessed in
//                    Text("Team2 result: \(fruit): \(guessed ? "Correct" : "Incorrect")")
//                }
//
//                // Display the team scores
//                Text("Team 1 Score: \(team1Gamescore)")
//                Text("Team 2 Score: \(team2Gamescore)")
//                Button(action: {
//                    secondresetGameTeams()
//                    //navigateToGameS = true
//                }, label: {
//                    Text("Replay Round")
//                    Image(systemName: "arrow.counterclockwise")
//                    .foregroundColor(.white).padding(.leading,200)  })
//                .buttonStyle(BigButton3D())
//                .modifier(BigAndMediumButtonTextModifier())
//                .padding()
//            }
//        }
//    }
    
    struct CheatViewTeams: View {
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
    struct TimeIsUpViewTeams: View {
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
    
    
    //--------------------------------------------------------------------------------------------------//
    
    
    // MARK: THIS IS RESULT TEAM CODE :)
   
    public struct SecondCodeView: View {
        @State private var navigateToGame = false
        @State private var navigateToMain = false
        @State private var showingBottomSheetTeam1 = false
        @State private var showingBottomSheetTeam2 = false
        let guessedWordsTeam1: [String: Bool]
        let guessedWordsTeam2: [String: Bool]
        @State private var team1Gamescore: Int
        @State private var team2Gamescore: Int
        let secondResetGameTeams: () -> Void
        let offset: CGFloat = 10
        
        //
        private func calculateScores() {
            team1Gamescore = guessedWordsTeam1.filter({ $0.value == true }).count
            team2Gamescore = guessedWordsTeam2.filter({ $0.value == true }).count
        }
        
        var body: some View {
            NavigationView {
                VStack {
                    ZStack {
                        Image("ResultboardTeams")
                            .overlay(TeamImage())
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350, height: 54)
                                    .foregroundColor(Color("LYellowShadow"))
                                    .offset(y: offset)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350, height: 54)
                                    .foregroundColor(Color("LYellow"))
                                
                                HStack {
                                    ZStack {
                                        Circle()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(Color("DPurple"))
                                        Image("SabbaraChar1")
                                            .resizable()
                                            .frame(width: 22.96, height: 19)
                                    }
                                    Text("Team 1")
                                    Spacer()
                                        .frame(width: 90)
                                    Text("\(team1Gamescore)")
                                    Button {
                                        showingBottomSheetTeam1.toggle()
                                    } label: {
                                        Image("DropdownIcon")
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350, height: 54)
                                    .foregroundColor(Color("LYellowShadow"))
                                    .offset(y: offset)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350, height: 54)
                                    .foregroundColor(Color("LYellow"))
                                
                                HStack {
                                    ZStack {
                                        Circle()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(Color("DGreen"))
                                        Image("SabbaraChar3")
                                            .resizable()
                                            .frame(width: 22.96, height: 19)
                                    }
                                    Text("Team 2")
                                    Spacer()
                                        .frame(width: 90)
                                    Text("\(team2Gamescore)")
                                    Button {
                                        showingBottomSheetTeam2.toggle()
                                    } label: {
                                        Image("DropdownIcon")
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                    VStack {
                        Button(action: {
                            secondResetGameTeams()
                        }, label: {
                            Text("Replay Round")
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.white)
                                .padding(.leading, 200)
                        })
                        .buttonStyle(BigButton3D())
                        .modifier(BigAndMediumButtonTextModifier())
                        .padding()
                        
                        Button {
                            navigateToMain = true
                        } label: {
                            Text("End Round")
                        }
                        .foregroundColor(Color("Lpink"))
                        .buttonStyle(WhBigButton3D())
                        .modifier(BigAndMediumButtonTextModifier())
                        .padding()
                    }
                    
                    .padding()
                }// end main vstack
                
                
                
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        RTCustomNavigationTitle()
                    }
                }
            }//end navigtion view
            .fullScreenCover(isPresented: $navigateToMain) {
                MainPage()
            }
            // this if for team 1
            .sheet(isPresented: $showingBottomSheetTeam1) {
                BottomSheet(guessedWords: guessedWordsTeam1)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            // this is for team 2
            .sheet(isPresented: $showingBottomSheetTeam2) {
                BottomSheet(guessedWords: guessedWordsTeam2)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            // this is for the func
            .onAppear {
                calculateScores()
            }
        }
        
        // I use this create an instance of SecondCodeView and provide the necessary initial values for its properties
        
        public init(guessedWordsTeam1: [String: Bool], guessedWordsTeam2: [String: Bool], team1Gamescore: Int, team2Gamescore: Int, secondResetGameTeams: @escaping () -> Void) {
            self.guessedWordsTeam1 = guessedWordsTeam1
            self.guessedWordsTeam2 = guessedWordsTeam2
            self._team1Gamescore = State(initialValue: team1Gamescore)
            self._team2Gamescore = State(initialValue: team2Gamescore)
            self.secondResetGameTeams = secondResetGameTeams
        }
        
        
        //MARK: THIS IS FOR TEAM IMAGE DISPLAY
        @ViewBuilder
        private func TeamImage() -> some View {
            if team1Gamescore > team2Gamescore {
                Circle()
                    .frame(width: 94, height: 94)
                    .foregroundColor(Color("DPurple"))
                    .overlay(
                        Image("SabbaraChar1")
                            .resizable()
                            .frame(width: 79.31, height: 64.63)
                    )
            } else if team2Gamescore > team1Gamescore {
                Circle()
                    .frame(width: 94, height: 94)
                    .foregroundColor(Color("DGreen"))
                    .overlay(
                        Image("SabbaraChar3")
                            .resizable()
                            .frame(width: 79.31, height: 64.63)
                    )
            }
        }
    }


    //MARK: THIS IS THE Bottom Sheet IT HAS guessedWords ACTION IN IT
    struct BottomSheet: View {
        @State private var offset: CGFloat = 10
        @State private var Offset: CGFloat = 5
        let guessedWords: [String: Bool]
        
        var body: some View {
            VStack {
                ZStack {
                    Image("ResultboardNotFill")
                        .resizable()
                        .frame(width: 386, height: 64)
                    
                    Text("point")
                        .foregroundColor(Color("Lpink"))
                }
                .padding(.top, 50)
                
                if !guessedWords.isEmpty {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 330, height: 328)
                            .foregroundColor(Color("LYellowShadow"))
                            .offset(x: Offset, y: offset)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 330, height: 328)
                            .foregroundColor(Color("LYellow"))
                        
                        ScrollView {
                            VStack(alignment: .center, spacing: 5) {
                                ForEach(guessedWords.sorted(by: { $0.0 < $1.0 }), id: \.key) { fruit, guessed in
                                    Text("\(fruit)")
                                        .foregroundColor(guessed ? .green : .red)
                                }
                            }
                            .frame(width: 310)
                        }
                        .frame(height: 290)
                    }
                }
            }
        }
    }

    
    //MARK: THIS struct IF THE NAVIGATION TITILE
    struct RTCustomNavigationTitle: View {
        var body: some View {
            VStack {
                Text(NSLocalizedString("Results", comment: ""))
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.black)
                
            }
        }
    }
    
    
}

