//
//  ArgumentSampleView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//

import SwiftUI

struct ArgumentSampleView: View {
    var body: some View {
        HStack {
            DragGestureSample()
            TimeSampleView()
        }
    }
}

struct TimeSampleView: View {
    
    private let startDate = Date()
    
    var body: some View {
        TimelineView(.animation) { context in
            let elapsedTime = context.date.timeIntervalSince1970 - self.startDate.timeIntervalSince1970
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.black)
                .frame(width: 100, height: 100)
                .layerEffect(
                    ShaderLibrary.default.timeSample(
                        .float(elapsedTime)
                    ),
                    maxSampleOffset: .zero
                )
        }
    }
}

struct DragGestureSample: View {
    
    @State private var draggingLocation: CGPoint = .init(x: 50, y: 50)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.black)
            .frame(width: 100, height: 100)
            .layerEffect(
                ShaderLibrary.default.draggingLocationSample(
                    .boundingRect,
                    .float2(draggingLocation)
                ),
                maxSampleOffset: .zero
            )
            .gesture(
                DragGesture(coordinateSpace: .local).onChanged { value in
                    draggingLocation = value.location
                }.onEnded { value in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        draggingLocation = .init(x: 50, y: 50)
                    }
                }
            )
    }
}

#Preview {
    ArgumentSampleView()
}
