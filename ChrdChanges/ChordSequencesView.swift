//
//  SwiftUIView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/20/21.
//

import SwiftUI

struct ChordSequencesView: View {
    @Binding var sequences: [ChordSequence]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newSequenceData = ChordSequence.Data()
    let saveAction: () -> Void
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
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented){
            NavigationView {
                EditView(chordSequenceData: $newSequenceData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newSequence = ChordSequence(chordSequenceName: newSequenceData.chordSequenceName, chordSequenceMembers: newSequenceData.chordSequenceMembers, lengthInMinutes: Int(newSequenceData.lengthInMinutes), color: newSequenceData.color)
                        isPresented = false
                        sequences.append(newSequence)
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
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
            ChordSequencesView(sequences: .constant(ChordSequence.data), saveAction: {})
        }
    }
}
