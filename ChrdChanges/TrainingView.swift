//
//  ContentView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI

struct TrainingView: View {
    
    @Binding var sequence: ChordSequence
    @StateObject var trainingTimer = TrainingTimer()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(sequence.color)
            VStack {
                TrainingHeaderView(secondsElapsed: trainingTimer.secondsElapsed, secondsRemaining: trainingTimer.secondsRemaining, sequenceColor: sequence.color)
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                TrainingFooterView(chords: trainingTimer.chords, activeChord: trainingTimer.activeChord, skipAction: trainingTimer.skipChord)
            }
        }
        .padding()
        .foregroundColor(sequence.color.accessibleFontColor)
        .onAppear {
            trainingTimer.reset(lengthInMinutes: sequence.lengthInMinutes, chordSequenceMembers: sequence.chordSequenceMembers)
            trainingTimer.startTraining()
        }
        .onDisappear {
            //print("ContentView disappeared!")
            trainingTimer.stopTraining()
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(sequence: .constant(ChordSequence.data[0]))
    }
}
