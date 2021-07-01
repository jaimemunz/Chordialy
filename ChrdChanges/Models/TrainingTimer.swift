//
//  TrainingTimer.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 6/28/21.
//

import Foundation

class TrainingTimer: ObservableObject {
    struct Chord: Identifiable {
        let name: String
        var isCompleted: Bool
        let id = UUID()
    }
    @Published var activeChord = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    @Published var chordCount = 0
    var chords: [Chord] = []

    var lengthInMinutes: Int
    var timerEndAction: (() -> Void)?

    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerChord: Int {
        (lengthInMinutes * 60) / chords.count
    }
    private var secondsElapsedForChord: Int = 0
    private var chordIndex: Int = 0
    private var chordText: String {
        return chords[chordIndex].name
    }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, chordSequenceMembers: [String] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.chords = chordSequenceMembers.isEmpty ? [Chord(name: "Chord 1", isCompleted: false)] : chordSequenceMembers.map { Chord(name: $0, isCompleted: false) }
        secondsRemaining = lengthInSeconds
        activeChord = chordText
    }
    func startTraining() {
        chordCount = 0
        changeToChord(at: 0)
    }
    func stopTraining() {
        print("Stopped")
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    func skipChord() {
        if secondsRemaining > 0 {
            changeToChord(at: chordIndex + 1)
        } else {
            return
        }
    }

    private func changeToChord(at index: Int) {
        if index > 0 {
            let previousChordIndex = index - 1
            chords[previousChordIndex].isCompleted = true
        }
        if index >= chords.count {
            chordIndex = 0
        } else {
            chordIndex = index
        }
        activeChord = chordText
        if (chordCount == 0) {
            startDate = Date()
            secondsElapsed = Int(Date().timeIntervalSince1970 - startDate!.timeIntervalSince1970)
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
                if let self = self, let startDate = self.startDate {
                    let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                    self.update(secondsElapsed: Int(secondsElapsed))
                }
            }
        }
        secondsRemaining = lengthInSeconds - secondsElapsed
    }

    private func update(secondsElapsed: Int) {
        secondsRemaining = max(lengthInSeconds - secondsElapsed, 0)
        chordCount = chordCount + 1
        print(secondsElapsed)
        if secondsRemaining == 0 {
            stopTraining()
            self.secondsElapsed = lengthInSeconds
            timerEndAction?()
        } else {
            self.secondsElapsed = secondsElapsed
        }
        guard !timerStopped else { return }
        
    }
    
    func reset(lengthInMinutes: Int, chordSequenceMembers: [String]) {
        self.lengthInMinutes = lengthInMinutes
        self.chords = chordSequenceMembers.isEmpty ? [Chord(name: "Chord 1", isCompleted: false)] : chordSequenceMembers.map { Chord(name: $0, isCompleted: false) }
        secondsRemaining = lengthInSeconds
        activeChord = chordText
    }
}

extension ChordSequence {
    var timer: TrainingTimer {
        TrainingTimer(lengthInMinutes: lengthInMinutes, chordSequenceMembers: chordSequenceMembers)
    }
}
