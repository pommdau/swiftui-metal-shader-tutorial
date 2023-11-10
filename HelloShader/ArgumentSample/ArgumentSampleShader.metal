//
//  ArgumentSampleShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/10.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;


[[ stitchable ]] half4 timeSample
(
 float2 position,
 SwiftUI::Layer layer,
 float secs
 ) {
    float r = abs(sin(secs * 1.0));
    float g = abs(cos(secs * 1.3));
    float b = abs(tan(secs * 1.5));
    return half4(r, g, b, 1.0);
}

half3 disk(float2 r, float2 center, float radius, half3 fillColor, half3 backgroundColor) {
    if( length(r-center) < radius) {
        return fillColor;
    }
    return backgroundColor;
}

[[ stitchable ]] half4 draggingLocationSample
(
 float2 _position,
 SwiftUI::Layer layer,
 float4 bounds, // x,y,z,w = (x, y, width, height)
 float2 _draggingLocation
 ) {
    // 中心を原点とする正規化
    float2 position = float2(_position.x, bounds.w - _position.y);
    float2 draggingLocation = float2(_draggingLocation.x, bounds.w - _draggingLocation.y);
    float2 uv =  2.0 * float2(position.xy - 0.5 * bounds.zw ) / bounds.w;
    float2 uv_draggingLocation =  2.0 * float2(draggingLocation.xy - 0.5 * bounds.zw ) / bounds.w;
    
    half3 backgroundColor = half3(0.3);
    half3 yellow = half3(1.00, 0.329, 0.298);
    half3 pixel = disk(uv, uv_draggingLocation, 0.5, yellow, backgroundColor);
    
    return half4(pixel, 1.0);
}
