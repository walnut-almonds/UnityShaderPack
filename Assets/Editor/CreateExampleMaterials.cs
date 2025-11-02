#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System.IO;

public static class CreateExampleMaterials
{
    private const string MaterialsFolder = "Assets/Materials";

    [MenuItem("Tools/Create Example Materials")]
    public static void CreateAll()
    {
        EnsureFolder(MaterialsFolder);

        CreateSand();
        CreateMetal();
        CreatePlastic();
        CreateEmissive();
        CreateGlass();
        CreateGemstone();

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();
        Debug.Log("Example materials created in Assets/Materials");
    }

    private static void EnsureFolder(string path)
    {
        if (!AssetDatabase.IsValidFolder(path))
        {
            var parent = Path.GetDirectoryName(path).Replace("\\", "/");
            var name = Path.GetFileName(path);
            if (string.IsNullOrEmpty(parent)) parent = "Assets";
            AssetDatabase.CreateFolder(parent, name);
        }
    }

    private static Material CreateMat(string name, string shaderName)
    {
        var shader = Shader.Find(shaderName);
        if (shader == null)
        {
            Debug.LogError($"Shader not found: {shaderName}");
            return null;
        }
        var mat = new Material(shader) { name = name };
        AssetDatabase.CreateAsset(mat, $"{MaterialsFolder}/{name}.mat");
        return mat;
    }

    private static void CreateSand()
    {
        var mat = CreateMat("Sand_Mat", "Custom/Sand");
        if (!mat) return;
        mat.SetColor("_Color", new Color(0.76f, 0.69f, 0.50f, 1f));
        mat.SetFloat("_Roughness", 0.88f);
        mat.SetFloat("_GrainScale", 70f);
        mat.SetFloat("_GrainIntensity", 0.35f);
        mat.SetFloat("_NormalStrength", 0.75f);
        EditorUtility.SetDirty(mat);
    }

    private static void CreateMetal()
    {
        var mat = CreateMat("Metal_Mat", "Custom/Metal");
        if (!mat) return;
        mat.SetColor("_BaseColor", new Color(0.82f, 0.82f, 0.85f));
        mat.SetFloat("_Metallic", 1.0f);
        mat.SetFloat("_Smoothness", 0.9f);
        EditorUtility.SetDirty(mat);
    }

    private static void CreatePlastic()
    {
        var mat = CreateMat("Plastic_Mat", "Custom/Plastic");
        if (!mat) return;
        mat.SetColor("_Color", new Color(0.12f, 0.55f, 0.95f));
        mat.SetFloat("_Smoothness", 0.6f);
        EditorUtility.SetDirty(mat);
    }

    private static void CreateEmissive()
    {
        var mat = CreateMat("Emissive_Mat", "Custom/Emissive");
        if (!mat) return;
        mat.SetColor("_BaseColor", Color.black);
        mat.SetColor("_EmissionColor", new Color(1.0f, 0.8f, 0.6f));
        mat.SetFloat("_EmissionIntensity", 8f);
        EditorUtility.SetDirty(mat);
    }

    private static void CreateGlass()
    {
        var mat = CreateMat("Glass_Mat", "Custom/GlassRefraction");
        if (!mat) return;
        mat.SetColor("_TintColor", new Color(0.9f, 0.97f, 1f, 0.3f));
        mat.SetFloat("_IOR", 1.5f);
        mat.SetFloat("_RefractionStrength", 0.25f);
        mat.SetFloat("_Alpha", 0.2f);
        mat.SetFloat("_Smoothness", 0.97f);
        mat.SetFloat("_FresnelPower", 5f);
        EditorUtility.SetDirty(mat);
    }

    private static void CreateGemstone()
    {
        var mat = CreateMat("Gem_Mat", "Custom/GemstoneIOR");
        if (!mat) return;
        mat.SetColor("_TintColor", new Color(0.8f, 0.95f, 1f, 0.5f));
        mat.SetFloat("_IOR", 2.2f); // diamond ~2.42, quartz ~1.54
        mat.SetFloat("_Dispersion", 0.03f);
        mat.SetFloat("_RefractionStrength", 0.35f);
        mat.SetFloat("_Alpha", 0.25f);
        mat.SetFloat("_Smoothness", 0.98f);
        mat.SetFloat("_FresnelPower", 5f);
        mat.SetColor("_Absorption", new Color(0.95f, 0.98f, 1f, 1f));
        mat.SetFloat("_AbsorbPower", 1.2f);
        EditorUtility.SetDirty(mat);
    }
}
#endif
