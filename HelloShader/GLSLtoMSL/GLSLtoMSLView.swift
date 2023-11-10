//
//  GLSLtoMSLView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//

import SwiftUI

struct GLSLtoMSLView: View {
    var body: some View {
        
        HStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .layerEffect(
                    ShaderLibrary.default.aqua(),
                    maxSampleOffset: .zero
                )
            
            Rectangle()
                .frame(width: 100, height: 100)
                .layerEffect(
                    ShaderLibrary.default.tutorial7(.boundingRect),
                    maxSampleOffset: .zero
                )
        }
    }
}

#Preview {
    GLSLtoMSLView()
}
