// Custom Shader GUI for CelShaded_Advanced
// Place this in Editor folder

using UnityEngine;
using UnityEditor;

public class CelShadedAdvancedGUI : ShaderGUI
{
    private bool showBasicSettings = true;
    private bool showBrightnessSettings = true;
    private bool showUVSettings = false;
    private bool showMainTextures = true;
    private bool showShadowSettings = true;
    private bool showEmissionSettings = false;
    private bool showNormalMaps = false;
    private bool showMatCap = false;
    private bool showSpecular = false;
    private bool showRimLight = true;
    private bool showGlitter = false;
    private bool showOutline = true;
    private bool showAdvanced = false;
    
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        Material targetMat = materialEditor.target as Material;
        
        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Cel-Shaded Advanced Shader", EditorStyles.boldLabel);
        EditorGUILayout.Space();
        
        // Basic Settings
        showBasicSettings = EditorGUILayout.Foldout(showBasicSettings, "Basic Settings", true, EditorStyles.foldoutHeader);
        if (showBasicSettings)
        {
            DrawProperty(materialEditor, properties, "_Cutoff");
            DrawProperty(materialEditor, properties, "_Cull");
            DrawProperty(materialEditor, properties, "_ZWrite");
            DrawProperty(materialEditor, properties, "_ZTest");
            DrawProperty(materialEditor, properties, "_SrcBlend");
            DrawProperty(materialEditor, properties, "_DstBlend");
            DrawProperty(materialEditor, properties, "_AlphaToMask");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Render Queue: " + targetMat.renderQueue);
            
            if (GUILayout.Button("Set Opaque"))
            {
                targetMat.SetFloat("_SrcBlend", (float)UnityEngine.Rendering.BlendMode.One);
                targetMat.SetFloat("_DstBlend", (float)UnityEngine.Rendering.BlendMode.Zero);
                targetMat.SetFloat("_ZWrite", 1);
                targetMat.renderQueue = 2000;
            }
            
            if (GUILayout.Button("Set Transparent"))
            {
                targetMat.SetFloat("_SrcBlend", (float)UnityEngine.Rendering.BlendMode.SrcAlpha);
                targetMat.SetFloat("_DstBlend", (float)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                targetMat.SetFloat("_ZWrite", 0);
                targetMat.renderQueue = 3000;
            }
            
            if (GUILayout.Button("Set Cutout"))
            {
                targetMat.SetFloat("_SrcBlend", (float)UnityEngine.Rendering.BlendMode.One);
                targetMat.SetFloat("_DstBlend", (float)UnityEngine.Rendering.BlendMode.Zero);
                targetMat.SetFloat("_ZWrite", 1);
                targetMat.renderQueue = 2450;
            }
        }
        
        EditorGUILayout.Space();
        
        // Brightness Settings
        showBrightnessSettings = EditorGUILayout.Foldout(showBrightnessSettings, "Brightness Settings", true, EditorStyles.foldoutHeader);
        if (showBrightnessSettings)
        {
            DrawProperty(materialEditor, properties, "_MaxBrightness");
            DrawProperty(materialEditor, properties, "_MinBrightness");
            DrawProperty(materialEditor, properties, "_Saturation");
            DrawProperty(materialEditor, properties, "_Desaturation");
            DrawProperty(materialEditor, properties, "_AmbientLightInfluence");
            DrawProperty(materialEditor, properties, "_LightColorInfluence");
            DrawProperty(materialEditor, properties, "_IndirectLightingBoost");
        }
        
        EditorGUILayout.Space();
        
        // UV Settings
        showUVSettings = EditorGUILayout.Foldout(showUVSettings, "UV Settings", true, EditorStyles.foldoutHeader);
        if (showUVSettings)
        {
            DrawProperty(materialEditor, properties, "_MainUVScale");
            DrawProperty(materialEditor, properties, "_MainUVOffset");
            DrawProperty(materialEditor, properties, "_MainUVRotation");
            DrawProperty(materialEditor, properties, "_UseUV2");
        }
        
        EditorGUILayout.Space();
        
        // Main Color Textures
        showMainTextures = EditorGUILayout.Foldout(showMainTextures, "Main Color Textures", true, EditorStyles.foldoutHeader);
        if (showMainTextures)
        {
            EditorGUILayout.LabelField("Primary Texture", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MainTex");
            DrawProperty(materialEditor, properties, "_Color");
            DrawProperty(materialEditor, properties, "_MainTexAlpha");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Secondary Texture", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MainTex2");
            DrawProperty(materialEditor, properties, "_Color2");
            DrawProperty(materialEditor, properties, "_MainTex2Alpha");
            DrawProperty(materialEditor, properties, "_MainTex2UVScale");
            DrawProperty(materialEditor, properties, "_MainTex2UVOffset");
            DrawProperty(materialEditor, properties, "_MainTex2BlendMode");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Tertiary Texture", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MainTex3");
            DrawProperty(materialEditor, properties, "_Color3");
            DrawProperty(materialEditor, properties, "_MainTex3Alpha");
            DrawProperty(materialEditor, properties, "_MainTex3UVScale");
            DrawProperty(materialEditor, properties, "_MainTex3UVOffset");
            DrawProperty(materialEditor, properties, "_MainTex3BlendMode");
        }
        
        EditorGUILayout.Space();
        
        // Shadow Settings
        showShadowSettings = EditorGUILayout.Foldout(showShadowSettings, "Shadow Settings", true, EditorStyles.foldoutHeader);
        if (showShadowSettings)
        {
            DrawProperty(materialEditor, properties, "_ShadowColor");
            DrawProperty(materialEditor, properties, "_ShadowSharpness");
            DrawProperty(materialEditor, properties, "_ShadowOffset");
            DrawProperty(materialEditor, properties, "_ShadowStrength");
            DrawProperty(materialEditor, properties, "_ShadowSteps");
            DrawProperty(materialEditor, properties, "_ShadowMap");
            DrawProperty(materialEditor, properties, "_ShadowBias");
            DrawProperty(materialEditor, properties, "_IndirectShadowIntensity");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Multi-Layer Shadows", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_Shadow2ndColor");
            DrawProperty(materialEditor, properties, "_Shadow2ndThreshold");
            DrawProperty(materialEditor, properties, "_Shadow3rdColor");
            DrawProperty(materialEditor, properties, "_Shadow3rdThreshold");
        }
        
        EditorGUILayout.Space();
        
        // Emission Settings
        showEmissionSettings = EditorGUILayout.Foldout(showEmissionSettings, "Emission Settings", true, EditorStyles.foldoutHeader);
        if (showEmissionSettings)
        {
            EditorGUILayout.LabelField("Primary Emission", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_EmissionColor");
            DrawProperty(materialEditor, properties, "_EmissionMap");
            DrawProperty(materialEditor, properties, "_EmissionStrength");
            DrawProperty(materialEditor, properties, "_EmissionMask");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Secondary Emission", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_EmissionColor2");
            DrawProperty(materialEditor, properties, "_EmissionMap2");
            DrawProperty(materialEditor, properties, "_EmissionStrength2");
            DrawProperty(materialEditor, properties, "_EmissionMask2");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Tertiary Emission", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_EmissionColor3");
            DrawProperty(materialEditor, properties, "_EmissionMap3");
            DrawProperty(materialEditor, properties, "_EmissionStrength3");
            DrawProperty(materialEditor, properties, "_EmissionMask3");
            
            EditorGUILayout.Space();
            DrawProperty(materialEditor, properties, "_EmissionScrolling");
            DrawProperty(materialEditor, properties, "_EmissionScrollSpeed");
        }
        
        EditorGUILayout.Space();
        
        // Normal Maps
        showNormalMaps = EditorGUILayout.Foldout(showNormalMaps, "Normal Maps", true, EditorStyles.foldoutHeader);
        if (showNormalMaps)
        {
            DrawProperty(materialEditor, properties, "_BumpMap");
            DrawProperty(materialEditor, properties, "_BumpScale");
            
            EditorGUILayout.Space();
            DrawProperty(materialEditor, properties, "_BumpMap2");
            DrawProperty(materialEditor, properties, "_BumpScale2");
            
            EditorGUILayout.Space();
            DrawProperty(materialEditor, properties, "_BumpMap3");
            DrawProperty(materialEditor, properties, "_BumpScale3");
            
            EditorGUILayout.Space();
            DrawProperty(materialEditor, properties, "_DetailNormalMask");
        }
        
        EditorGUILayout.Space();
        
        // MatCap
        showMatCap = EditorGUILayout.Foldout(showMatCap, "MatCap", true, EditorStyles.foldoutHeader);
        if (showMatCap)
        {
            EditorGUILayout.LabelField("Primary MatCap", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MatCap");
            DrawProperty(materialEditor, properties, "_MatCapStrength");
            DrawProperty(materialEditor, properties, "_MatCapColor");
            DrawProperty(materialEditor, properties, "_MatCapBlendMode");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Secondary MatCap", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MatCap2");
            DrawProperty(materialEditor, properties, "_MatCapStrength2");
            DrawProperty(materialEditor, properties, "_MatCapColor2");
            DrawProperty(materialEditor, properties, "_MatCapBlendMode2");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Tertiary MatCap", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MatCap3");
            DrawProperty(materialEditor, properties, "_MatCapStrength3");
            DrawProperty(materialEditor, properties, "_MatCapColor3");
            DrawProperty(materialEditor, properties, "_MatCapBlendMode3");
            
            EditorGUILayout.Space();
            DrawProperty(materialEditor, properties, "_MatCapMask");
        }
        
        EditorGUILayout.Space();
        
        // Specular
        showSpecular = EditorGUILayout.Foldout(showSpecular, "Specular/Glossiness", true, EditorStyles.foldoutHeader);
        if (showSpecular)
        {
            DrawProperty(materialEditor, properties, "_SpecularColor");
            DrawProperty(materialEditor, properties, "_SpecularMap");
            DrawProperty(materialEditor, properties, "_SpecularGloss");
            DrawProperty(materialEditor, properties, "_SpecularStrength");
            DrawProperty(materialEditor, properties, "_SpecularSharpness");
            DrawProperty(materialEditor, properties, "_SpecularOffset");
            DrawProperty(materialEditor, properties, "_SpecularMask");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Anisotropic", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseAnisotropic");
            DrawProperty(materialEditor, properties, "_AnisotropicDirection");
            DrawProperty(materialEditor, properties, "_AnisotropicStrength");
        }
        
        EditorGUILayout.Space();
        
        // Rim Light
        showRimLight = EditorGUILayout.Foldout(showRimLight, "Rim Light", true, EditorStyles.foldoutHeader);
        if (showRimLight)
        {
            EditorGUILayout.LabelField("Primary Rim Light", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_RimColor");
            DrawProperty(materialEditor, properties, "_RimPower");
            DrawProperty(materialEditor, properties, "_RimStrength");
            DrawProperty(materialEditor, properties, "_RimOffset");
            DrawProperty(materialEditor, properties, "_RimMask");
            DrawProperty(materialEditor, properties, "_RimLightingInfluence");
            DrawProperty(materialEditor, properties, "_RimShadowMask");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Secondary Rim Light", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_RimColor2");
            DrawProperty(materialEditor, properties, "_RimPower2");
            DrawProperty(materialEditor, properties, "_RimStrength2");
        }
        
        EditorGUILayout.Space();
        
        // Glitter
        showGlitter = EditorGUILayout.Foldout(showGlitter, "Glitter/Sparkles", true, EditorStyles.foldoutHeader);
        if (showGlitter)
        {
            DrawProperty(materialEditor, properties, "_GlitterMap");
            DrawProperty(materialEditor, properties, "_GlitterColor");
            DrawProperty(materialEditor, properties, "_GlitterStrength");
            DrawProperty(materialEditor, properties, "_GlitterSize");
            DrawProperty(materialEditor, properties, "_GlitterSpeed");
            DrawProperty(materialEditor, properties, "_GlitterSharpness");
            DrawProperty(materialEditor, properties, "_GlitterMask");
            DrawProperty(materialEditor, properties, "_GlitterDensity");
            DrawProperty(materialEditor, properties, "_GlitterRandomize");
        }
        
        EditorGUILayout.Space();
        
        // Outline
        showOutline = EditorGUILayout.Foldout(showOutline, "Outline", true, EditorStyles.foldoutHeader);
        if (showOutline)
        {
            DrawProperty(materialEditor, properties, "_OutlineWidth");
            DrawProperty(materialEditor, properties, "_OutlineColor");
            DrawProperty(materialEditor, properties, "_OutlineMask");
            DrawProperty(materialEditor, properties, "_OutlineDistanceFade");
            DrawProperty(materialEditor, properties, "_OutlineVertexColorAsWidth");
            DrawProperty(materialEditor, properties, "_OutlineFixedSize");
            DrawProperty(materialEditor, properties, "_OutlineZOffset");
        }
        
        EditorGUILayout.Space();
        
        // Advanced
        showAdvanced = EditorGUILayout.Foldout(showAdvanced, "Advanced Features", true, EditorStyles.foldoutHeader);
        if (showAdvanced)
        {
            EditorGUILayout.LabelField("Color Grading", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_HueShift");
            DrawProperty(materialEditor, properties, "_ColorGrading");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Detail", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_DetailMap");
            DrawProperty(materialEditor, properties, "_DetailStrength");
            DrawProperty(materialEditor, properties, "_DetailMask");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Parallax", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_ParallaxMap");
            DrawProperty(materialEditor, properties, "_Parallax");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Occlusion", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_OcclusionMap");
            DrawProperty(materialEditor, properties, "_OcclusionStrength");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("PBR Properties", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_MetallicGlossMap");
            DrawProperty(materialEditor, properties, "_Metallic");
            DrawProperty(materialEditor, properties, "_Roughness");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Subsurface Scattering", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseSSS");
            DrawProperty(materialEditor, properties, "_SSSColor");
            DrawProperty(materialEditor, properties, "_SSSStrength");
            DrawProperty(materialEditor, properties, "_SSSDistortion");
            DrawProperty(materialEditor, properties, "_SSSPower");
            DrawProperty(materialEditor, properties, "_SSSScale");
            DrawProperty(materialEditor, properties, "_SSSMap");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Dissolve Effect", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseDissolve");
            DrawProperty(materialEditor, properties, "_DissolveMap");
            DrawProperty(materialEditor, properties, "_DissolveAmount");
            DrawProperty(materialEditor, properties, "_DissolveEdgeColor");
            DrawProperty(materialEditor, properties, "_DissolveEdgeWidth");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Vertex Animation", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseVertexAnimation");
            DrawProperty(materialEditor, properties, "_VertexAnimSpeed");
            DrawProperty(materialEditor, properties, "_VertexAnimStrength");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Fur Effect", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseFur");
            DrawProperty(materialEditor, properties, "_FurLength");
            DrawProperty(materialEditor, properties, "_FurDensity");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Fresnel", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_FresnelPower");
            DrawProperty(materialEditor, properties, "_FresnelIntensity");
            DrawProperty(materialEditor, properties, "_FresnelColor");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Stylized Effects", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_UseHalftone");
            DrawProperty(materialEditor, properties, "_HalftoneScale");
            DrawProperty(materialEditor, properties, "_HalftoneStrength");
            DrawProperty(materialEditor, properties, "_UseCrosshatch");
            DrawProperty(materialEditor, properties, "_CrosshatchScale");
            DrawProperty(materialEditor, properties, "_CrosshatchStrength");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Lighting Model", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_LightingModel");
            
            EditorGUILayout.Space();
            EditorGUILayout.LabelField("Stencil", EditorStyles.boldLabel);
            DrawProperty(materialEditor, properties, "_StencilRef");
            DrawProperty(materialEditor, properties, "_StencilComp");
            DrawProperty(materialEditor, properties, "_StencilOp");
            DrawProperty(materialEditor, properties, "_StencilWriteMask");
            DrawProperty(materialEditor, properties, "_StencilReadMask");
        }
    }
    
    private void DrawProperty(MaterialEditor materialEditor, MaterialProperty[] properties, string propertyName)
    {
        MaterialProperty prop = FindProperty(propertyName, properties, false);
        if (prop != null)
        {
            materialEditor.ShaderProperty(prop, prop.displayName);
        }
    }
}
