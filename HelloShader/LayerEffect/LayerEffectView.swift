//
//  LayerEffectView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

import SwiftUI

struct LayerEffectView: View {
    var body: some View {
        HStack {
            Image(.xcode)
                .resizable()
                .frame(width: 100, height: 100)
                .layerEffect(
                    ShaderLibrary.default.monochromeWithLayerEffect(),
                    maxSampleOffset: .zero
                )
            
            ZStack {
                Color.yellow.opacity(0.4)
                Rectangle()
                    .stroke(lineWidth: 1)
                    .frame(width: 100, height: 100)
                    .zIndex(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .frame(width: 100, height: 100)
                    .padding(.horizontal, 10)
                    .drawingGroup()
                    .layerEffect(
                        ShaderLibrary.default.shiftToLeftWithLayerEffect(),
                        maxSampleOffset: .init(width: 10, height: 0)
                    )
            }
            .frame(width: 150, height: 150)
        }
    }
}

#Preview {
    LayerEffectView()
}
