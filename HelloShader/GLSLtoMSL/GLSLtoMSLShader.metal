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
    vec3 color = vec3(0.0, 1.0, 1.0);
    float alpha = 1.0;
    
    vec4 pixel = vec4(color, alpha);
    fragColor = pixel;
}
