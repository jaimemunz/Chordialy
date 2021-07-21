//
//  ChordPair.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI

struct ChordSequence: Identifiable {
    let id: UUID
    var chordSequenceName: String
    var chordSequenceMembers: [String]
    var lengthInMinutes: Int
    var color: Color
    
    init(id: UUID = UUID(), chordSequenceName: String, chordSequenceMembers: [String], lengthInMinutes: Int, color: Color) {
        self.id = id
        self.chordSequenceName = chordSequenceName
        self.chordSequenceMembers = chordSequenceMembers
        self.lengthInMinutes = lengthInMinutes
        self.color = color
    }
    
}

extension ChordSequence {
    static var data: [ChordSequence] {
        [
            ChordSequence(chordSequenceName: "AG", chordSequenceMembers: ["A","G"], lengthInMinutes: 1, color: Color("AG")),
            ChordSequence(chordSequenceName: "EG", chordSequenceMembers: ["E","A"], lengthInMinutes: 1, color: Color("EA")),
            ChordSequence(chordSequenceName: "DE", chordSequenceMembers: ["D","E"], lengthInMinutes: 1, color: Color("DE"))
        ]
    }
}

extension ChordSequence {
    struct Data {
        var chordSequenceName: String = ""
        var chordSequenceMembers: [String] = []
        var lengthInMinutes: Double = 5.0
        var color: Color = .random
    }
    
    var data: Data {
        return Data(chordSequenceName: chordSequenceName, chordSequenceMembers: chordSequenceMembers, lengthInMinutes: Double(lengthInMinutes), color: color)
    }
}
