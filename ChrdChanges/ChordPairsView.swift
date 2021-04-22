//
//  SwiftUIView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/20/21.
//

import SwiftUI

struct ChordSequencesView: View {
    let sequences: [ChordSequence]
    
    var body: some View {
        List {
            ForEach(sequences) { sequence in
                NavigationLink(destination: DetailView(sequence: sequence)) {
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
}

struct ChordPairsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChordSequencesView(sequences: ChordSequence.data)
        }
    }
}
