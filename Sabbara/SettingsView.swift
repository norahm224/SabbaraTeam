//
//  SettingsView.swift
//  sabar
//
//  Created by Nourah Almusaad on 23/05/2023.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @State private var stopMusic = false
    @State private var stopVibration = false
    //@State private var isVibrationEnabled = true // New state variable to track vibration state
    @State private var isShowingSettings = false
    @State private var showAlert = false
    let instagramURL = URL(string: "https://www.instagram.com/sabbaragame/?igshid=NTc4MTIwNjQ2YQ%3D%3D")!
        let emailAddress = "sabbaragame@gmail.com"
        let tiktokUsername = "www.tiktok.com/@sabbaragame"
    var body: some View {
        
        ZStack {
            Color.white.opacity(showAlert ? 0.3 : 1.0)
            MainView
            
        }
        .ignoresSafeArea()

        
    }
}

 
extension SettingsView {
    
    var MainView: some View {
        
        VStack {
            Toggle(isOn: $stopMusic) {
                Text("Music")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.white)
            }
            .onChange(of: stopMusic) { newValue in
                if newValue {
                    SoundManager.instance.stopSound()
                } else {
                    SoundManager.instance.playSound(sound: .SabbaragameMusic)
                }
            }
            .toggleStyle(RectangularToggleStyle())
            .frame(width: 255, height: 71.74)
            .background(Color("DGreen"))
            .cornerRadius(10)
            
            
            Toggle( isOn: $stopVibration) {
                Text("Vibrations")
                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
                    .foregroundColor(.white)
            }
            
            .toggleStyle(RectangularToggleStyle())
            .frame(width: 255, height: 71.74)
            .background(Color("DGreen"))
            .cornerRadius(10)
            
            HStack (spacing: 20) {
                Button(action: {
                    openInstagram()
                }) {
                    Image("Instgram")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Button(action: {
                    sendEmail()
                }) {
                    Image("Email")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Button(action: {
                    openTikTok()
                }) {
                    Image("TikTok")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
//            Button(action: {
//                // Redirect to email app
//                if MFMailComposeViewController.canSendMail() {
//                    let composeVC = MFMailComposeViewController()
//                    composeVC.setToRecipients(["norah.213113778@hotmail.com"])
//                    // You can customize the email subject and body here if needed
//                    composeVC.setSubject("Feedback")
//                    composeVC.setMessageBody("", isHTML: false)
//                    UIApplication.shared.windows.first?.rootViewController?.present(composeVC, animated: true, completion: nil)
//                }
//            }) {
//                Text("Contact Us")
//                    .font(.custom("TufuliArabicDEMO-Medium", size: 24))
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width:255, height: 71.74)
//                    .background(Color("DGreen"))
//                    .cornerRadius(9)
//            }
            Spacer()
        }
    }
    func openInstagram() {
            UIApplication.shared.open(instagramURL)
        }
        
        func sendEmail() {
            guard MFMailComposeViewController.canSendMail() else {
                // Handle the case when the device is not set up for sending emails
                return
            }
            
            let composeVC = MFMailComposeViewController()
            composeVC.setToRecipients([emailAddress])
            
            // Customize the email's subject and body if needed
            
            UIApplication.shared.windows.first?.rootViewController?.present(composeVC, animated: true)
        }
        
        func openTikTok() {
            guard let tiktokURL = URL(string: "https://www.tiktok.com/@\(tiktokUsername)") else {
                return
            }
            
            UIApplication.shared.open(tiktokURL)
        }
}


func stopMusicChanged(_ isOn: Bool) {
    if isOn {
        SoundManager.instance.stopSound()
    } else {
        SoundManager.instance.playSound(sound: .SabbaragameMusic)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


struct RectangularToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
                Button(action: { configuration.isOn.toggle() }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(configuration.isOn ? Color("DPurple") : Color("Lpink"))
                        .frame(width: 37, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 4)
                        )
                        .animation(.linear(duration: 0.2))
                        .offset(x: configuration.isOn ? 15 : -15)
                    
                }
                .frame(width: 75.97, height: 32.88)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 4)
                )
            }
            .padding()
            
        }
    }
}

