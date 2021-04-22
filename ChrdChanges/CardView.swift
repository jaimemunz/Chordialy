//
//  CardView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI

struct CardView: View {
    let chordSequence: ChordSequence
    var body: some View {
        VStack(alignment:.leading) {
            Text(chordSequence.chordSequenceName)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(chordSequence.chordSequenceMembers.count)", systemImage: "music.quarternote.3")
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Chords"))
                Spacer()
                Label("\(chordSequence.lengthInMinutes)",           systemImage: "clock")
                    .padding(.trailing, 20)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Training length"))
                    .accessibilityValue(Text("\(chordSequence.lengthInMinutes) minutes"))
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(chordSequence.color.accessibleFontColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var pair = ChordSequence.data[0]
    static var previews: some View {
        CardView(chordSequence: pair)
            .background(pair.color)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
