//
//  DistortionEffectView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

import SwiftUI

struct DistortionEffectView: View {
    var body: some View {   
        
        HStack {
                        
            ZStack {
                Color.yellow.opacity(0.4)
                Rectangle()
                    .stroke(lineWidth: 1)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundStyle(.blue)
                    .frame(width: 100, height: 100)
                    .distortionEffect(
                        ShaderLibrary.default.shift(),
                        maxSampleOffset: .zero
                    )
            }
            .frame(width: 150, height: 150)
            
            Image(.xcode)
                .resizable()
                .frame(width: 100, height: 100)
                .distortionEffect(
                    ShaderLibrary.default.horizontalSwap(.boundingRect),
                    maxSampleOffset: .zero
                )
        }
    }
}


#Preview {
    DistortionEffectView()
}
