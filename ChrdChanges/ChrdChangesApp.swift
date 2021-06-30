//
//  ChrdChangesApp.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//
import SwiftUI

@main
struct ChrdChangesApp: App {
    @State private var sequences = ChordSequence.data
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ChordSequencesView(sequences: $sequences)
            }.navigationViewStyle(StackNavigationViewStyle()) // needed to suppress warning
        }
    }
}
