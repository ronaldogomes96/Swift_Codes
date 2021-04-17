//
//  ViewController.swift
//  GoldenRecordAudioTests
//
//  Created by Ronaldo Gomes on 14/04/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    //var sound: AVAudioPlayer?
    
    //var audios: [Audios] = []
    
    var itemsToPlay: [AVPlayerItem] = []
    
    var allItems = Audios.allCases.map {
        AVPlayerItem(url: Bundle.main.url(forResource: "GoldenRecord/\($0.rawValue)", withExtension: "au")!)
    }
    
    @IBOutlet weak var audioName: UILabel!
    let queue = AVQueuePlayer(items: [])
    //var x = 0
    //var isPlayer = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audiosToPlay: [Audios] = [.Akkadian, .Greek, .Portuguese, .Arabic, .English, .French]

        audiosToPlay.forEach {
            if let index = Audios.allCases.firstIndex(of: $0) {
                itemsToPlay.append(allItems[index])
            }
        }
        
        
        
        queue.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { [self] (CMTime) -> Void in
            if let index = self.allItems.firstIndex(of: queue.currentItem!) {
                //print(Audios.allCases[index].rawValue)
                self.audioName.text = Audios.allCases[index].rawValue
            }
         }
    }
    
    
    
    @IBAction func TappedPlayButton(_ sender: UIButton) {
        
        itemsToPlay.forEach {
            queue.insert($0, after: nil)
        }
        
        queue.play()
        
        
        
        
        //        for audios in audio {
        //            // Fetch the Sound data set.
        //            if let asset = NSDataAsset(name: audios.rawValue ){
        //
        //                do {
        //                    // Use NSDataAsset's data property to access the audio file stored in Sound.
        //                    sound = try AVAudioPlayer(data:asset.data, fileTypeHint:"au")
        //                    // Play the above sound file.
        //                    sound?.play()
        //                } catch let error as NSError {
        //                    print(error.localizedDescription)
        //                }
        //            }
        //        }
        
        //        audio.forEach { audios in
        //            if let asset = NSDataAsset(name: audios.rawValue ){
        //
        //                do {
        //                    // Use NSDataAsset's data property to access the audio file stored in Sound.
        //                    sound = try AVAudioPlayer(data:asset.data, fileTypeHint:"au")
        //                    // Play the above sound file.
        //                    sound?.play()
        //                    sound?.isPlaying
        //                } catch let error as NSError {
        //                    print(error.localizedDescription)
        //                }
        //            }
        //        }
        
//        if let asset = NSDataAsset(name: audios.rawValue ){
//            do {
//                // Use NSDataAsset's data property to access the audio file stored in Sound.
//                sound = try AVAudioPlayer(data:asset.data, fileTypeHint:"au")
//
//                // Play the above sound file.
//                sound?.play()
//                sound?.isPlaying
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
        
    }
}


enum Audios: String, CaseIterable {
    case Akkadian = "Akkadian"
    case Amoy = "Amoy"
    case Arabic = "Arabic"
    case Aramaic = "Aramaic"
    case Armenian = "Armenian"
    case Bengali = "Bengali"
    case Burmese = "Burmese"
    case Cantonese = "Cantonese"
    case Czech = "Czech"
    case Dutch = "Dutch"
    case English = "English"
    case French = "French"
    case German = "German"
    case Greek = "Greek"
    case Gujarati = "Gujarati"
    case Hebrew = "Hebrew"
    case Hindi = "Hindi"
    case Hittite = "Hittite"
    case Hungarian = "Hungarian"
    case Ila = "Ila"
    case Indonesian = "Indonesian"
    case Italian = "Italian"
    case Japanese = "Japanese"
    case Kannada = "Kannada"
    case Kechua = "Kechua"
    case Korean = "Korean"
    case Latin = "Latin"
    case Luganda = "Luganda"
    case Mandarin = "Mandarin"
    case Marathi = "Marathi"
    case Nepali = "Nepali"
    case Nguni = "Nguni"
    case Nyanja = "Nyanja"
    case Oriya = "Oriya"
    case Persian = "Persian"
    case Polish = "Polish"
    case Portuguese = "Portuguese"
    case Punjabi = "Punjabi"
    case Rajasthani = "Rajasthani"
    case Romanian = "Romanian"
    case Russian = "Russian"
    case Serbian = "Serbian"
    case Sinhalese = "Sinhalese"
    case Sotho = "Sotho"
    case Spanish = "Spanish"
    case Sumerian = "Sumerian"
    case Swedish = "Swedish"
    case Telugu = "Telugu"
    case Thai = "Thai"
    case Turkish = "Turkish"
    case Ukrainian = "Ukrainian"
    case Urdu = "Urdu"
    case Vietnamese = "Vietnamese"
    case Welsh = "Welsh"
    case Wu = "Wu"
}

