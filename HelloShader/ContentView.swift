//
//  ContentView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/06.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        tutorialView()
//        CurtainView()
//        PageCurlView()
    }
    
    @ViewBuilder
    private func tutorialView() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("ColorEffect")
                    ColorEffectView()
                }
                VStack(alignment: .leading) {
                    Text("DistortionEffect")
                    DistortionEffectView()
                }
                
                VStack(alignment: .leading) {
                    Text("LayerEffect")
                    LayerEffectView()
                }
                
                VStack(alignment: .leading) {
                    Text("ArgumentSample")
                    ArgumentSampleView()
                }
                
                VStack(alignment: .leading) {
                    Text("GLSLtoMSL")
                    GLSLtoMSLView()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
