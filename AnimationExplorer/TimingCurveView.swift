//
//  TimingCurveView.swift
//  AnimationExplorer
//
//  Created by Philipp on 24.06.23.
//

import SwiftUI

struct TimingCurveView: View {
    var startPoint: CGPoint
    var endPoint: CGPoint

    var body: some View {
        let startX = startPoint.x.dp(2)
        let startY = (1 - startPoint.y).dp(2)
        let endX = endPoint.x.dp(2)
        let endY = (1 - endPoint.y).dp(2)

        Text("Animation.timingCurve(\n\t\(startX), \(startY), \(endX), \(endY)\n)")
            .monospaced()
            .textSelection(.enabled)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TimingCurveView(startPoint: .zero, endPoint: .zero)
}
