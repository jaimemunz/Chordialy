//
//  ContentView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 4/8/21.
//

import SwiftUI

struct TrainingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 60)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            .accessibilityElement(children:.ignore)
            .accessibilityLabel(Text("Time remaining"))
            .accessibilityValue(Text("10 minutes"))
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            HStack {
                Text("Chord 1 of 3")
                Spacer()
                Button(action:{}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel(Text("Next speaker"))
            }
        }
        .padding()
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
