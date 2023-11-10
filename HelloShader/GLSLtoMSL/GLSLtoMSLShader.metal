//
//  GLSLtoMSLShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 aqua
(
 float2 position,
 SwiftUI::Layer layer
 ) {
    // Here we are seperating the color and transparency parts
    // of the vec4 that represents the pixels.
    float3 color = float3(0.0, 1.0, 1.0);
    float alpha = 1.0;
    
    float4 pixel = float4(color, alpha);
    return half4(pixel);
}
