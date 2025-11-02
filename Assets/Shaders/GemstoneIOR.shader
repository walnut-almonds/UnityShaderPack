Shader "Custom/GemstoneIOR"
{
    Properties
    {
        _TintColor ("Tint", Color) = (0.8, 0.95, 1, 0.5)
        _IOR ("Index Of Refraction", Range(1.1, 2.6)) = 2.2
        _Dispersion ("Dispersion", Range(0, 0.2)) = 0.03
        _RefractionStrength ("Refraction Strength", Range(0, 1)) = 0.35
        _Alpha ("Base Alpha", Range(0,1)) = 0.25
        _Smoothness ("Smoothness", Range(0,1)) = 0.98
        _FresnelPower ("Fresnel Power", Range(0.5,8)) = 5
        _Absorption ("Absorption", Color) = (0.95, 0.98, 1, 1)
        _AbsorbPower ("Absorption Power", Range(0,4)) = 1.0
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" "IgnoreProjector" = "True" }
        LOD 450
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
        half _Dispersion;
        half _RefractionStrength;
        half _Alpha;
        half _Smoothness;
        half _FresnelPower;
        fixed4 _Absorption;
        half _AbsorbPower;
        sampler2D _GrabTexture;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float3 n = normalize(WorldNormalVector(IN, float3(0,0,1)));
            float3 v = normalize(IN.viewDir);

            float fres = pow(1.0 - saturate(dot(n, v)), _FresnelPower);

            // Chromatic dispersion: different IOR per channel
            float etaG = 1.0 / max(_IOR, 1e-3);
            float etaR = 1.0 / max(_IOR + _Dispersion, 1e-3);
            float etaB = 1.0 / max(_IOR - _Dispersion, 1e-3);

            float3 rdirR = refract(-v, n, etaR);
            float3 rdirG = refract(-v, n, etaG);
            float3 rdirB = refract(-v, n, etaB);

            float4 sp = IN.screenPos;

            float4 spR = sp; spR.xy += rdirR.xy * _RefractionStrength * spR.w;
            float4 spG = sp; spG.xy += rdirG.xy * _RefractionStrength * spG.w;
            float4 spB = sp; spB.xy += rdirB.xy * _RefractionStrength * spB.w;

            fixed3 colR = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(spR)).rgb;
            fixed3 colG = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(spG)).rgb;
            fixed3 colB = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(spB)).rgb;

            fixed3 dispCol = fixed3(colR.r, colG.g, colB.b);

            // Simple absorption based on angle (proxy for thickness)
            float thickness = pow(saturate(1.0 - abs(dot(n, v))), 1.0) + 0.2; // 0.2 minimum
            fixed3 absorption = pow(_Absorption.rgb, thickness * _AbsorbPower);

            fixed3 refrCol = dispCol * _TintColor.rgb * absorption;

            o.Albedo = 0;
            o.Metallic = 0;
            o.Smoothness = _Smoothness;
            o.Emission = refrCol;
            o.Alpha = saturate(_Alpha + fres * (1.0 - _Alpha)) * _TintColor.a;
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
