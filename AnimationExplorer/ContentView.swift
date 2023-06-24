//
//  ContentView.swift
//  AnimationExplorer
//
//  Created by Philipp on 24.06.23.
//

import SwiftUI

struct ContentView: View {
    @State private var userStartPoint = CGPoint(x: 0, y: 1)
    @State private var userEndPoint = CGPoint(x: 1, y: 0)

    @State private var defaultStartPoint = CGPoint(x: 0, y: 1)
    @State private var defaultEndPoint = CGPoint(x: 1, y: 0)

    @State private var duration: CGFloat = 1.0

    @State private var userAlignment = Alignment.leading
    @State private var defaultAlignment = Alignment.leading

    var body: some View {
        NavigationStack {
            ScrollView {
                TimingCurveView(startPoint: userStartPoint, endPoint: userEndPoint)
                AnimationChartView(startPoint: userStartPoint, endPoint: userEndPoint)
                    .overlay(
                        GeometryReader { proxy in
                            AdjustmentGrabHandleView(point: $userStartPoint, color: .pink, proxy: proxy)
                            AdjustmentGrabHandleView(point: $userEndPoint, color: .blue, proxy: proxy)
                        }
                    )
                    .padding(.vertical)

                HStack {
                    LabeledContent("Duration") {
                        Slider(value: $duration, in: 0.1...9.99)
                    }

                    Text("\(duration.dp(2))s")
                        .monospaced()

                    Button("Go", action: runAnimation)
                        .buttonStyle(.borderedProminent)
                }

                AnimationSampleView(color: .pink, alignment: userAlignment, startPoint: userStartPoint, endPoint: userEndPoint)
                AnimationSampleView(color: .blue, alignment: defaultAlignment, startPoint: defaultStartPoint, endPoint: defaultEndPoint)
            }
            .padding(.horizontal)
            .navigationTitle("Animation Explorer")
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    func runAnimation() {
        withAnimation(.timingCurve(userStartPoint.x, 1 - userStartPoint.y, userEndPoint.x, 1 - userEndPoint.y, duration: duration)) {
            userAlignment.flip()
        }

        withAnimation(.timingCurve(defaultStartPoint.x, 1 - defaultStartPoint.y, defaultEndPoint.x, 1 - defaultEndPoint.y, duration: duration)) {
            defaultAlignment.flip()
        }
    }
}

#Preview {
    ContentView()
}
