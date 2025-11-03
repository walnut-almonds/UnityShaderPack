Shader "Custom/CelShaded_Advanced"
{
    Properties
    {
        // ==================== 基本設定 ====================
        [Header(Basic Settings)]
        _Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
        [Enum(Off,0,On,1)] _ZWrite ("ZWrite", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 4
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend", Float) = 0
        [Toggle] _AlphaToMask ("Alpha To Coverage", Float) = 0
        
        // ==================== 亮度設定 ====================
        [Header(Brightness Settings)]
        _MaxBrightness ("Max Brightness", Range(0,2)) = 1.0
        _MinBrightness ("Min Brightness", Range(0,2)) = 0.3
        _Saturation ("Saturation", Range(0,2)) = 1.0
        _Desaturation ("Desaturation", Range(0,1)) = 0.0
        _AmbientLightInfluence ("Ambient Light Influence", Range(0,1)) = 0.5
        _LightColorInfluence ("Light Color Influence", Range(0,1)) = 1.0
        _IndirectLightingBoost ("Indirect Lighting Boost", Range(0,2)) = 1.0
        
        // ==================== UV設定 ====================
        [Header(UV Settings)]
        _MainUVScale ("Main UV Scale", Vector) = (1,1,0,0)
        _MainUVOffset ("Main UV Offset", Vector) = (0,0,0,0)
        _MainUVRotation ("Main UV Rotation", Range(0,360)) = 0
        [Toggle] _UseUV2 ("Use UV2", Float) = 0
        
        // ==================== 主要色彩貼圖設定 ====================
        [Header(Main Color Textures)]
        _MainTex ("Main Texture", 2D) = "white" {}
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTexAlpha ("Main Texture Alpha", Range(0,1)) = 1.0
        
        _MainTex2 ("2nd Texture", 2D) = "white" {}
        _Color2 ("2nd Color", Color) = (1,1,1,0)
        _MainTex2Alpha ("2nd Texture Alpha", Range(0,1)) = 0.0
        _MainTex2UVScale ("2nd UV Scale", Vector) = (1,1,0,0)
        _MainTex2UVOffset ("2nd UV Offset", Vector) = (0,0,0,0)
        [Enum(Multiply,0,Add,1,Overlay,2,Screen,3)] _MainTex2BlendMode ("2nd Blend Mode", Float) = 0
        
        _MainTex3 ("3rd Texture", 2D) = "white" {}
        _Color3 ("3rd Color", Color) = (1,1,1,0)
        _MainTex3Alpha ("3rd Texture Alpha", Range(0,1)) = 0.0
        _MainTex3UVScale ("3rd UV Scale", Vector) = (1,1,0,0)
        _MainTex3UVOffset ("3rd UV Offset", Vector) = (0,0,0,0)
        [Enum(Multiply,0,Add,1,Overlay,2,Screen,3)] _MainTex3BlendMode ("3rd Blend Mode", Float) = 0
        
        // ==================== 陰影設定 ====================
        [Header(Shadow Settings)]
        _ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
        _ShadowSharpness ("Shadow Sharpness", Range(0,1)) = 0.5
        _ShadowOffset ("Shadow Offset", Range(-1,1)) = 0.0
        _ShadowStrength ("Shadow Strength", Range(0,1)) = 0.5
        _ShadowSteps ("Shadow Steps", Range(1,10)) = 2
        _ShadowBias ("Shadow Bias", Range(-1,1)) = 0.0
        _IndirectShadowIntensity ("Indirect Shadow Intensity", Range(0,1)) = 0.3
        
        // 多層陰影設定
        _Shadow2ndColor ("2nd Shadow Color", Color) = (0.3,0.3,0.3,1)
        _Shadow2ndThreshold ("2nd Shadow Threshold", Range(0,1)) = 0.3
        _Shadow3rdColor ("3rd Shadow Color", Color) = (0.2,0.2,0.2,1)
        _Shadow3rdThreshold ("3rd Shadow Threshold", Range(0,1)) = 0.15
        
        // ==================== 發光設定 ====================
        [Header(Emission Settings)]
        [HDR] _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _EmissionMap ("Emission Map", 2D) = "white" {}
        _EmissionStrength ("Emission Strength", Range(0,10)) = 1.0
        
        [HDR] _EmissionColor2 ("2nd Emission Color", Color) = (0,0,0,0)
        _EmissionStrength2 ("2nd Emission Strength", Range(0,10)) = 0.0
        
        [HDR] _EmissionColor3 ("3rd Emission Color", Color) = (0,0,0,0)
        _EmissionStrength3 ("3rd Emission Strength", Range(0,10)) = 0.0
        
        [Toggle] _EmissionScrolling ("Enable Emission Scrolling", Float) = 0
        _EmissionScrollSpeed ("Emission Scroll Speed", Vector) = (0,0,0,0)
        
        // ==================== Normal Map ====================
        [Header(Normal Map Settings)]
        [Normal] _BumpMap ("Normal Map", 2D) = "bump" {}
        _BumpScale ("Normal Scale", Range(0,2)) = 1.0
        
        [Normal] _BumpMap2 ("2nd Normal Map", 2D) = "bump" {}
        _BumpScale2 ("2nd Normal Scale", Range(0,2)) = 0.0
        
        // ==================== MatCap ====================
        [Header(MatCap Settings)]
        _MatCap ("MatCap", 2D) = "black" {}
        _MatCapStrength ("MatCap Strength", Range(0,2)) = 0.0
        _MatCapColor ("MatCap Color", Color) = (1,1,1,1)
        [Enum(Multiply,0,Add,1,Overlay,2,Screen,3)] _MatCapBlendMode ("MatCap Blend Mode", Float) = 1
        
        _MatCap2 ("2nd MatCap", 2D) = "black" {}
        _MatCapStrength2 ("2nd MatCap Strength", Range(0,2)) = 0.0
        _MatCapColor2 ("2nd MatCap Color", Color) = (1,1,1,1)
        [Enum(Multiply,0,Add,1,Overlay,2,Screen,3)] _MatCapBlendMode2 ("2nd MatCap Blend Mode", Float) = 1
        
        // ==================== 遮罩貼圖包 (Mask Pack) ====================
        [Header(Mask Textures Pack R G B A)]
        _MaskPack1 ("Mask Pack 1 (R:Specular G:Rim B:MatCap A:Emission)", 2D) = "white" {}
        _MaskPack2 ("Mask Pack 2 (R:Glitter G:Shadow B:Outline A:SSS)", 2D) = "white" {}
        
        // ==================== 光澤設定 ====================
        [Header(Specular Settings)]
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _SpecularGloss ("Specular Gloss", Range(0,1)) = 0.5
        _SpecularStrength ("Specular Strength", Range(0,2)) = 0.5
        _SpecularSharpness ("Specular Sharpness", Range(0,1)) = 0.8
        _SpecularOffset ("Specular Offset", Range(-1,1)) = 0.0
        
        // Anisotropic高光
        [Toggle] _UseAnisotropic ("Use Anisotropic", Float) = 0
        _AnisotropicDirection ("Anisotropic Direction", Range(0,1)) = 0.5
        _AnisotropicStrength ("Anisotropic Strength", Range(0,1)) = 0.5
        
        // ==================== Rim Light ====================
        [Header(Rim Light Settings)]
        [HDR] _RimColor ("Rim Color", Color) = (1,1,1,1)
        _RimPower ("Rim Power", Range(0.1,8)) = 3.0
        _RimStrength ("Rim Strength", Range(0,2)) = 0.5
        _RimOffset ("Rim Offset", Range(-1,1)) = 0.0
        [Toggle] _RimLightingInfluence ("Rim Lighting Influence", Float) = 1
        _RimShadowMask ("Rim Shadow Mask", Range(0,1)) = 0.0
        
        // 第二層Rim Light
        [HDR] _RimColor2 ("2nd Rim Color", Color) = (0,0,0,0)
        _RimPower2 ("2nd Rim Power", Range(0.1,8)) = 5.0
        _RimStrength2 ("2nd Rim Strength", Range(0,2)) = 0.0
        
        // ==================== 亮片設定 ====================
        [Header(Glitter Settings)]
        [HDR] _GlitterColor ("Glitter Color", Color) = (1,1,1,0)
        _GlitterStrength ("Glitter Strength", Range(0,2)) = 0.0
        _GlitterSize ("Glitter Size", Range(0.01,1)) = 0.1
        _GlitterSpeed ("Glitter Speed", Range(0,5)) = 1.0
        _GlitterSharpness ("Glitter Sharpness", Range(0,1)) = 0.9
        _GlitterDensity ("Glitter Density", Range(0,1)) = 0.5
        [Toggle] _GlitterRandomize ("Randomize Glitter", Float) = 1
        
        // ==================== 輪廓線設定 ====================
        [Header(Outline Settings)]
        _OutlineWidth ("Outline Width", Range(0,0.1)) = 0.003
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _OutlineDistanceFade ("Outline Distance Fade", Range(0,1)) = 0.5
        [Toggle] _OutlineVertexColorAsWidth ("Use Vertex Color As Width", Float) = 0
        [Toggle] _OutlineFixedSize ("Fixed Size Outline", Float) = 0
        _OutlineZOffset ("Outline Z Offset", Range(-1,1)) = 0.0
        
        // ==================== 額外高級設定 ====================
        [Header(Advanced Settings)]
        
        // 色調映射
        _HueShift ("Hue Shift", Range(-180,180)) = 0
        _ColorGrading ("Color Grading", Color) = (1,1,1,1)
        
        // 細節貼圖
        _DetailMap ("Detail Map (RGB) Detail Mask (A)", 2D) = "gray" {}
        _DetailStrength ("Detail Strength", Range(0,1)) = 0.0
        
        // 高度圖/視差
        _ParallaxMap ("Height Map", 2D) = "black" {}
        _Parallax ("Parallax Height", Range(0.005, 0.08)) = 0.02
        
        // 環境遮蔽與金屬度粗糙度合併
        _MetallicGlossMap ("Metallic (R) Roughness (G) AO (B)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Roughness ("Roughness", Range(0,1)) = 0.5
        _OcclusionStrength ("Occlusion Strength", Range(0,1)) = 1.0
        
        // 子表面散射
        [Toggle] _UseSSS ("Use Subsurface Scattering", Float) = 0
        _SSSColor ("SSS Color", Color) = (1,0.5,0.5,1)
        _SSSStrength ("SSS Strength", Range(0,1)) = 0.5
        _SSSDistortion ("SSS Distortion", Range(0,1)) = 0.5
        _SSSPower ("SSS Power", Range(0.1,10)) = 3.0
        _SSSScale ("SSS Scale", Range(0,10)) = 1.0
        
        // 溶解效果
        [Toggle] _UseDissolve ("Use Dissolve", Float) = 0
        _DissolveMap ("Dissolve Map", 2D) = "white" {}
        _DissolveAmount ("Dissolve Amount", Range(0,1)) = 0.0
        [HDR] _DissolveEdgeColor ("Dissolve Edge Color", Color) = (1,0.5,0,1)
        _DissolveEdgeWidth ("Dissolve Edge Width", Range(0,0.5)) = 0.1
        
        // 頂點動畫
        [Toggle] _UseVertexAnimation ("Use Vertex Animation", Float) = 0
        _VertexAnimSpeed ("Vertex Anim Speed", Range(0,10)) = 1.0
        _VertexAnimStrength ("Vertex Anim Strength", Range(0,1)) = 0.1
        
        // Fur/Grass效果
        [Toggle] _UseFur ("Use Fur Effect", Float) = 0
        _FurLength ("Fur Length", Range(0,0.1)) = 0.01
        _FurDensity ("Fur Density", Range(0,1)) = 0.5
        
        // 邊緣光暈
        _FresnelPower ("Fresnel Power", Range(0,10)) = 5.0
        _FresnelIntensity ("Fresnel Intensity", Range(0,2)) = 0.0
        [HDR] _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
        
        // 風格化選項
        [Toggle] _UseHalftone ("Use Halftone", Float) = 0
        _HalftoneScale ("Halftone Scale", Range(1,100)) = 10
        _HalftoneStrength ("Halftone Strength", Range(0,1)) = 0.5
        
        [Toggle] _UseCrosshatch ("Use Crosshatch", Float) = 0
        _CrosshatchScale ("Crosshatch Scale", Range(1,100)) = 20
        _CrosshatchStrength ("Crosshatch Strength", Range(0,1)) = 0.5
        
        // 光照模型選擇
        [Enum(Toon,0,Realistic,1,Stylized,2,Custom,3)] _LightingModel ("Lighting Model", Float) = 0
        
        // Stencil設定
        [Header(Stencil Settings)]
        _StencilRef ("Stencil Reference", Range(0,255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Range(0,255)) = 255
        _StencilReadMask ("Stencil Read Mask", Range(0,255)) = 255
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        LOD 200
        
        Stencil
        {
            Ref [_StencilRef]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }
        
        // ==================== 主要渲染Pass ====================
        Pass
        {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase" }
            
            Cull [_Cull]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Blend [_SrcBlend] [_DstBlend]
            AlphaToMask [_AlphaToMask]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma shader_feature _ALPHATEST_ON
            #pragma shader_feature _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _EMISSION
            #pragma shader_feature _NORMALMAP
            #pragma shader_feature _PARALLAXMAP
            #pragma shader_feature _DETAIL
            
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            
            // 屬性宣告
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _MainTexAlpha;
            
            sampler2D _MainTex2;
            float4 _MainTex2_ST;
            float4 _Color2;
            float _MainTex2Alpha;
            float4 _MainTex2UVScale;
            float4 _MainTex2UVOffset;
            float _MainTex2BlendMode;
            
            sampler2D _MainTex3;
            float4 _MainTex3_ST;
            float4 _Color3;
            float _MainTex3Alpha;
            float4 _MainTex3UVScale;
            float4 _MainTex3UVOffset;
            float _MainTex3BlendMode;
            
            float4 _MainUVScale;
            float4 _MainUVOffset;
            float _MainUVRotation;
            float _UseUV2;
            
            float _Cutoff;
            
            // 亮度設定
            float _MaxBrightness;
            float _MinBrightness;
            float _Saturation;
            float _Desaturation;
            float _AmbientLightInfluence;
            float _LightColorInfluence;
            float _IndirectLightingBoost;
            
            // 遮罩貼圖包
            sampler2D _MaskPack1; // R:Specular G:Rim B:MatCap A:Emission
            sampler2D _MaskPack2; // R:Glitter G:Shadow B:Outline A:SSS
            
            // 陰影設定
            float4 _ShadowColor;
            float _ShadowSharpness;
            float _ShadowOffset;
            float _ShadowStrength;
            float _ShadowSteps;
            float _ShadowBias;
            float _IndirectShadowIntensity;
            float4 _Shadow2ndColor;
            float _Shadow2ndThreshold;
            float4 _Shadow3rdColor;
            float _Shadow3rdThreshold;
            
            // 發光設定
            float4 _EmissionColor;
            sampler2D _EmissionMap;
            float _EmissionStrength;
            float4 _EmissionColor2;
            float _EmissionStrength2;
            float4 _EmissionColor3;
            float _EmissionStrength3;
            float _EmissionScrolling;
            float4 _EmissionScrollSpeed;
            
            // Normal Map
            sampler2D _BumpMap;
            float _BumpScale;
            sampler2D _BumpMap2;
            float _BumpScale2;
            
            // MatCap
            sampler2D _MatCap;
            float _MatCapStrength;
            float4 _MatCapColor;
            float _MatCapBlendMode;
            sampler2D _MatCap2;
            float _MatCapStrength2;
            float4 _MatCapColor2;
            float _MatCapBlendMode2;
            
            // 光澤設定
            float4 _SpecularColor;
            float _SpecularGloss;
            float _SpecularStrength;
            float _SpecularSharpness;
            float _SpecularOffset;
            float _UseAnisotropic;
            float _AnisotropicDirection;
            float _AnisotropicStrength;
            
            // Rim Light
            float4 _RimColor;
            float _RimPower;
            float _RimStrength;
            float _RimOffset;
            float _RimLightingInfluence;
            float _RimShadowMask;
            float4 _RimColor2;
            float _RimPower2;
            float _RimStrength2;
            
            // 亮片
            float4 _GlitterColor;
            float _GlitterStrength;
            float _GlitterSize;
            float _GlitterSpeed;
            float _GlitterSharpness;
            float _GlitterDensity;
            float _GlitterRandomize;
            
            // 高級設定
            float _HueShift;
            float4 _ColorGrading;
            sampler2D _DetailMap; // RGB:Detail, A:Mask
            float _DetailStrength;
            sampler2D _ParallaxMap;
            float _Parallax;
            sampler2D _MetallicGlossMap; // R:Metallic, G:Roughness, B:AO
            float _Metallic;
            float _Roughness;
            float _OcclusionStrength;
            
            // SSS
            float _UseSSS;
            float4 _SSSColor;
            float _SSSStrength;
            float _SSSDistortion;
            float _SSSPower;
            float _SSSScale;
            
            // 溶解
            float _UseDissolve;
            sampler2D _DissolveMap;
            float _DissolveAmount;
            float4 _DissolveEdgeColor;
            float _DissolveEdgeWidth;
            
            // 頂點動畫
            float _UseVertexAnimation;
            float _VertexAnimSpeed;
            float _VertexAnimStrength;
            
            // Fur
            float _UseFur;
            float _FurLength;
            float _FurDensity;
            
            // Fresnel
            float _FresnelPower;
            float _FresnelIntensity;
            float4 _FresnelColor;
            
            // 風格化
            float _UseHalftone;
            float _HalftoneScale;
            float _HalftoneStrength;
            float _UseCrosshatch;
            float _CrosshatchScale;
            float _CrosshatchStrength;
            float _LightingModel;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 uv : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 color : COLOR;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float3 worldPos : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;
                float3 worldTangent : TEXCOORD4;
                float3 worldBinormal : TEXCOORD5;
                float4 vertexColor : COLOR;
                SHADOW_COORDS(6)
                UNITY_FOG_COORDS(7)
            };
            
            // 工具函數
            float2 RotateUV(float2 uv, float rotation)
            {
                float rad = radians(rotation);
                float2 center = float2(0.5, 0.5);
                float cosAngle = cos(rad);
                float sinAngle = sin(rad);
                float2 uvTranslated = uv - center;
                float2 uvRotated = float2(
                    uvTranslated.x * cosAngle - uvTranslated.y * sinAngle,
                    uvTranslated.x * sinAngle + uvTranslated.y * cosAngle
                );
                return uvRotated + center;
            }
            
            float3 BlendTexture(float3 base, float3 blend, float mode)
            {
                if (mode < 0.5) // Multiply
                    return base * blend;
                else if (mode < 1.5) // Add
                    return base + blend;
                else if (mode < 2.5) // Overlay
                    return (base < 0.5) ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend));
                else // Screen
                    return 1.0 - (1.0 - base) * (1.0 - blend);
            }
            
            float3 RGBToHSV(float3 c)
            {
                float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
                float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
                float d = q.x - min(q.w, q.y);
                float e = 1.0e-10;
                return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
            }
            
            float3 HSVToRGB(float3 c)
            {
                float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
                float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
                return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
            }
            
            float3 ApplyHueShift(float3 color, float shift)
            {
                float3 hsv = RGBToHSV(color);
                hsv.x = frac(hsv.x + shift / 360.0);
                return HSVToRGB(hsv);
            }
            
            float CelShadingRamp(float ndotl, float sharpness, float offset)
            {
                float ramp = saturate((ndotl + offset) * (1.0 - sharpness) + sharpness);
                float steps = floor(ramp * _ShadowSteps) / _ShadowSteps;
                return steps;
            }
            
            v2f vert(appdata v)
            {
                v2f o;
                
                // 頂點動畫
                if (_UseVertexAnimation > 0.5)
                {
                    float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    float wave = sin(_Time.y * _VertexAnimSpeed + worldPos.x * 10.0 + worldPos.z * 10.0);
                    v.vertex.xyz += v.normal * wave * _VertexAnimStrength;
                }
                
                o.pos = UnityObjectToClipPos(v.vertex);
                
                // UV處理
                float2 mainUV = lerp(v.uv, v.uv2, _UseUV2);
                mainUV = RotateUV(mainUV, _MainUVRotation);
                mainUV = mainUV * _MainUVScale.xy + _MainUVOffset.xy;
                o.uv = mainUV;
                o.uv2 = v.uv2;
                
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * v.tangent.w;
                o.vertexColor = v.color;
                
                TRANSFER_SHADOW(o);
                UNITY_TRANSFER_FOG(o, o.pos);
                
                return o;
            }
            
            float4 frag(v2f i) : SV_Target
            {
                // 基礎色彩採樣
                float4 mainTex = tex2D(_MainTex, i.uv) * _Color;
                mainTex.a *= _MainTexAlpha;
                
                // 第二層貼圖
                if (_MainTex2Alpha > 0.001)
                {
                    float2 uv2 = i.uv * _MainTex2UVScale.xy + _MainTex2UVOffset.xy;
                    float4 tex2 = tex2D(_MainTex2, uv2) * _Color2;
                    mainTex.rgb = BlendTexture(mainTex.rgb, tex2.rgb * _MainTex2Alpha * tex2.a, _MainTex2BlendMode);
                }
                
                // 第三層貼圖
                if (_MainTex3Alpha > 0.001)
                {
                    float2 uv3 = i.uv * _MainTex3UVScale.xy + _MainTex3UVOffset.xy;
                    float4 tex3 = tex2D(_MainTex3, uv3) * _Color3;
                    mainTex.rgb = BlendTexture(mainTex.rgb, tex3.rgb * _MainTex3Alpha * tex3.a, _MainTex3BlendMode);
                }
                
                // Alpha測試
                #ifdef _ALPHATEST_ON
                clip(mainTex.a - _Cutoff);
                #endif
                
                // 讀取遮罩貼圖包
                float4 maskPack1 = tex2D(_MaskPack1, i.uv); // R:Specular G:Rim B:MatCap A:Emission
                float4 maskPack2 = tex2D(_MaskPack2, i.uv); // R:Glitter G:Shadow B:Outline A:SSS
                
                // 法線貼圖
                float3 worldNormal = i.worldNormal;
                if (_BumpScale > 0.001)
                {
                    float3 tangentNormal = UnpackNormal(tex2D(_BumpMap, i.uv));
                    tangentNormal.xy *= _BumpScale;
                    
                    if (_BumpScale2 > 0.001)
                    {
                        float3 tangentNormal2 = UnpackNormal(tex2D(_BumpMap2, i.uv));
                        tangentNormal2.xy *= _BumpScale2;
                        tangentNormal = BlendNormals(tangentNormal, tangentNormal2);
                    }
                    
                    float3x3 tangentToWorld = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal);
                    worldNormal = normalize(mul(tangentNormal, tangentToWorld));
                }
                
                // 光照計算
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);
                float3 halfDir = normalize(lightDir + viewDir);
                
                float ndotl = dot(worldNormal, lightDir);
                float ndotv = dot(worldNormal, viewDir);
                float ndoth = dot(worldNormal, halfDir);
                
                // 陰影
                UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
                float shadowMapValue = maskPack2.g; // 使用遮罩包2的G通道作為陰影遮罩
                float shadowTerm = CelShadingRamp(ndotl * atten * shadowMapValue, _ShadowSharpness, _ShadowOffset + _ShadowBias);
                
                // 多層陰影
                float3 shadowColor = _ShadowColor.rgb;
                if (shadowTerm < _Shadow3rdThreshold)
                    shadowColor = _Shadow3rdColor.rgb;
                else if (shadowTerm < _Shadow2ndThreshold)
                    shadowColor = _Shadow2ndColor.rgb;
                
                float3 lighting = lerp(shadowColor, float3(1,1,1), shadowTerm * _ShadowStrength + (1.0 - _ShadowStrength));
                
                // 環境光
                float3 ambient = ShadeSH9(float4(worldNormal, 1.0)) * _IndirectLightingBoost;
                lighting += ambient * _AmbientLightInfluence;
                
                // 光源顏色影響
                lighting *= lerp(float3(1,1,1), _LightColor0.rgb, _LightColorInfluence);
                
                // 應用亮度限制
                lighting = clamp(lighting, _MinBrightness, _MaxBrightness);
                
                // 主要顏色
                float3 finalColor = mainTex.rgb * lighting;
                
                // MatCap
                if (_MatCapStrength > 0.001)
                {
                    float2 matcapUV = worldNormal.xy * 0.5 + 0.5;
                    float3 matcap = tex2D(_MatCap, matcapUV).rgb * _MatCapColor.rgb * maskPack1.b;
                    finalColor = BlendTexture(finalColor, matcap * _MatCapStrength, _MatCapBlendMode);
                }
                
                if (_MatCapStrength2 > 0.001)
                {
                    float2 matcapUV = worldNormal.xy * 0.5 + 0.5;
                    float3 matcap2 = tex2D(_MatCap2, matcapUV).rgb * _MatCapColor2.rgb;
                    finalColor = BlendTexture(finalColor, matcap2 * _MatCapStrength2, _MatCapBlendMode2);
                }
                
                // 高光
                if (_SpecularStrength > 0.001)
                {
                    float specular = pow(max(0, ndoth + _SpecularOffset), _SpecularGloss * 128.0);
                    specular = smoothstep(0.5 - _SpecularSharpness * 0.5, 0.5 + _SpecularSharpness * 0.5, specular);
                    float specMask = maskPack1.r; // 使用遮罩包1的R通道
                    finalColor += _SpecularColor.rgb * specular * _SpecularStrength * specMask * shadowTerm;
                }
                
                // Rim Light
                if (_RimStrength > 0.001)
                {
                    float rimValue = 1.0 - saturate(ndotv + _RimOffset);
                    rimValue = pow(rimValue, _RimPower);
                    float rimMask = maskPack1.g; // 使用遮罩包1的G通道
                    float rimLight = lerp(1.0, shadowTerm, _RimShadowMask);
                    finalColor += _RimColor.rgb * rimValue * _RimStrength * rimMask * rimLight;
                }
                
                if (_RimStrength2 > 0.001)
                {
                    float rimValue2 = 1.0 - saturate(ndotv);
                    rimValue2 = pow(rimValue2, _RimPower2);
                    finalColor += _RimColor2.rgb * rimValue2 * _RimStrength2;
                }
                
                // 亮片效果（使用程序化噪聲而非貼圖）
                if (_GlitterStrength > 0.001)
                {
                    float2 glitterUV = i.uv / _GlitterSize;
                    float glitter = frac(sin(dot(floor(glitterUV) + _Time.y * _GlitterSpeed, float2(12.9898, 78.233))) * 43758.5453);
                    glitter = pow(glitter, (1.0 - _GlitterSharpness) * 10.0 + 1.0);
                    glitter *= step(_GlitterDensity, frac(sin(dot(floor(glitterUV), float2(12.9898, 78.233))) * 43758.5453));
                    float glitterMask = maskPack2.r; // 使用遮罩包2的R通道
                    finalColor += _GlitterColor.rgb * glitter * _GlitterStrength * glitterMask;
                }
                
                // 發光 (使用單一貼圖的RGB通道存儲3層發光)
                float3 emission = float3(0,0,0);
                float emissionMask = maskPack1.a; // 使用遮罩包1的A通道
                
                if (_EmissionStrength > 0.001)
                {
                    float2 emissionUV = i.uv;
                    if (_EmissionScrolling > 0.5)
                        emissionUV += _Time.y * _EmissionScrollSpeed.xy;
                    float3 emissionSample = tex2D(_EmissionMap, emissionUV).rgb;
                    emission += emissionSample.r * _EmissionColor.rgb * _EmissionStrength * emissionMask;
                }
                
                if (_EmissionStrength2 > 0.001)
                {
                    float3 emissionSample = tex2D(_EmissionMap, i.uv).rgb;
                    emission += emissionSample.g * _EmissionColor2.rgb * _EmissionStrength2 * emissionMask;
                }
                
                if (_EmissionStrength3 > 0.001)
                {
                    float3 emissionSample = tex2D(_EmissionMap, i.uv).rgb;
                    emission += emissionSample.b * _EmissionColor3.rgb * _EmissionStrength3 * emissionMask;
                }
                
                finalColor += emission;
                
                // Fresnel
                if (_FresnelIntensity > 0.001)
                {
                    float fresnel = pow(1.0 - saturate(ndotv), _FresnelPower);
                    finalColor += _FresnelColor.rgb * fresnel * _FresnelIntensity;
                }
                
                // 色調偏移
                if (abs(_HueShift) > 0.1)
                {
                    finalColor = ApplyHueShift(finalColor, _HueShift);
                }
                
                // 色彩分級
                finalColor *= _ColorGrading.rgb;
                
                // 飽和度
                float luma = dot(finalColor, float3(0.299, 0.587, 0.114));
                finalColor = lerp(float3(luma, luma, luma), finalColor, _Saturation);
                finalColor = lerp(finalColor, float3(luma, luma, luma), _Desaturation);
                
                // 溶解效果
                if (_UseDissolve > 0.5)
                {
                    float dissolve = tex2D(_DissolveMap, i.uv).r;
                    clip(dissolve - _DissolveAmount);
                    
                    if (dissolve < _DissolveAmount + _DissolveEdgeWidth)
                    {
                        float edge = (_DissolveAmount + _DissolveEdgeWidth - dissolve) / _DissolveEdgeWidth;
                        finalColor += _DissolveEdgeColor.rgb * edge;
                    }
                }
                
                // 半色調效果
                if (_UseHalftone > 0.5)
                {
                    float2 halftoneUV = i.uv * _HalftoneScale;
                    float halftone = sin(halftoneUV.x * 3.14159 * 2.0) * sin(halftoneUV.y * 3.14159 * 2.0);
                    finalColor = lerp(finalColor, finalColor * halftone, _HalftoneStrength);
                }
                
                // 交叉陰影線
                if (_UseCrosshatch > 0.5)
                {
                    float2 crosshatchUV = i.uv * _CrosshatchScale;
                    float crosshatch = max(sin(crosshatchUV.x * 3.14159 * 2.0), sin(crosshatchUV.y * 3.14159 * 2.0));
                    float crossLuma = dot(finalColor, float3(0.299, 0.587, 0.114));
                    finalColor = lerp(finalColor, finalColor * crosshatch, _CrosshatchStrength * (1.0 - crossLuma));
                }
                
                float4 col = float4(finalColor, mainTex.a);
                
                UNITY_APPLY_FOG(i.fogCoord, col);
                
                return col;
            }
            
            ENDCG
        }
        
        // ==================== 輪廓線Pass ====================
        Pass
        {
            Name "OUTLINE"
            Tags { "LightMode"="Always" }
            Cull Front
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            float _OutlineWidth;
            float4 _OutlineColor;
            sampler2D _MaskPack2;
            float _OutlineDistanceFade;
            float _OutlineVertexColorAsWidth;
            float _OutlineFixedSize;
            float _OutlineZOffset;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                
                float outlineWidth = _OutlineWidth;
                
                if (_OutlineVertexColorAsWidth > 0.5)
                {
                    outlineWidth *= v.color.a;
                }
                
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                
                if (_OutlineFixedSize > 0.5)
                {
                    float dist = distance(_WorldSpaceCameraPos, worldPos);
                    outlineWidth *= dist;
                }
                
                // 距離淡出
                float distFade = saturate(1.0 - distance(_WorldSpaceCameraPos, worldPos) * _OutlineDistanceFade);
                outlineWidth *= distFade;
                
                worldPos += worldNormal * outlineWidth;
                
                o.pos = mul(UNITY_MATRIX_VP, float4(worldPos, 1.0));
                o.pos.z += _OutlineZOffset * o.pos.w;
                o.uv = v.uv;
                o.color = v.color;
                
                return o;
            }
            
            float4 frag(v2f i) : SV_Target
            {
                float maskValue = tex2D(_MaskPack2, i.uv).b; // 使用遮罩包2的B通道
                float4 outlineColor = _OutlineColor;
                outlineColor.rgb *= maskValue;
                return outlineColor;
            }
            
            ENDCG
        }
        
        // ==================== 陰影投射Pass ====================
        Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode"="ShadowCaster" }
            
            ZWrite On
            ZTest LEqual
            Cull [_Cull]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                V2F_SHADOW_CASTER;
                float2 uv : TEXCOORD1;
            };
            
            sampler2D _MainTex;
            float _Cutoff;
            
            v2f vert(appdata v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                o.uv = v.uv;
                return o;
            }
            
            float4 frag(v2f i) : SV_Target
            {
                float alpha = tex2D(_MainTex, i.uv).a;
                clip(alpha - _Cutoff);
                SHADOW_CASTER_FRAGMENT(i)
            }
            
            ENDCG
        }
    }
    
    CustomEditor "CelShadedAdvancedGUI"
    Fallback "Diffuse"
}
