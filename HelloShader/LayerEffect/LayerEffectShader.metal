//
//  LayerEffectShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 monochromeWithLayerEffect
(
 float2 position,
 SwiftUI::Layer layer
 ) {
    half4 color = layer.sample(position);
    half v = (color.r + color.g + color.b) / 3.0;
    return half4(v, v, v, 1.0);
}

[[ stitchable ]] half4 shiftWithLayerEffect
(
 float2 position,
 SwiftUI::Layer layer
 ) {
    float2 newPosition = float2(position.x - 10, position.y + 10);
    half4 color = layer.sample(newPosition);
    return color;
}
