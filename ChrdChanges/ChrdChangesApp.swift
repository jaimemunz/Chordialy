//
//  ChrdChangesApp.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI

@main
struct ChrdChangesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ChordSequencesView(sequences: ChordSequence.data)
            }
        }
    }
}
