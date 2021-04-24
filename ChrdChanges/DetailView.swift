//
//  DetailView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/22/21.
//

import SwiftUI

struct DetailView: View {
    let sequence: ChordSequence
    
    var body: some View {
        List {
            Section(header: Text("Chord Sequence Info")) {
                NavigationLink(destination: TrainingView()) {
                    Label("Start Timer", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start timer"))
                }
                HStack {
                    Label("Length", systemImage: "clock")
                        .accessibilityLabel(Text("Practice length"))
                    Spacer()
                    Text("\(sequence.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(sequence.color)
                }
                .accessibilityElement(children: .ignore)
            }
            Section(header: Text("Chords")) {
                ForEach(sequence.chordSequenceMembers, id: \.self) { chord in
                    Label(chord, systemImage: "music.quarternote.3")
                        .accessibilityLabel(Text("Chord"))
                        .accessibilityLabel(Text(chord))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(sequence.chordSequenceName)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(sequence: ChordSequence.data[0])
        }
    }
}
