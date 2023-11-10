//
//  GLSLtoMSLView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//

import SwiftUI

struct GLSLtoMSLView: View {
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .layerEffect(
                ShaderLibrary.default.aqua(),
                maxSampleOffset: .zero
            )
    }
}

#Preview {
    GLSLtoMSLView()
}
