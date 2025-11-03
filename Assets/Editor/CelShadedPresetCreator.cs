// CelShaded Advanced - Material Preset Creator
// 用於快速創建常用的材質預設

#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;

public class CelShadedPresetCreator : EditorWindow
{
    private Shader celShader;
    
    [MenuItem("Tools/CelShaded Advanced/Create Material Presets")]
    public static void ShowWindow()
    {
        GetWindow<CelShadedPresetCreator>("Material Presets");
    }
    
    void OnGUI()
    {
        GUILayout.Label("CelShaded Advanced - Preset Creator", EditorStyles.boldLabel);
        EditorGUILayout.Space();
        
        if (celShader == null)
        {
            celShader = Shader.Find("Custom/CelShaded_Advanced");
            if (celShader == null)
            {
                EditorGUILayout.HelpBox("找不到 Custom/CelShaded_Advanced Shader！", MessageType.Error);
                return;
            }
        }
        
        EditorGUILayout.HelpBox("點擊下方按鈕創建預設材質球", MessageType.Info);
        EditorGUILayout.Space();
        
        if (GUILayout.Button("Classic Anime Style", GUILayout.Height(30)))
        {
            CreateClassicAnimePreset();
        }
        
        if (GUILayout.Button("Metallic Cel-Shaded", GUILayout.Height(30)))
        {
            CreateMetallicPreset();
        }
        
        if (GUILayout.Button("Glowing Energy", GUILayout.Height(30)))
        {
            CreateGlowingEnergyPreset();
        }
        
        if (GUILayout.Button("Soft Illustration Style", GUILayout.Height(30)))
        {
            CreateSoftIllustrationPreset();
        }
        
        if (GUILayout.Button("Comic Book Style", GUILayout.Height(30)))
        {
            CreateComicBookPreset();
        }
        
        if (GUILayout.Button("Gem/Crystal", GUILayout.Height(30)))
        {
            CreateGemPreset();
        }
        
        if (GUILayout.Button("Skin with SSS", GUILayout.Height(30)))
        {
            CreateSkinPreset();
        }
        
        EditorGUILayout.Space();
        
        if (GUILayout.Button("Create All Presets", GUILayout.Height(40)))
        {
            CreateClassicAnimePreset();
            CreateMetallicPreset();
            CreateGlowingEnergyPreset();
            CreateSoftIllustrationPreset();
            CreateComicBookPreset();
            CreateGemPreset();
            CreateSkinPreset();
            
            EditorUtility.DisplayDialog("完成", "已創建所有預設材質球！", "OK");
        }
    }
    
    void CreateClassicAnimePreset()
    {
        Material mat = CreateMaterial("CelShaded_ClassicAnime");
        
        // 基本設定
        mat.SetFloat("_Cutoff", 0.5f);
        
        // 陰影
        mat.SetFloat("_ShadowSteps", 2);
        mat.SetFloat("_ShadowSharpness", 0.95f);
        mat.SetColor("_ShadowColor", new Color(0.7f, 0.7f, 0.7f, 1));
        mat.SetFloat("_ShadowStrength", 0.5f);
        
        // 高光
        mat.SetFloat("_SpecularStrength", 0.5f);
        mat.SetFloat("_SpecularSharpness", 0.9f);
        mat.SetFloat("_SpecularGloss", 0.8f);
        
        // Rim Light
        mat.SetFloat("_RimPower", 3f);
        mat.SetFloat("_RimStrength", 0.8f);
        mat.SetColor("_RimColor", Color.white);
        
        // 輪廓線
        mat.SetFloat("_OutlineWidth", 0.004f);
        mat.SetColor("_OutlineColor", Color.black);
        
        SaveMaterial(mat);
    }
    
    void CreateMetallicPreset()
    {
        Material mat = CreateMaterial("CelShaded_Metallic");
        
        // 陰影
        mat.SetFloat("_ShadowSteps", 2);
        mat.SetFloat("_ShadowSharpness", 0.9f);
        
        // MatCap
        mat.SetFloat("_MatCapStrength", 1.5f);
        mat.SetFloat("_MatCapBlendMode", 0); // Multiply
        
        // 高光
        mat.SetFloat("_SpecularStrength", 1.2f);
        mat.SetFloat("_SpecularSharpness", 0.95f);
        mat.SetFloat("_SpecularGloss", 0.9f);
        
        // Rim Light
        mat.SetFloat("_RimPower", 4f);
        mat.SetFloat("_RimStrength", 0.6f);
        mat.SetColor("_RimColor", new Color(0.8f, 0.9f, 1f, 1));
        
        // 金屬度
        mat.SetFloat("_Metallic", 1f);
        mat.SetFloat("_Roughness", 0.3f);
        
        SaveMaterial(mat);
    }
    
    void CreateGlowingEnergyPreset()
    {
        Material mat = CreateMaterial("CelShaded_GlowingEnergy");
        
        // 透明設定
        mat.SetFloat("_SrcBlend", (float)UnityEngine.Rendering.BlendMode.SrcAlpha);
        mat.SetFloat("_DstBlend", (float)UnityEngine.Rendering.BlendMode.One); // Additive
        mat.SetFloat("_ZWrite", 0);
        mat.renderQueue = 3000;
        
        // 發光
        mat.SetColor("_EmissionColor", new Color(2f, 1f, 2f, 1));
        mat.SetFloat("_EmissionStrength", 3f);
        mat.SetFloat("_EmissionScrolling", 1);
        mat.SetVector("_EmissionScrollSpeed", new Vector4(0.1f, 0, 0, 0));
        
        // Fresnel
        mat.SetFloat("_FresnelIntensity", 1.5f);
        mat.SetFloat("_FresnelPower", 3f);
        mat.SetColor("_FresnelColor", new Color(1.5f, 0.5f, 1.5f, 1));
        
        // Rim Light
        mat.SetFloat("_RimPower", 2f);
        mat.SetFloat("_RimStrength", 1.2f);
        mat.SetColor("_RimColor", new Color(2f, 1f, 2f, 1));
        
        // 溶解
        mat.SetFloat("_UseDissolve", 0);
        mat.SetColor("_DissolveEdgeColor", new Color(3f, 1.5f, 0, 1));
        
        SaveMaterial(mat);
    }
    
    void CreateSoftIllustrationPreset()
    {
        Material mat = CreateMaterial("CelShaded_SoftIllustration");
        
        // 柔和陰影
        mat.SetFloat("_ShadowSteps", 3);
        mat.SetFloat("_ShadowSharpness", 0.3f);
        mat.SetColor("_ShadowColor", new Color(0.8f, 0.75f, 0.7f, 1));
        
        // 飽和度
        mat.SetFloat("_Saturation", 1.3f);
        
        // 柔和高光
        mat.SetFloat("_SpecularStrength", 0.3f);
        mat.SetFloat("_SpecularSharpness", 0.2f);
        
        // 寬 Rim Light
        mat.SetFloat("_RimPower", 2f);
        mat.SetFloat("_RimStrength", 0.5f);
        mat.SetColor("_RimColor", new Color(1f, 0.95f, 0.9f, 1));
        
        // 細輪廓線或無
        mat.SetFloat("_OutlineWidth", 0.001f);
        mat.SetColor("_OutlineColor", new Color(0.3f, 0.25f, 0.2f, 1));
        
        SaveMaterial(mat);
    }
    
    void CreateComicBookPreset()
    {
        Material mat = CreateMaterial("CelShaded_ComicBook");
        
        // 硬邊陰影
        mat.SetFloat("_ShadowSteps", 2);
        mat.SetFloat("_ShadowSharpness", 1f);
        
        // 半色調
        mat.SetFloat("_UseHalftone", 1);
        mat.SetFloat("_HalftoneScale", 20);
        mat.SetFloat("_HalftoneStrength", 0.4f);
        
        // 交叉陰影線
        mat.SetFloat("_UseCrosshatch", 1);
        mat.SetFloat("_CrosshatchScale", 25);
        mat.SetFloat("_CrosshatchStrength", 0.6f);
        
        // 粗輪廓線
        mat.SetFloat("_OutlineWidth", 0.006f);
        mat.SetColor("_OutlineColor", Color.black);
        
        // 部分去色
        mat.SetFloat("_Desaturation", 0.2f);
        
        SaveMaterial(mat);
    }
    
    void CreateGemPreset()
    {
        Material mat = CreateMaterial("CelShaded_Gem");
        
        // 透明
        mat.SetFloat("_SrcBlend", (float)UnityEngine.Rendering.BlendMode.One);
        mat.SetFloat("_DstBlend", (float)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
        mat.SetFloat("_ZWrite", 0);
        mat.renderQueue = 3000;
        
        // 高亮度
        mat.SetFloat("_MaxBrightness", 1.5f);
        mat.SetFloat("_Saturation", 1.5f);
        
        // 強高光
        mat.SetFloat("_SpecularStrength", 1.5f);
        mat.SetFloat("_SpecularSharpness", 0.95f);
        mat.SetFloat("_SpecularGloss", 0.95f);
        
        // 亮片
        mat.SetFloat("_GlitterStrength", 0.8f);
        mat.SetFloat("_GlitterSize", 0.05f);
        mat.SetFloat("_GlitterSharpness", 0.95f);
        mat.SetFloat("_GlitterDensity", 0.3f);
        
        // Fresnel
        mat.SetFloat("_FresnelIntensity", 1f);
        mat.SetFloat("_FresnelPower", 5f);
        
        // MatCap
        mat.SetFloat("_MatCapStrength", 1.2f);
        mat.SetFloat("_MatCapBlendMode", 1); // Add
        
        SaveMaterial(mat);
    }
    
    void CreateSkinPreset()
    {
        Material mat = CreateMaterial("CelShaded_Skin");
        
        // 柔和陰影
        mat.SetFloat("_ShadowSteps", 3);
        mat.SetFloat("_ShadowSharpness", 0.4f);
        mat.SetColor("_ShadowColor", new Color(0.85f, 0.7f, 0.65f, 1));
        mat.SetColor("_Shadow2ndColor", new Color(0.7f, 0.5f, 0.45f, 1));
        mat.SetFloat("_Shadow2ndThreshold", 0.4f);
        
        // SSS
        mat.SetFloat("_UseSSS", 1);
        mat.SetColor("_SSSColor", new Color(1f, 0.5f, 0.5f, 1));
        mat.SetFloat("_SSSStrength", 0.5f);
        mat.SetFloat("_SSSPower", 3f);
        
        // 柔和高光
        mat.SetFloat("_SpecularStrength", 0.4f);
        mat.SetFloat("_SpecularSharpness", 0.5f);
        mat.SetFloat("_SpecularGloss", 0.6f);
        
        // Rim Light
        mat.SetFloat("_RimPower", 3f);
        mat.SetFloat("_RimStrength", 0.4f);
        mat.SetColor("_RimColor", new Color(1f, 0.9f, 0.85f, 1));
        
        // 細輪廓線
        mat.SetFloat("_OutlineWidth", 0.002f);
        mat.SetColor("_OutlineColor", new Color(0.5f, 0.3f, 0.25f, 1));
        
        SaveMaterial(mat);
    }
    
    Material CreateMaterial(string name)
    {
        Material mat = new Material(celShader);
        mat.name = name;
        return mat;
    }
    
    void SaveMaterial(Material mat)
    {
        string path = "Assets/Materials/CelShadedPresets";
        
        if (!AssetDatabase.IsValidFolder("Assets/Materials"))
        {
            AssetDatabase.CreateFolder("Assets", "Materials");
        }
        
        if (!AssetDatabase.IsValidFolder(path))
        {
            AssetDatabase.CreateFolder("Assets/Materials", "CelShadedPresets");
        }
        
        string fullPath = $"{path}/{mat.name}.mat";
        
        // 檢查是否已存在
        Material existingMat = AssetDatabase.LoadAssetAtPath<Material>(fullPath);
        if (existingMat != null)
        {
            EditorUtility.CopySerializedIfDifferent(mat, existingMat);
            AssetDatabase.SaveAssets();
            Debug.Log($"Updated material: {fullPath}");
        }
        else
        {
            AssetDatabase.CreateAsset(mat, fullPath);
            Debug.Log($"Created material: {fullPath}");
        }
    }
}
#endif
