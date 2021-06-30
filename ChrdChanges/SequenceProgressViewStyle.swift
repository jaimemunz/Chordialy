//
//  SequenceProgressViewStyle.swift
//  ChrdChanges
//

import SwiftUI

struct SequenceProgressViewStyle: ProgressViewStyle {
    var sequenceColor: Color

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(sequenceColor.accessibleFontColor)
                .frame(height: 20.0)
            ProgressView(configuration)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}
