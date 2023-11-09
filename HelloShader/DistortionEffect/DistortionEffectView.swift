//
//  DistortionEffectView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

import SwiftUI

struct DistortionEffectView: View {
    
    @State var isEnabled = false
    
    var body: some View {
        
        HStack {
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
                    .distortionEffect(
                        ShaderLibrary.default.shiftToLeft(),
                        maxSampleOffset: .init(width: 10, height: 0)
                    )
            }
            .frame(width: 150, height: 150)
        }
        
    }
}


#Preview {
    DistortionEffectView()
}
