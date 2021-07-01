//
//  TrainingHeaderView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 6/28/21.
//

import SwiftUI

struct TrainingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        return Double(secondsElapsed) / totalSeconds
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    let sequenceColor: Color
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(SequenceProgressViewStyle(sequenceColor: sequenceColor))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    HStack {
                        Text("\(secondsRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
        }
        .accessibilityElement(children:.ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top, .horizontal])
    }
}

struct TrainingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingHeaderView(secondsElapsed: 60, secondsRemaining: 180, sequenceColor: ChordSequence.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
