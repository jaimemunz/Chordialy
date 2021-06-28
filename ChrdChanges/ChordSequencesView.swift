//
//  SwiftUIView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/20/21.
//

import SwiftUI

struct ChordSequencesView: View {
    @Binding var sequences: [ChordSequence]
    
    var body: some View {
        List {
            ForEach(sequences) { sequence in
                NavigationLink(destination: DetailView(sequence: binding(for: sequence))) {
                    CardView(chordSequence: sequence)
                }
                .listRowBackground(sequence.color)
            }
        }
        .navigationTitle("Chord Sequences")
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "plus")
        })
    }
    
    private func binding(for sequence: ChordSequence) -> Binding<ChordSequence> {
        guard let sequenceIndex = sequences.firstIndex(where: { $0.id == sequence.id }) else {
            fatalError("Can't find sequence in array")
        }
        return $sequences[sequenceIndex]
    }
}

struct ChordPairsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChordSequencesView(sequences: .constant(ChordSequence.data))
        }
    }
}
