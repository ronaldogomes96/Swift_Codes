//
//  ContentView.swift
//  SwitUIGrid
//
//  Created by Ronaldo Gomes on 24/05/21.
//

import SwiftUI

struct ContentView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private var gridAdaptiveLayout = [GridItem(.adaptive(minimum: 160), spacing: 16)]
    
    var body: some View {
        NavigationView {
            //GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridAdaptiveLayout, spacing: 16) {
                        ForEach((0...9999), id: \.self) { number in
                            NavigationLink(destination: SecondScreen()) {
                                
                                MiniMoodboard(number: number)
//                                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
//                                    .frame(idealWidth: 160,
//                                           idealHeight: 160)
                                
                                //Text("FAVORITO \(number)")
                            }
                        }
                    }
                    
               // }
                .padding(.horizontal, 16)
                .navigationTitle("Moodboard")
            }
        }
        .colorScheme(.dark)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
