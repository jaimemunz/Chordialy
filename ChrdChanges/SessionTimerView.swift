//
//  SessionTimerView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 8/31/21.
//

import SwiftUI

struct SessionTimerView: View {
    let chords: [TrainingTimer.Chord]
    let activeChord: String
    var sessionColor: Color
    // Needs to use TrainingTimer.activeChord observable
    private var currentChord: String { chords.first(where: { !$0.isCompleted })?.name ?? "Some chord" }
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text(activeChord)
                    .font(.title)
                Text("is the current chord")
            }
            .accessibilityElement(children: .combine)
            .foregroundColor(sessionColor.accessibleFontColor)
        }
        .padding(.horizontal)
    }
    
}

struct SessionTimerView_Previews: PreviewProvider {
    static var chords = [TrainingTimer.Chord(name: "A", isCompleted: true), TrainingTimer.Chord(name: "E", isCompleted: false)]
    static var previews: some View {
        SessionTimerView(chords: chords, activeChord: "A", sessionColor: Color("EA"))
    }
}
