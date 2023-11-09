//
//  ColorEffectShader.metal
//  HelloShader
//
//  Created by HIROKI IKEUCHI on 2023/11/06.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 fillColor
(
 float2 position, // 現在のピクセルの位置(デフォルトで与えられる)
 half4 color, // 現在のピクセルの色(デフォルトで与えられる)
 half4 newColor
 ) {
    return newColor; // r, g, b, a
}

[[ stitchable ]] half4 monochrome
(
 float2 position,
 half4 color
 ) {
    half v = (color.r + color.g + color.b) / 3.0;
    return half4(v, v, v, 1.0);
}
