Shader "Custom/GlassRefraction"
{
    Properties
    {
        _TintColor ("Tint", Color) = (0.9, 0.97, 1, 0.3)
        _IOR ("Index Of Refraction", Range(1.0, 2.5)) = 1.5
        _RefractionStrength ("Refraction Strength", Range(0, 1)) = 0.25
        _Alpha ("Base Alpha", Range(0,1)) = 0.2
        _Smoothness ("Smoothness", Range(0,1)) = 0.95
        _FresnelPower ("Fresnel Power", Range(0.5,8)) = 5
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" "IgnoreProjector" = "True" }
        LOD 400
        GrabPass { }

        CGPROGRAM
        #pragma surface surf Standard alpha:premul keepalpha fullforwardshadows
        #pragma target 3.0
        #include "UnityCG.cginc"

        struct Input
        {
            float4 screenPos;
            float3 viewDir;
            INTERNAL_DATA
        };

        fixed4 _TintColor;
        half _IOR;
        half _RefractionStrength;
        half _Alpha;
        half _Smoothness;
        half _FresnelPower;
        sampler2D _GrabTexture;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Normal in world space
            float3 n = normalize(WorldNormalVector(IN, float3(0,0,1)));
            float3 v = normalize(IN.viewDir);

            // Fresnel term
            float fres = pow(1.0 - saturate(dot(n, v)), _FresnelPower);
            // Refract view vector using approximate screen-space refraction
            float eta = 1.0 / max(_IOR, 1e-3);
            float3 rdir = refract(-v, n, eta);

            float4 sp = IN.screenPos;
            // Projective sample with offset from refracted direction
            float2 offset = rdir.xy * _RefractionStrength;
            sp.xy += offset * sp.w; // adjust in clip space

            fixed4 refrCol = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(sp));
            refrCol.rgb *= _TintColor.rgb;

            // Base lighting mostly from specular, minimal albedo
            o.Albedo = 0; // glass has almost no albedo
            o.Metallic = 0;
            o.Smoothness = _Smoothness;
            // Put refraction into emission to display behind objects
            o.Emission = refrCol.rgb;
            // Alpha with fresnel: more opaque on edges
            o.Alpha = saturate(_Alpha + fres * (1.0 - _Alpha)) * _TintColor.a;
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
