//
//  SequenceData.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 7/21/21.
//

import Foundation

class SequenceData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory")
        }
    }
    
    private static var fileURL: URL {
        documentsFolder.appendingPathComponent("sequences.data")
    }
    
    @Published var sequences: [ChordSequence] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.sequences = ChordSequence.data
                }
                #endif
                return
            }
            guard let chordSequences = try? JSONDecoder().decode([ChordSequence].self, from: data) else {
                fatalError("Can't decode saved sequence data")
            }
            DispatchQueue.main.async {
                self?.sequences = chordSequences
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let sequences = self?.sequences else { fatalError("Self out of scope")}
            guard let data = try? JSONEncoder().encode(sequences) else { fatalError("Error encoding data") }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Could not write to file")
            }
        }
    }
    
}
