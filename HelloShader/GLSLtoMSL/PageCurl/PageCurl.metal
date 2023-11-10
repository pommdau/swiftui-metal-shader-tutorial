//
//  PageCurl.metal
//  ShaderDemo3
//
//  Created by HIROKI IKEUCHI on 2023/10/17.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

#define pi float(3.14159265359)
#define blue half4(0.0, 0.0, 1.0, 1.0)
#define radius float(0.1)

// そのピクセルの色を返す
[[ stitchable ]] half4 pageCurl
(
 float2 _position,
 SwiftUI::Layer layer,
 float4 bounds,
 float2 _clickedPoint, // iMouse.zwに相当
 float2 _mouseCursor, // iMouse.xyに相当
 texture2d<half> image0
 ) {
    // y座標の補正
    float2 position = float2(_position.x, bounds.w - _position.y);
    float2 clickedPoint = float2(_clickedPoint.x, bounds.w - _clickedPoint.y);
    float2 mouseCursor = float2(_mouseCursor.x, bounds.w - _mouseCursor.y);
    
    float aspect = bounds.z / bounds.w;
    
    float2 uv = position * float2(aspect, 1.) / bounds.zw;
    float2 mouse = mouseCursor.xy  * float2(aspect, 1.) / bounds.zw;
    float2 mouseDir = normalize(abs(clickedPoint.xy) - mouseCursor.xy);
    float2 origin = clamp(mouse - mouseDir * mouse.x / mouseDir.x, 0., 1.);
    
    float mouseDist = clamp(length(mouse - origin)
                            + (aspect - (abs(clickedPoint.x) / bounds.z) * aspect) / mouseDir.x, 0., aspect / mouseDir.x);
    
    if (mouseDir.x < 0.)
    {
        mouseDist = distance(mouse, origin);
    }
    
    float proj = dot(uv - origin, mouseDir);
    float dist = proj - mouseDist;
    
    float2 linePoint = uv - dist * mouseDir;
    half4 pixel = layer.sample(position); // black
    
    if (dist > radius)
    {
//        pixel = texture(iChannel1, uv * float2(1. / aspect, 1.));
        pixel = half4(1.0, 1.0, 0.0, 1.0);
        pixel.rgb *= pow(clamp(dist - radius, 0., 1.) * 1.5, .2);
    }
    else if (dist >= 0.)
    {
        // map to cylinder point
        float theta = asin(dist / radius);
        float2 p2 = linePoint + mouseDir * (pi - theta) * radius;
        float2 p1 = linePoint + mouseDir * theta * radius;
                
        uv = (p2.x <= aspect && p2.y <= 1. && p2.x > 0. && p2.y > 0.) ? p2 : p1;
//        pixel = texture(iChannel0, uv * float2(1. / aspect, 1.));
        uv = float2(uv.x, 1.0 - uv.y); // y座標の補正
        pixel = image0.sample(metal::sampler(metal::filter::linear), uv * float2(1. / aspect, 1.));

        pixel.rgb *= pow(clamp((radius - dist) / radius, 0., 1.), .2);
    }
    else
    {
        float2 p = linePoint + mouseDir * (abs(dist) + pi * radius);
        uv = (p.x <= aspect && p.y <= 1. && p.x > 0. && p.y > 0.) ? p : uv;
//        pixel = texture(iChannel0, uv * float2(1. / aspect, 1.));
        uv = float2(uv.x, 1.0 - uv.y); // y座標の補正
        pixel = image0.sample(metal::sampler(metal::filter::linear), uv * float2(1. / aspect, 1.));
    }
    
    return pixel;
}
