//
//  CurtainView.swift
//  ShaderDemo3
//
//  Created by HIROKI IKEUCHI on 2023/11/05.
//

import SwiftUI

struct CurtainView: View {
    
    @State private var showingSheet = true
    @State private var hoverLocation: CGPoint = .zero
    
    var body: some View {
        VStack {
            Text("Shader Practice")
            Button("Open sheet") {
                showingSheet = true
            }
        }
        .fullScreenCover(isPresented: $showingSheet) {
            GeometryReader { proxy in
                fullScreenContents()
                    .presentationBackground(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layerEffect(
                        ShaderLibrary.default.curtain(
                            .boundingRect,
                            .float2(hoverLocation.x, hoverLocation.y)
                        ),
                        maxSampleOffset: .init(width: 2000, height: 2000),
                        isEnabled: true
                    )
                    .ignoresSafeArea()
                    .gesture(
                        DragGesture().onChanged { value in
                            hoverLocation = value.location
                        }.onEnded { value in
                            let hoverLocationRatio = CGPoint(x: value.location.x / proxy.size.width,
                                                             y: value.location.y / proxy.size.height)
                            if hoverLocationRatio.x > 0.7 {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    hoverLocation = CGPoint(x: proxy.size.width * 0.95, y: proxy.size.height * 0.5)
                                }
                            } else {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    hoverLocation = .zero
                                }
                            }
                        }
                    )
            }
        }
    }
    
    @ViewBuilder
    private func fullScreenContents() -> some View {
        ZStack {
            Color.blue
            VStack {
                Image(.sample)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .foregroundStyle(.secondary)
                    .padding()
                Button("Close") {
                    showingSheet = false
                }
                .tint(.white)
            }
        }
    }
    
}

#Preview {
    CurtainView()
}
