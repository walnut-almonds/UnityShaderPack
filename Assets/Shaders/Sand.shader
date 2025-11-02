Shader "Custom/Sand"
{
    Properties
    {
        _Color ("Base Color", Color) = (0.76, 0.69, 0.5, 1)
        _Roughness ("Roughness", Range(0,1)) = 0.85
        _GrainScale ("Grain Scale", Range(1, 200)) = 60
        _GrainIntensity ("Grain Intensity", Range(0,1)) = 0.3
        _NormalStrength ("Normal Strength", Range(0,3)) = 0.6
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 300

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows addshadow
        #pragma target 3.0

        sampler2D _CameraDepthTexture; // ensure inclusion if needed

        struct Input
        {
            float3 worldPos;
            float3 viewDir;
        };

        fixed4 _Color;
        half _Roughness;
        half _GrainScale;
        half _GrainIntensity;
        half _NormalStrength;

        // Hash-based value noise
        float hash(float3 p)
        {
            p = frac(p * 0.3183099 + 0.1);
            p *= 17.0;
            return frac(p.x * p.y * p.z * (p.x + p.y + p.z));
        }

        float noise(float3 p)
        {
            float3 i = floor(p);
            float3 f = frac(p);
            f = f * f * (3.0 - 2.0 * f);
            float n000 = hash(i + float3(0,0,0));
            float n100 = hash(i + float3(1,0,0));
            float n010 = hash(i + float3(0,1,0));
            float n110 = hash(i + float3(1,1,0));
            float n001 = hash(i + float3(0,0,1));
            float n101 = hash(i + float3(1,0,1));
            float n011 = hash(i + float3(0,1,1));
            float n111 = hash(i + float3(1,1,1));
            float n00 = lerp(n000, n100, f.x);
            float n10 = lerp(n010, n110, f.x);
            float n01 = lerp(n001, n101, f.x);
            float n11 = lerp(n011, n111, f.x);
            float n0 = lerp(n00, n10, f.y);
            float n1 = lerp(n01, n11, f.y);
            return lerp(n0, n1, f.z);
        }

        float fbm(float3 p)
        {
            float sum = 0.0;
            float amp = 0.5;
            float freq = 1.0;
            [unroll(5)]
            for (int i = 0; i < 5; i++)
            {
                sum += amp * noise(p * freq);
                freq *= 2.02;
                amp *= 0.5;
            }
            return sum;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Procedural grain based on world position
            float3 p = IN.worldPos * (_GrainScale * 0.01);
            float g = fbm(p);
            float grain = saturate(g * 2.0 - 0.8);

            // Albedo variation resembling sand granules
            float3 baseCol = _Color.rgb;
            float3 lightCol = baseCol * 1.1;
            float3 darkCol  = baseCol * 0.85;
            float3 albedo = lerp(darkCol, lightCol, grain);
            albedo = lerp(baseCol, albedo, _GrainIntensity);

            // Fake micro normal from noise gradient
            float eps = 0.02;
            float gx = fbm(p + float3(eps,0,0)) - fbm(p - float3(eps,0,0));
            float gz = fbm(p + float3(0,0,eps)) - fbm(p - float3(0,0,eps));
            float3 n = normalize(float3(-gx, 1, -gz));
            n = normalize(lerp(float3(0,1,0), n, _NormalStrength));
            o.Normal = n;

            o.Albedo = albedo;
            o.Metallic = 0.0;
            o.Smoothness = saturate(1.0 - _Roughness);
            o.Occlusion = 1.0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
