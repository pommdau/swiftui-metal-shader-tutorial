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
            HoverLocationSample()
            
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

struct HoverLocationSample: View {
    
    @State private var hoverLocation: CGPoint = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.black)
            .frame(width: 100, height: 100)
            .layerEffect(
                ShaderLibrary.default.hoverLocationSample(
                    .boundingRect,
                    .float2(hoverLocation)
                ),
                maxSampleOffset: .zero
            )
//            .onContinuousHover { phase in
//                switch phase {
//                case .active(let location):
//                    hoverLocation = location
//                case .ended:
//                    break
//                }
//            }
            .gesture(
                DragGesture(coordinateSpace: .local).onChanged { value in
                    hoverLocation = value.location
                }.onEnded { value in
                    print(value.location)
                    hoverLocation = value.location
                }
            )
    }
}



#Preview {
    ArgumentSampleView()
}
