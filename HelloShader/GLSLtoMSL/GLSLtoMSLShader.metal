//
//  GLSLtoMSLShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//
//  refs: https://www.shadertoy.com/view/Md23DV

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// Tutorial 3
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

[[ stitchable ]] half4 tutorial7
(
 float2 position,
 SwiftUI::Layer layer,
 float4 bounds // x,y,z,w = (x, y, width, height)
 ) {
    // (0, 0) ~ (1, 1)に座標を正規化
    float2 fragCoord = position;
    float2 r = float2(fragCoord.x / bounds.z,
                      fragCoord.y / bounds.w);
    
    float3 color1 = float3(0.841, 0.582, 0.594);
    float3 color2 = float3(0.884, 0.850, 0.648);
    float3 color3 = float3(0.348, 0.555, 0.641);
    float3 pixel;
        
    if( r.y < 1.0/3.0) {
        pixel = color1;
    } else if( r.y < 2.0/3.0 ) {
        pixel = color2;
    } else {
        pixel = color3;
    }
            
    return half4(half3(pixel), 1.0);
}
