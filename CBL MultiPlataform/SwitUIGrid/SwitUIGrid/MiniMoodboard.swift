//
//  MiniMoodboard.swift
//  SwitUIGrid
//
//  Created by Ronaldo Gomes on 25/05/21.
//

import SwiftUI

struct MiniMoodboard: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var colors: [Color] = [.yellow, .purple, .green]
    
    let number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: symbols[number % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .background(colors[number % colors.count])
                    
                    Image(systemName: symbols[number % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .background(colors[number % colors.count])
                }
                //.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
               //.clipShape(RoundedRectangle(cornerRadius: 26))
                HStack(spacing: 4)  {
                    Image(systemName: symbols[number % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .background(colors[number % colors.count])
                    
                    Image(systemName: symbols[number % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                        .background(colors[number % colors.count])
                }
                //.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                //.clipShape(RoundedRectangle(cornerRadius: 26))
            }
            .clipShape(RoundedRectangle(cornerRadius: 26))
            Text("Favorite \(number)")
                .padding(.vertical, 1)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .foregroundColor(.white)
        }
        
    }
}

struct MiniMoodboard_Previews: PreviewProvider {
    static var previews: some View {
        MiniMoodboard(number: 0)
    }
}
