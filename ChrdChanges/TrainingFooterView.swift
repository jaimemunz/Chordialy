//
//  TrainingFooterView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 6/29/21.
//

import SwiftUI

struct TrainingFooterView: View {
    let chords: [TrainingTimer.Chord]
    let activeChord: String
    var skipAction: () -> Void
    private var chordNumber: Int? {
        guard let index = chords.firstIndex(where: { $0.name == activeChord }) else { return nil }
        return index + 1
    }
    //private var isLastChord: Bool {
    //    return chords.dropLast().allSatisfy { $0.isCompleted }
    //}
    private var chordText: String {
        guard let chordNumber = chordNumber else { return "No more chords" }
        return "Chord \(chordNumber) of \(chords.count)"
    }
    var body: some View {
        VStack {
            HStack {
                //if isLastChord {
                //    Text("Last Chord")
                //} else {
                Text(chordText)
                Spacer()
                Button(action: skipAction) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel(Text("Next chord"))
                //}
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct TrainingFooterView_Previews: PreviewProvider {
    static var chords = [TrainingTimer.Chord(name: "A", isCompleted: false), TrainingTimer.Chord(name: "E", isCompleted: false)]
    static var previews: some View {
        TrainingFooterView(chords: chords, activeChord: "A", skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
