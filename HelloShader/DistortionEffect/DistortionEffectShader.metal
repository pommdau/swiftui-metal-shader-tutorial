//
//  DistortionEffectShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 shift
(
 float2 position
// float2 offset
 ) {
    return float2(position.x + 10, position.y + 10);
}


[[ stitchable ]] float2 horizontalSwap
(
 float2 position,
 float4 bounds
 ) {
    float halfWidth = bounds.z / 2;
    if (position.x <= halfWidth) {
        return float2(position.x + halfWidth, position.y);
    } else {
        return float2(position.x - halfWidth, position.y);
    }
}
