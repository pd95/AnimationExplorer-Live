//
//  AdjustmentGrabHandleView.swift
//  AnimationExplorer
//
//  Created by Philipp on 24.06.23.
//

import SwiftUI

struct AdjustmentGrabHandleView: View {
    @Binding var point: CGPoint
    var color: Color
    var proxy: GeometryProxy

    let grabHandleSize = 44.0

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: grabHandleSize, height: grabHandleSize)
            .offset(
                x: offset(for: point.x, in: proxy.size.width),
                y: offset(for: point.y, in: proxy.size.height)
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ gesture in
                        point.x = gesture.location.x / proxy.size.width
                        point.y = gesture.location.y / proxy.size.height

                        point.x = min(1, max(0, point.x))
                        point.y = min(1, max(0, point.y))
                    })
            )

    }

    private func offset(for value: CGFloat, in size: CGFloat) -> CGFloat {
        value * size - grabHandleSize/2
    }
}

#Preview {
    GeometryReader { proxy in
        AdjustmentGrabHandleView(point: .constant(.zero), color: .pink, proxy: proxy)
    }
}
