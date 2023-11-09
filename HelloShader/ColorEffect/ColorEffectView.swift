//
//  ColorEffectView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/06.
//

import SwiftUI

struct ColorEffectView: View {
    var body: some View {
        HStack(spacing: 10) {
            Rectangle()
                .frame(width: 100, height: 100)
                .colorEffect(
                    ShaderLibrary.default.fillColor(.color(Color.blue))
                )
            
            Image(.xcode)
                .resizable()
                .frame(width: 100, height: 100)
                .colorEffect(
                    ShaderLibrary.default.monochrome()
                )
        }
    }
}

#Preview {
    ColorEffectView()
}
