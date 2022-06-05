//
//  DashLine.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct DashLine: View {
    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
            .frame(height: 1)
            .opacity(0.5)
    }

    private struct Line: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            return path
        }
    }
}

struct DashLine_Previews: PreviewProvider {
    static var previews: some View {
        DashLine()
    }
}
