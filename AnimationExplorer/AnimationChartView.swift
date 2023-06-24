//
//  AnimationChartView.swift
//  AnimationExplorer
//
//  Created by Philipp on 24.06.23.
//

import Charts
import SwiftUI

struct AnimationChartView: View {
    @Environment(\.colorScheme) private var colorScheme

    var startPoint: CGPoint
    var endPoint: CGPoint
    var forThumbnail: Bool

    var curve: UnitCurve

    init(startPoint: CGPoint, endPoint: CGPoint, forThumbnail: Bool = false) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.forThumbnail = forThumbnail

        let start = UnitPoint(x: startPoint.x, y: 1 - startPoint.y)
        let end = UnitPoint(x: endPoint.x, y: 1 - endPoint.y)

        curve = UnitCurve.bezier(startControlPoint: start, endControlPoint: end)
    }

    var body: some View {
        Chart {
            Plot {
                ForEach(0...100, id: \.self) { point in
                    let time = Double(point) / 100
                    let value = curve.value(at: time)

                    LineMark(
                        x: .value("x", time),
                        y: .value("y", value)
                    )
                    .lineStyle(StrokeStyle(lineWidth: forThumbnail ? 3 : 5))
                    .foregroundStyle(forThumbnail ? .white : .primary)
                }

                if forThumbnail == false {
                    addGrabberLines()
                }
            }
        }
        .chartXAxis {
            if forThumbnail == false {
                AxisMarks(values: .automatic(desiredCount: 10)) {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1))
                }
            }
        }
        .chartYAxis {
            if forThumbnail == false {
                AxisMarks(values: .automatic(desiredCount: 10)) {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1))
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }

    @ChartContentBuilder
    func addGrabberLines() -> some ChartContent {
        LineMark(
            x: .value("x", 0),
            y: .value("y", 0),
            series: .value("Handle", "Start")
        )
        .lineStyle(StrokeStyle(lineWidth: 5))
        .foregroundStyle(.secondary)

        LineMark(
            x: .value("x", Double(startPoint.x)),
            y: .value("y", 1 - Double(startPoint.y)),
            series: .value("Handle", "Start")
        )
        .lineStyle(StrokeStyle(lineWidth: 5))
        .foregroundStyle(.secondary)

        LineMark(
            x: .value("x", 1),
            y: .value("y", 1),
            series: .value("Handle", "End")
        )
        .lineStyle(StrokeStyle(lineWidth: 5))
        .foregroundStyle(.secondary)

        LineMark(
            x: .value("x", Double(endPoint.x)),
            y: .value("y", 1 - Double(endPoint.y)),
            series: .value("Handle", "End")
        )
        .lineStyle(StrokeStyle(lineWidth: 5))
        .foregroundStyle(.secondary)
    }
}

#Preview {
    AnimationChartView(startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
}
