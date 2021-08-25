//
//  ChrdChangesApp.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//
import SwiftUI

@main
struct ChrdChangesApp: App {
    @ObservedObject private var data = SequenceData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ChordSequencesView(sequences: $data.sequences) {
                    data.save()
                }
            }.onAppear {
                data.load()
            }.navigationViewStyle(StackNavigationViewStyle()) // needed to suppress warning
        }
    }
}
