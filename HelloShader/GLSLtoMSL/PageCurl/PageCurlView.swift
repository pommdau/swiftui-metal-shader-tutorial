//
//  Home2.swift
//  ShaderDemo3
//
//  Created by HIROKI IKEUCHI on 2023/10/17.
//

import SwiftUI

let imageSize = CGSize(width: 400, height: 400)

struct PageCurlView: View {
    @State private var hoverLocation: CGPoint = .init(x: imageSize.width, y: imageSize.height / 2)
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.1)

            cardImage()
                .foregroundStyle(.black)
                .opacity(1.0)
                .frame(width: imageSize.width, height: imageSize.height)
                .pageCurlShader(hoverLocation: hoverLocation)
                .gesture(
                    DragGesture(coordinateSpace: .local).onChanged { value in
                        hoverLocation = value.location
                    }.onEnded { value in
                        withAnimation(.easeInOut(duration: 0.4)) {
                            hoverLocation = .init(x: imageSize.width, y: imageSize.height / 2)
                        }
                    }
                )
        }
        .frame(width: 500, height: 500)
        .padding()
    }
    
    @ViewBuilder
    private func cardImage() -> some View {
        Image(.sample)
            .resizable()
            .scaledToFill()
    }
}

extension View {
    func pageCurlShader(hoverLocation: CGPoint, isEnabled: Bool = true) -> some View {
        self.layerEffect(
            ShaderLibrary.default.pageCurl(
                .boundingRect,
                .float2(imageSize.width - imageSize.width / 10, imageSize.height / 2),  // TODO 調整！
                .float2(hoverLocation.x,
                        hoverLocation.y),
                .image(Image(.sample))
            ),
            maxSampleOffset: .init(width: 800, height: 800),
            isEnabled: isEnabled
        )
    }
}

#Preview("Home2") {
    PageCurlView()
}
