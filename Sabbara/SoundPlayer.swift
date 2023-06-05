//
//  SoundPlayer.swift
//  sabar
//
//  Created by Nourah Almusaad on 06/06/2023.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOpion: String {
        case SabbaragameMusic
        case SabbaraWrong
        case SabbaraRight
    }
    func playSound(sound: SoundOpion) {
         guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
         
         do {
             player = try AVAudioPlayer(contentsOf: url)
             player?.numberOfLoops = -1 // Set number of loops to -1 for infinite looping
             player?.play()
         } catch let error {
             print("Error playing sound: \(error.localizedDescription)")
         }
     }
    func stopSound() {
        player?.stop()
        player = nil
    }
}
struct SoundPlayer: View {
    var body: some View {
        VStack {
            Button("play Sound1") {
                SoundManager.instance.playSound(sound: .SabbaragameMusic)
            }
//            Button("play Sound2") {
//                SoundManager.instance.playSound(sound: .SabbaraWrong)
//            }
//            Button("play Sound3") {
//                SoundManager.instance.playSound(sound: .SabbaraRight)
//            }
//            Button("Stop Sound") {
//                SoundManager.instance.stopSound()
//            }
            
        }
    }
}

struct SoundPlayer_Previews: PreviewProvider {
    static var previews: some View {
        SoundPlayer()
    }
}
