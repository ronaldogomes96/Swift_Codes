//
//  ContentView.swift
//  POC_APIs
//
//  Created by Ronaldo Gomes on 17/05/21.
//

import SwiftUI
import Nuke
import FetchImage
import AVKit


struct ContentView: View {
    
    @StateObject private var model = Model(url: .poetrydb, token: .rijksmuseum)
    
    var body: some View {
        List(model.data, id:\.self) {
            if let uiImage = UIImage(data: $0) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
            } else if  model.url != .poetrydb ,
                       let player = AVPlayer(url: URL(string: String(decoding: $0, as: UTF8.self))!) {
                VideoPlayer(player: player)
                    .frame(width: 400, height: 300)
                    .onAppear() {
                        player.play()
                    }
            } else if model.url == .poetrydb {
                Text("\(String(decoding: $0, as: UTF8.self))")
                Spacer()
            }
                
            else {
                ProgressView()
            }
        }
        .onAppear {
            model.getImageUrl()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
