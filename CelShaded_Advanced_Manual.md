# CelShaded Advanced Shader - 完整使用手冊

## 概述
這是一個功能極其豐富的賽璐璐風格（Cel-Shaded/Toon）shader，專為 Unity 設計，提供超過 150 個可調整參數，適用於各種風格化渲染需求。

---

## 主要功能模塊

### 1. 基本設定 (Basic Settings)
控制 shader 的渲染行為和透明度處理。

#### 參數說明：
- **Alpha Cutoff** (0-1): Alpha 剪切閾值，用於透明度測試
- **Cull Mode**: 剔除模式（Off/Front/Back）
- **ZWrite**: 是否寫入深度緩衝
- **ZTest**: 深度測試模式
- **Src Blend / Dst Blend**: 混合模式設定
- **Alpha To Coverage**: MSAA 抗鋸齒支援

#### 預設組合：
- **不透明 (Opaque)**: SrcBlend=One, DstBlend=Zero, ZWrite=On, Queue=2000
- **透明 (Transparent)**: SrcBlend=SrcAlpha, DstBlend=OneMinusSrcAlpha, ZWrite=Off, Queue=3000
- **剪裁 (Cutout)**: SrcBlend=One, DstBlend=Zero, ZWrite=On, Queue=2450, 配合 Alpha Cutoff

---

### 2. 亮度設定 (Brightness Settings)
精細控制整體光照和色彩飽和度。

#### 參數說明：
- **Max Brightness** (0-2): 最大亮度限制，防止過曝
- **Min Brightness** (0-2): 最小亮度限制，確保陰影可見
- **Saturation** (0-2): 色彩飽和度，>1 增強色彩，<1 降低色彩
- **Desaturation** (0-1): 去色化程度，接近 1 時變為黑白
- **Ambient Light Influence** (0-1): 環境光影響強度
- **Light Color Influence** (0-1): 光源顏色影響強度
- **Indirect Lighting Boost** (0-2): 間接光照增強倍數

#### 使用建議：
- 明亮風格：Max=1.5, Min=0.5, Saturation=1.2
- 黑暗風格：Max=0.8, Min=0.1, Saturation=0.9
- 黑白漫畫：Desaturation=1.0

---

### 3. UV 設定 (UV Settings)
控制主要 UV 坐標的變換。

#### 參數說明：
- **Main UV Scale**: UV 縮放（X, Y）
- **Main UV Offset**: UV 偏移（X, Y）
- **Main UV Rotation** (0-360): UV 旋轉角度
- **Use UV2**: 使用第二套 UV 坐標

#### 應用場景：
- 貼圖平鋪：Scale > 1
- 貼圖動畫：通過腳本修改 Offset
- 旋轉圖案：調整 Rotation

---

### 4. 主要色彩貼圖設定 (Main Color Textures)
支援最多 3 層貼圖疊加，每層可獨立控制。

#### 每層參數：
- **Texture**: 貼圖
- **Color**: 顏色調製
- **Alpha** (0-1): 該層不透明度
- **UV Scale/Offset**: 該層獨立 UV 變換（第 2、3 層）
- **Blend Mode**: 混合模式
  - **0-Multiply**: 相乘（變暗）
  - **1-Add**: 相加（變亮）
  - **2-Overlay**: 疊加（對比增強）
  - **3-Screen**: 濾色（柔和變亮）

#### 使用範例：
```
第 1 層：基礎顏色貼圖
第 2 層：細節貼圖，Multiply 模式，Scale=(5,5)
第 3 層：污漬貼圖，Overlay 模式，Alpha=0.5
```

---

### 5. 陰影設定 (Shadow Settings)
賽璐璐風格的核心，支援多層階梯陰影。

#### 基礎陰影參數：
- **Shadow Color**: 陰影顏色
- **Shadow Sharpness** (0-1): 陰影邊緣銳利度，接近 1 時為硬邊
- **Shadow Offset** (-1-1): 陰影閾值偏移
- **Shadow Strength** (0-1): 陰影強度
- **Shadow Steps** (1-10): 陰影階梯數量
- **Shadow Map**: 陰影貼圖遮罩
- **Shadow Bias** (-1-1): 陰影偏差調整
- **Indirect Shadow Intensity** (0-1): 間接陰影強度

#### 多層陰影：
- **2nd Shadow Color**: 第二層陰影顏色（更深）
- **2nd Shadow Threshold** (0-1): 第二層陰影閾值
- **3rd Shadow Color**: 第三層陰影顏色（最深）
- **3rd Shadow Threshold** (0-1): 第三層陰影閾值

#### 使用建議：
```
經典兩色陰影：
- Shadow Steps = 2
- Shadow Sharpness = 0.9
- Shadow Color = 淺灰色 (0.7, 0.7, 0.7)

三色陰影（動畫風格）：
- Shadow Steps = 3
- Shadow Color = (0.8, 0.8, 0.8)
- 2nd Shadow Color = (0.5, 0.5, 0.5)
- 2nd Shadow Threshold = 0.4
- 3rd Shadow Color = (0.3, 0.3, 0.3)
- 3rd Shadow Threshold = 0.15
```

---

### 6. 發光設定 (Emission Settings)
支援 3 層獨立發光貼圖，每層可配遮罩。

#### 每層參數：
- **Emission Color** (HDR): 發光顏色，可使用 HDR 強度
- **Emission Map**: 發光貼圖
- **Emission Strength** (0-10): 發光強度
- **Emission Mask**: 發光遮罩（黑色=不發光，白色=完全發光）

#### 額外功能：
- **Enable Emission Scrolling**: 啟用發光滾動動畫
- **Emission Scroll Speed**: 滾動速度（X, Y）

#### 應用範例：
```
霓虹燈效果：
- Emission Color = 高強度色彩 (2.0, 0.5, 1.0)
- Emission Strength = 3.0
- Emission Scrolling = On
- Scroll Speed = (0.1, 0)

能量紋路：
- 使用 Emission Mask 控制發光區域
- 第 2 層用於脈衝效果（通過腳本控制 Strength）
```

---

### 7. Normal Map（法線貼圖）
支援最多 3 層法線貼圖混合。

#### 參數說明：
- **Normal Map 1/2/3**: 法線貼圖
- **Normal Scale 1/2/3** (0-2): 法線強度
- **Detail Normal Mask**: 細節法線遮罩

#### 使用建議：
- 第 1 層：主要法線貼圖
- 第 2 層：細節法線（如布料紋理）
- 第 3 層：微觀細節（如皮膚毛孔）

---

### 8. MatCap（球形貼圖）
支援 3 層 MatCap 疊加，適合快速添加金屬感或環境反射。

#### 每層參數：
- **MatCap**: MatCap 貼圖
- **MatCap Strength** (0-2): 強度
- **MatCap Color**: 顏色調製
- **MatCap Blend Mode**: 混合模式（Multiply/Add/Overlay/Screen）
- **MatCap Mask**: 遮罩

#### 應用範例：
```
金屬光澤：
- MatCap = 金屬 MatCap 貼圖
- Blend Mode = Multiply
- Strength = 1.0

眼睛高光：
- MatCap = 高光 MatCap
- Blend Mode = Add
- Strength = 0.8
- 使用 Mask 限制在眼睛區域
```

---

### 9. 光澤設定 (Specular Settings)
賽璐璐風格的高光，支援各向異性。

#### 基礎參數：
- **Specular Color**: 高光顏色
- **Specular Map**: 高光貼圖
- **Specular Gloss** (0-1): 光澤度（越大越小的高光）
- **Specular Strength** (0-2): 高光強度
- **Specular Sharpness** (0-1): 高光邊緣銳利度
- **Specular Offset** (-1-1): 高光位置偏移
- **Specular Mask**: 高光遮罩

#### 各向異性（Anisotropic）：
- **Use Anisotropic**: 啟用各向異性
- **Anisotropic Direction** (0-1): 方向
- **Anisotropic Strength** (0-1): 強度

#### 風格建議：
```
硬邊高光（動畫風格）：
- Sharpness = 0.95
- Gloss = 0.9

柔和高光（真實感）：
- Sharpness = 0.3
- Gloss = 0.5

頭髮天使環：
- Use Anisotropic = On
- Anisotropic Strength = 0.8
```

---

### 10. Rim Light（邊緣光）
支援雙層邊緣光，可用於輪廓提亮。

#### 第一層參數：
- **Rim Color** (HDR): 邊緣光顏色
- **Rim Power** (0.1-8): 邊緣銳利度
- **Rim Strength** (0-2): 強度
- **Rim Offset** (-1-1): 位置偏移
- **Rim Mask**: 遮罩
- **Rim Lighting Influence**: 是否受光照影響
- **Rim Shadow Mask** (0-1): 陰影區域遮蔽程度

#### 第二層參數：
- **2nd Rim Color**: 第二層顏色
- **2nd Rim Power**: 第二層銳利度
- **2nd Rim Strength**: 第二層強度

#### 應用範例：
```
背光輪廓：
- Rim Color = 暖色 (1, 0.8, 0.6)
- Rim Power = 3.0
- Rim Strength = 1.0
- Rim Shadow Mask = 0.8 (只在亮部顯示)

雙層邊緣光：
- 第 1 層：寬而柔和（Power=2）
- 第 2 層：窄而明亮（Power=6）
```

---

### 11. 亮片設定 (Glitter Settings)
添加閃亮粒子效果。

#### 參數說明：
- **Glitter Map**: 亮片貼圖（通常用噪聲貼圖）
- **Glitter Color** (HDR): 亮片顏色
- **Glitter Strength** (0-2): 強度
- **Glitter Size** (0.01-1): 亮片大小
- **Glitter Speed** (0-5): 閃爍速度
- **Glitter Sharpness** (0-1): 銳利度
- **Glitter Mask**: 顏色遮罩（用於限制區域）
- **Glitter Density** (0-1): 密度
- **Randomize Glitter**: 隨機化亮片分佈

#### 使用建議：
```
寶石效果：
- Size = 0.05
- Sharpness = 0.95
- Density = 0.3
- Speed = 0.5

閃粉衣服：
- Size = 0.02
- Sharpness = 0.7
- Density = 0.6
- 使用 Mask 限制在特定區域
```

---

### 12. 輪廓線設定 (Outline Settings)
外描邊功能，使用獨立 Pass 渲染。

#### 參數說明：
- **Outline Width** (0-0.1): 輪廓線寬度
- **Outline Color**: 輪廓線顏色
- **Outline Mask**: 顏色遮罩（可用於多色輪廓線）
- **Outline Distance Fade** (0-1): 距離淡出速率
- **Use Vertex Color As Width**: 使用頂點色 Alpha 控制寬度
- **Fixed Size Outline**: 固定屏幕空間大小（不隨距離縮放）
- **Outline Z Offset** (-1-1): 深度偏移，修正 Z-fighting

#### 使用建議：
```
動畫風格粗線：
- Width = 0.005
- Color = 黑色
- Fixed Size = Off

漫畫風格細線：
- Width = 0.002
- Color = 深棕色
- Distance Fade = 0.3

多色輪廓線：
- 使用 Outline Mask 貼圖
- 不同區域不同顏色
```

---

### 13. 高級設定 (Advanced Settings)

#### 色調映射（Color Grading）：
- **Hue Shift** (-180-180): 色相偏移（度）
- **Color Grading**: 色彩分級調整

#### 細節貼圖（Detail）：
- **Detail Map**: 細節貼圖
- **Detail Strength** (0-1): 強度
- **Detail Mask**: 遮罩

#### 視差映射（Parallax）：
- **Height Map**: 高度圖
- **Parallax Height** (0.005-0.08): 視差強度

#### 環境遮蔽（Occlusion）：
- **Occlusion Map**: AO 貼圖
- **Occlusion Strength** (0-1): 強度

#### PBR 屬性：
- **Metallic Gloss Map**: 金屬度（R）粗糙度（G）貼圖
- **Metallic** (0-1): 金屬度
- **Roughness** (0-1): 粗糙度

#### 次表面散射（Subsurface Scattering）：
- **Use SSS**: 啟用 SSS
- **SSS Color**: SSS 顏色
- **SSS Strength** (0-1): 強度
- **SSS Distortion** (0-1): 扭曲度
- **SSS Power** (0.1-10): 冪次
- **SSS Scale** (0-10): 縮放
- **SSS Map**: SSS 遮罩

應用：皮膚、蠟、玉石等半透明材質

#### 溶解效果（Dissolve）：
- **Use Dissolve**: 啟用溶解
- **Dissolve Map**: 溶解貼圖（噪聲）
- **Dissolve Amount** (0-1): 溶解進度
- **Dissolve Edge Color** (HDR): 邊緣發光顏色
- **Dissolve Edge Width** (0-0.5): 邊緣寬度

用途：消失/出現特效、燃燒效果

#### 頂點動畫（Vertex Animation）：
- **Use Vertex Animation**: 啟用頂點動畫
- **Vertex Anim Speed** (0-10): 動畫速度
- **Vertex Anim Strength** (0-1): 動畫強度

用途：旗幟飄動、水波、能量場

#### Fur 效果：
- **Use Fur**: 啟用 Fur
- **Fur Length** (0-0.1): 長度
- **Fur Density** (0-1): 密度

（需配合多 Pass 實現完整效果）

#### Fresnel（菲涅爾）：
- **Fresnel Power** (0-10): 冪次
- **Fresnel Intensity** (0-2): 強度
- **Fresnel Color** (HDR): 顏色

用途：玻璃、水面、能量護盾

#### 風格化效果：

**半色調（Halftone）**：
- **Use Halftone**: 啟用
- **Halftone Scale** (1-100): 點陣密度
- **Halftone Strength** (0-1): 強度

漫畫印刷風格

**交叉陰影線（Crosshatch）**：
- **Use Crosshatch**: 啟用
- **Crosshatch Scale** (1-100): 線條密度
- **Crosshatch Strength** (0-1): 強度

素描/手繪風格

#### 光照模型：
- **Lighting Model**: 選擇光照模型
  - 0: Toon（卡通）
  - 1: Realistic（真實）
  - 2: Stylized（風格化）
  - 3: Custom（自訂）

#### Stencil（模板）：
- **Stencil Reference** (0-255): 參考值
- **Stencil Comparison**: 比較函數
- **Stencil Operation**: 操作
- **Stencil Write/Read Mask**: 寫入/讀取遮罩

用途：遮罩渲染、傳送門效果

---

## 常見配置範例

### 1. 經典動畫風格
```
基本：Opaque, Cutoff=0.5
陰影：Steps=2, Sharpness=0.95, Color=(0.7,0.7,0.7)
高光：Sharpness=0.9, Gloss=0.8
Rim Light：Power=3, Strength=0.8
輪廓線：Width=0.004, Color=黑色
```

### 2. 賽璐璐金屬
```
基本顏色：金屬色貼圖
MatCap：金屬 MatCap, Strength=1.5, Blend=Multiply
高光：Sharpness=0.95, Strength=1.2
Rim Light：冷色調, Power=4
Metallic：1.0
```

### 3. 發光能量體
```
主貼圖：半透明設定
發光：3 層發光貼圖，不同顏色
Fresnel：強度=1.5
Rim Light：HDR 亮色
溶解：配合腳本動態調整
```

### 4. 柔和插畫風格
```
陰影：Steps=3, Sharpness=0.3（柔邊）
飽和度：1.3
高光：Sharpness=0.2（柔和）
Rim Light：Power=2（寬邊）
無輪廓線或極細輪廓線
```

### 5. 硬核漫畫風格
```
陰影：Steps=2, Sharpness=1.0
Halftone：啟用，Scale=20
Crosshatch：在陰影區域，Strength=0.6
輪廓線：Width=0.006，黑色
Desaturation：部分去色
```

---

## 性能優化建議

### 高性能模式：
- 使用單層貼圖
- 關閉不需要的 MatCap
- 減少法線貼圖層數
- 關閉高級特效（SSS、Dissolve、Halftone）
- 使用較少的陰影階梯

### 平衡模式：
- 2 層主貼圖
- 1 層 MatCap
- 2 層陰影
- 基礎 Rim Light 和高光

### 高品質模式：
- 完整的 3 層貼圖疊加
- 多層 MatCap
- 3 層陰影
- 完整的特效組合
- SSS、溶解等高級效果

---

## 注意事項

1. **透明度處理**：
   - Transparent 模式會禁用 ZWrite，可能導致排序問題
   - Cutout 模式適合樹葉、柵欄等硬邊透明
   - 使用 Alpha To Coverage 可改善 Cutout 的鋸齒

2. **輪廓線問題**：
   - 過寬的輪廓線可能在尖銳邊緣產生異常
   - 使用 Vertex Color 可為不同部位設定不同寬度
   - Z Offset 可修正輪廓線與幾何體的層次問題

3. **光照**：
   - 此 shader 在 Forward Rendering 下表現最佳
   - 多光源支援有限（主要針對主方向光）
   - 使用 Lightmap 可獲得更好的間接照明

4. **移動平台**：
   - 建議關閉複雜特效
   - 減少貼圖層數
   - 避免使用 HDR 顏色

5. **VR 優化**：
   - 使用 Single Pass Instanced 渲染
   - 謹慎使用後處理效果
   - 測試固定大小輪廓線在 VR 中的表現

---

## 腳本控制範例

```csharp
using UnityEngine;

public class ShaderController : MonoBehaviour
{
    private Material material;
    
    void Start()
    {
        material = GetComponent<Renderer>().material;
    }
    
    // 控制發光強度
    public void SetEmissionStrength(float strength)
    {
        material.SetFloat("_EmissionStrength", strength);
    }
    
    // 溶解動畫
    public void Dissolve(float duration)
    {
        material.SetFloat("_UseDissolve", 1);
        StartCoroutine(DissolveCoroutine(duration));
    }
    
    IEnumerator DissolveCoroutine(float duration)
    {
        float elapsed = 0;
        while (elapsed < duration)
        {
            elapsed += Time.deltaTime;
            float amount = elapsed / duration;
            material.SetFloat("_DissolveAmount", amount);
            yield return null;
        }
    }
    
    // 色相偏移動畫
    public void AnimateHue(float speed)
    {
        float hue = Mathf.PingPong(Time.time * speed, 360);
        material.SetFloat("_HueShift", hue);
    }
    
    // UV 滾動
    public void ScrollTexture(Vector2 speed)
    {
        Vector2 offset = material.GetVector("_MainUVOffset");
        offset += speed * Time.deltaTime;
        material.SetVector("_MainUVOffset", offset);
    }
}
```

---

## 疑難排解

### Q: 陰影過於銳利/柔和
A: 調整 Shadow Sharpness 參數。接近 1 為硬邊，接近 0 為柔邊。

### Q: 輪廓線在某些角度消失
A: 檢查模型法線是否正確，或調整 Outline Z Offset。

### Q: 貼圖顏色不正確
A: 確保貼圖的 sRGB 設定正確（顏色貼圖應為 sRGB，數據貼圖應為 Linear）。

### Q: 性能問題
A: 使用 Frame Debugger 查看 Draw Call，關閉不需要的功能，合併貼圖。

### Q: MatCap 效果不對
A: 確保 MatCap 貼圖是正確的球形映射格式。

---

## 更新日誌

**Version 1.0**
- 初始版本
- 包含所有核心功能
- 支援 Unity 2019.4 及以上版本

---

## 授權與支援

此 shader 為開源項目，可自由使用和修改。
如有問題或建議，歡迎回饋。

---

## 技術規格

- **Shader Model**: 3.0
- **渲染管線**: Built-in Render Pipeline
- **支援平台**: Windows, Mac, Linux, iOS, Android, WebGL
- **VR 支援**: 是（Single Pass 和 Multi Pass）
- **光照模式**: Forward Rendering（主要）
- **貼圖槽位**: 約 30 個
- **參數數量**: 150+

---

## 致謝

感謝 Unity 社群的各種教學和資源，特別是：
- Unity Chan Toon Shader 的靈感
- Amplify Shader Editor 的參考
- 各種開源 Toon Shader 項目

---

**製作日期**: 2025-11-03  
**版本**: 1.0  
**作者**: ShaderLab Advanced Team
