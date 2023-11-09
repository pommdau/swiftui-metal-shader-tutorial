//
//  DistortionEffectShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/07.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 shiftToLeft
(
 float2 position // 現在のピクセル位置
 ) {
    return float2(position.x + 10, position.y);
}
