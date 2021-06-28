//
//  EditView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/22/21.
//

import SwiftUI

struct EditView: View {
    @Binding var chordSequenceData: ChordSequence.Data
    @State private var newChordMember = ""
    var body: some View {
        List {
            Section(header: Text("Training Info")) {
                TextField("Sequence", text: $chordSequenceData.chordSequenceName)
                HStack {
                    Slider(value: $chordSequenceData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text("Length")
                    }
                    .accessibilityValue(Text("\(Int(chordSequenceData.lengthInMinutes)) minutes"))
                    Spacer()
                    Text("\(Int(chordSequenceData.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ColorPicker("Color", selection: $chordSequenceData.color)
                    .accessibilityLabel(Text("Color Picker"))
            }
            Section(header: Text("Chord Members")) {
                ForEach(chordSequenceData.chordSequenceMembers, id: \.self) { chordMember in
                    Text(chordMember)
                }
                .onDelete { indices in
                    chordSequenceData.chordSequenceMembers.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Chord Member", text: $newChordMember)
                    Button(action: {
                        withAnimation {
                            chordSequenceData.chordSequenceMembers.append(newChordMember)
                            newChordMember = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Add chord member"))
                    }
                    .disabled(newChordMember.isEmpty)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(chordSequenceData: .constant(ChordSequence.data[0].data))
    }
}
