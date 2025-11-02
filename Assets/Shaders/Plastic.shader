Shader "Custom/Plastic"
{
    Properties
    {
        _Color ("Color", Color) = (0.2, 0.6, 0.9, 1)
        _Smoothness ("Smoothness", Range(0,1)) = 0.6
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 250
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows addshadow
        #pragma target 3.0

        struct Input { float3 worldPos; };

        fixed4 _Color;
        half _Smoothness;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            o.Metallic = 0.0;
            o.Smoothness = _Smoothness;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
    FallBack "Standard"
}
