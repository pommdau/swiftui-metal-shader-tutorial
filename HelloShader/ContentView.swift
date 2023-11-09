//
//  ContentView.swift
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/06.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("ColorEffect")
            ColorEffectView()
        }
        VStack(alignment: .leading) {
            Text("DistortionEffect")
            DistortionEffectView()
        }
        
        LayerEffectView()
    }
}


#Preview {
    ContentView()
}
