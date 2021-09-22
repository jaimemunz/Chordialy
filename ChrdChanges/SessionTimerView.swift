//
//  SessionTimerView.swift
//  ChrdChanges
//
//  Created by Jaime Munoz on 8/31/21.
//

import SwiftUI

struct SessionArc: Shape {
    let progress: Double
    private var degreesInSession: Double {
         360.0
    }
    private var startAngle : Angle {
        Angle(degrees: 0.0)
    }
    private var endAngle : Angle {
        Angle(degrees: progress)
    }
    
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2.0, y: rect.origin.y + rect.size.height / 2.0)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}

struct SessionTimerView: View {
    let chords: [TrainingTimer.Chord]
    let activeChord: String
    let secondsElapsed: Int
    let secondsRemaining: Int
    
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        return (Double(secondsElapsed) / totalSeconds) * 360
    }
    
    var sessionColor: Color
    // Needs to use TrainingTimer.activeChord observable
    private var currentChord: String { chords.first(where: { !$0.isCompleted })?.name ?? "Some chord" }
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text(activeChord)
                    .font(.title)
                Text("is the current chord")
            }
            .accessibilityElement(children: .combine)
            .foregroundColor(sessionColor.accessibleFontColor)
            SessionArc(progress: progress)
                .rotation(Angle(degrees: -90))
                .stroke(sessionColor, lineWidth: 12)
            
        }
        .padding(.horizontal)
    }
}

struct SessionTimerView_Previews: PreviewProvider {
    static var chords = [TrainingTimer.Chord(name: "A", isCompleted: true), TrainingTimer.Chord(name: "E", isCompleted: false)]
    static var previews: some View {
        SessionTimerView(chords: chords, activeChord: "A", secondsElapsed: 30, secondsRemaining: 90,  sessionColor: Color("EA"))
    }
}
