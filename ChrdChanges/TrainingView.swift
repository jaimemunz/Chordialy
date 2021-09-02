//
//  ContentView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI
import AVFoundation

struct TrainingView: View {
    @Binding var sequence: ChordSequence
    @StateObject var trainingTimer = TrainingTimer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(sequence.color)
            VStack {
                TrainingHeaderView(secondsElapsed: trainingTimer.secondsElapsed, secondsRemaining: trainingTimer.secondsRemaining, sequenceColor: sequence.color)
                SessionTimerView(chords: trainingTimer.chords, activeChord: trainingTimer.activeChord, sessionColor: sequence.color)
                TrainingFooterView(chords: trainingTimer.chords, activeChord: trainingTimer.activeChord, skipAction: trainingTimer.skipChord)
            }
        }
        .padding()
        .foregroundColor(sequence.color.accessibleFontColor)
        .onAppear {
            trainingTimer.reset(lengthInMinutes: sequence.lengthInMinutes, chordSequenceMembers: sequence.chordSequenceMembers)
            trainingTimer.timerEndAction = {
                player.seek(to: .zero)
                player.play()
            }
            trainingTimer.startTraining()
        }
        .onDisappear {
            trainingTimer.stopTraining()
            let newHistory = History(chordSequenceMembers: sequence.chordSequenceMembers, lengthInMinutes: trainingTimer.secondsElapsed / 60, changeCount: trainingTimer.chordCount)
            sequence.history.append(newHistory)
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(sequence: .constant(ChordSequence.data[0]))
    }
}
