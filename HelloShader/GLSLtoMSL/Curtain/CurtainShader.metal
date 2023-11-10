//
//  CurtainShader.metal
//  ShaderDemo3
//
//  Created by HIROKI IKEUCHI on 2023/11/05.
//
//  refs: https://www.shadertoy.com/view/ssByDV
//  refs: https://twitter.com/DLX/status/1715025912238842263

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_texture>
using namespace metal;

#define NUM_PLEATS 20.0
#define MAX_SHADOW 0.3
#define PLEAT_HEIGHT 4.0 // pixel wave amplitude
#define GRAB_AMOUNT 0.5
#define TAU 6.2831852

template<typename Txy, typename Ta>
inline Txy mix(Txy x, Txy y, Ta a)
{
    return x + (y - x) * a;
}

[[ stitchable ]] half4 curtain
(
 float2 _position,
 SwiftUI::Layer layer,
 float4 bounds, // x,y,z,w = (x, y, width, height)
 float2 _mouseCursor // iMouse.xyに相当
 ) {
    half4 fragColor = layer.sample(_position);
    float2 position = float2(_position.x, bounds.w - _position.y);
    float2 mouseCursor = float2(_mouseCursor.x, bounds.w - _mouseCursor.y);
    
    float2 uv = position/bounds.zw;
    float2 grabPos = mouseCursor.xy / bounds.zw;
    
    //move left and right
    uv.x = (uv.x - grabPos.x) / (1.0 - grabPos.x);
    
    //grab distance offset
    uv.x += abs(uv.y - grabPos.y) * (1.0 - uv.x) * GRAB_AMOUNT * grabPos.x;
    
    //pleats
    float pleatZ = (cos(uv.x * TAU * NUM_PLEATS) + 1.0) / 2.0;
    
    //pleat position offset
    uv.y += pleatZ * PLEAT_HEIGHT * grabPos.x / bounds.w;
    
    //no texture hit
    if (any(uv < float2(0.0)) || any(uv > float2(1.0))) {
        fragColor = half4(half3(0.0), 0.0);
        return fragColor;
    }
    
    //pleat shadow
    half3 shadow = half3(pleatZ * MAX_SHADOW * clamp(grabPos.x * 2.0, 0.0, 1.0));
    shadow = mix(shadow, half3(MAX_SHADOW), grabPos.x); //fade to solid colour to hide aliasing

    fragColor = layer.sample(float2(bounds.z * uv.x, bounds.w * (1.0 - uv.y))) - half4(shadow, 0.0);
    return fragColor;
}
