Shader "Custom/Emissive"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (0, 0, 0, 1)
        _EmissionColor ("Emission Color", Color) = (1, 0.8, 0.6, 1)
        _EmissionIntensity ("Emission Intensity", Range(0,50)) = 5
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows addshadow
        #pragma target 3.0

        struct Input { float3 worldPos; };

        fixed4 _BaseColor;
        fixed4 _EmissionColor;
        half _EmissionIntensity;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _BaseColor.rgb;
            o.Metallic = 0.0;
            o.Smoothness = 0.1;
            o.Emission = _EmissionColor.rgb * _EmissionIntensity;
        }
        ENDCG
    }
    FallBack "Standard"
}
