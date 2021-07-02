//
//  History.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 7/1/21.
//

import Foundation

struct History: Identifiable {
    let id: UUID
    let date: Date
    var chordSequenceMembers: [String]
    var lengthInMinutes: Int
    var changeCount: Int

    init(id: UUID = UUID(), date: Date = Date(), chordSequenceMembers: [String], lengthInMinutes: Int, changeCount: Int) {
        self.id = id
        self.date = date
        self.chordSequenceMembers = chordSequenceMembers
        self.lengthInMinutes = lengthInMinutes
        self.changeCount = changeCount
    }
}
