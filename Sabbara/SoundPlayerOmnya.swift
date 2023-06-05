//
//  SoundPlayerOmnya.swift
//  Sabbara
//
//  Created by Omnya Kamal  on 09/06/2023.
//
import AVFoundation

class SoundPlayeromnya {
    static let shared = SoundPlayeromnya()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound(named soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.prepareToPlay()
            player?.play()
            
            // Stop playing sound after a second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.player?.stop()
                self.player = nil
            }
        } catch {
            print("Failed to play sound: \(error)")
        }
            }
    func stopSound() {
           player?.stop()
           player = nil
       }

}
