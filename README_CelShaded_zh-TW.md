# 🎨 CelShaded Advanced Shader

[中文](README_zh-TW.md) | [English](README.md) | [日本語](README_ja.md)

---

一個功能完整、極度可自訂的賽璐璐風格（Cel-Shaded/Toon）Unity Shader，擁有超過 **150 個參數**，適用於各種 NPR（非真實感渲染）需求。

![Version](https://img.shields.io/badge/version-1.0-blue)
![Unity](https://img.shields.io/badge/Unity-2019.4%2B-green)
![License](https://img.shields.io/badge/license-MIT-orange)

---

## ✨ 主要特色

### 🎯 核心功能
- ✅ **多層階梯陰影** - 支援 1-10 層可調陰影
- ✅ **輪廓線渲染** - 可自訂寬度、顏色、距離淡出
- ✅ **多貼圖疊加** - 3 層主貼圖，支援多種混合模式
- ✅ **靈活的光照控制** - 完整的亮度、飽和度、色調調整
- ✅ **MatCap 支援** - 3 層 MatCap，快速添加環境反射
- ✅ **法線貼圖** - 3 層法線貼圖混合
- ✅ **高級高光** - 包含各向異性高光支援
- ✅ **雙層 Rim Light** - 獨立控制的邊緣光

### 🌟 特殊效果
- ✨ **發光系統** - 3 層發光貼圖 + 遮罩 + 滾動動畫
- ✨ **亮片效果** - 動態閃爍粒子，支援顏色遮罩
- ✨ **次表面散射 (SSS)** - 適合皮膚、蠟質材質
- ✨ **溶解效果** - 帶邊緣發光的溶解動畫
- ✨ **半色調/交叉陰影線** - 漫畫印刷風格
- ✨ **Fresnel 效果** - 玻璃、能量場適用
- ✨ **頂點動畫** - 內建波浪動畫支援

### 🎨 風格化選項
- 🖌️ 色相偏移
- 🖌️ 色彩分級
- 🖌️ 飽和度/去色化
- 🖌️ 多種光照模型選擇
- 🖌️ 視差映射
- 🖌️ 環境遮蔽
- 🖌️ 細節貼圖
- 🖌️ Stencil 支援

---

## 📦 包含內容

```
Assets/
├── Shaders/
│   ├── CelShaded_Advanced.shader          # 主 Shader 文件
│   ├── CelShaded_Advanced_Manual.md       # 完整使用手冊
│   └── CelShaded_QuickReference.md        # 快速參考指南
│
└── Editor/
    ├── CelShadedAdvancedGUI.cs            # 自定義材質編輯器
    └── CelShadedPresetCreator.cs          # 預設材質創建工具
```

---

## 🚀 快速開始

### 1. 導入 Shader
將整個 `Assets` 資料夾拖入你的 Unity 專案。

### 2. 創建材質
在 Project 視窗中:
- 右鍵 → Create → Material
- 在 Inspector 中，Shader 下拉選單選擇 `Custom/CelShaded_Advanced`

### 3. 使用預設
打開工具視窗:
```
Unity 菜單 → Tools → CelShaded Advanced → Create Material Presets
```
點擊按鈕創建預設材質球。

### 4. 應用到模型
將材質拖曳到場景中的 3D 模型上。

---

## 🎯 預設材質

包含 7 種常用風格預設:

| 預設名稱 | 適用場景 | 特點 |
|---------|---------|------|
| **Classic Anime** | 動畫角色 | 硬邊陰影、黑色輪廓線 |
| **Metallic** | 機械、武器 | 金屬 MatCap、強高光 |
| **Glowing Energy** | 能量特效 | 多層發光、Fresnel |
| **Soft Illustration** | 插畫風格 | 柔邊陰影、高飽和度 |
| **Comic Book** | 漫畫風格 | 半色調、交叉陰影線 |
| **Gem/Crystal** | 寶石、水晶 | 透明、亮片、強折射 |
| **Skin with SSS** | 角色皮膚 | 次表面散射、柔和陰影 |

---

## 📖 核心參數速查

### 基本外觀
```shader
// 陰影
_ShadowColor           // 陰影顏色
_ShadowSharpness       // 銳利度 (0-1)
_ShadowSteps           // 階梯數 (1-10)

// 輪廓線
_OutlineWidth          // 寬度 (0-0.1)
_OutlineColor          // 顏色

// 高光
_SpecularStrength      // 強度 (0-2)
_SpecularSharpness     // 銳利度 (0-1)

// Rim Light
_RimPower              // 冪次 (0.1-8)
_RimStrength           // 強度 (0-2)
```

### 特殊效果
```shader
// 發光
_EmissionColor         // HDR 顏色
_EmissionStrength      // 強度 (0-10)

// 溶解
_UseDissolve           // 啟用
_DissolveAmount        // 進度 (0-1)

// SSS
_UseSSS                // 啟用
_SSSStrength           // 強度 (0-1)
```

---

## 💻 腳本控制範例

### 動態發光
```csharp
Material mat = GetComponent<Renderer>().material;

// 呼吸燈效果
float pulse = Mathf.Sin(Time.time * 2) * 0.5f + 0.5f;
mat.SetFloat("_EmissionStrength", pulse * 3);
```

### 溶解動畫
```csharp
IEnumerator Dissolve(float duration)
{
    mat.SetFloat("_UseDissolve", 1);
    float elapsed = 0;
    
    while (elapsed < duration)
    {
        elapsed += Time.deltaTime;
        mat.SetFloat("_DissolveAmount", elapsed / duration);
        yield return null;
    }
}
```

### UV 滾動
```csharp
void Update()
{
    Vector2 offset = mat.GetVector("_MainUVOffset");
    offset.x += Time.deltaTime * 0.1f;
    mat.SetVector("_MainUVOffset", offset);
}
```

---

## 🎬 使用場景

### ✅ 適合用於
- 動畫風格遊戲角色
- 卡通風格環境物件
- 賽璐璐風格渲染
- 風格化特效
- NPR 渲染實驗
- 漫畫/插畫風格項目
- VRChat 等虛擬社交平台

### ⚠️ 不適合用於
- 真實感渲染（請使用 PBR Shader）
- 超低端移動設備（功能太多）
- Deferred Rendering（主要為 Forward 設計）

---

## ⚙️ 技術規格

| 項目 | 規格 |
|------|------|
| **Shader Model** | 3.0+ |
| **渲染管線** | Built-in Render Pipeline |
| **Unity 版本** | 2019.4 LTS 及以上 |
| **支援平台** | Windows, Mac, Linux, iOS, Android, WebGL, Console |
| **VR 支援** | ✅ Single Pass, Multi Pass |
| **光照模式** | Forward Rendering (主要) |
| **參數數量** | 150+ |
| **貼圖槽位** | 約 30 個 |

---

## 📊 性能建議

### 🟢 移動端優化
```
- 使用 1 層主貼圖
- 2 階陰影
- 關閉 MatCap、SSS、溶解等特效
- 使用較小的貼圖（512-1024）
```

### 🟡 PC/主機
```
- 2-3 層貼圖
- 2-3 階陰影
- 1-2 個 MatCap
- 基礎特效（Rim Light、高光）
```

### 🔴 高端 PC
```
- 所有功能全開
- 高解析度貼圖（2048+）
- 多層效果疊加
```

---

## 🐛 常見問題

<details>
<summary><b>Q: 陰影不顯示？</b></summary>

**A**: 檢查:
1. 場景中是否有方向光（Directional Light）
2. `Shadow Strength` 是否 > 0
3. 模型是否接收陰影（Cast/Receive Shadows）
</details>

<details>
<summary><b>Q: 輪廓線在某些角度消失？</b></summary>

**A**: 
1. 檢查模型法線是否正確
2. 調整 `Outline Z Offset`
3. 確認輪廓線寬度不要過大
</details>

<details>
<summary><b>Q: 透明材質排序錯誤？</b></summary>

**A**: 
1. 設定正確的 Render Queue (3000+)
2. 關閉 ZWrite
3. 考慮使用 Alpha Test (Cutout) 代替 Alpha Blend
</details>

<details>
<summary><b>Q: 性能不佳？</b></summary>

**A**: 
1. 使用 Frame Debugger 檢查 Draw Calls
2. 關閉不需要的功能（SSS、溶解、Halftone）
3. 減少貼圖層數
4. 降低貼圖解析度
5. 合併相同材質的物體
</details>

<details>
<summary><b>Q: 顏色看起來不對？</b></summary>

**A**: 
1. 確認貼圖導入設定（顏色貼圖 = sRGB，數據貼圖 = Linear）
2. 檢查 Color Space（建議使用 Linear）
3. 調整 `Saturation` 和 `Color Grading`
</details>

---

## 📚 文檔

- **[完整使用手冊](Assets/Shaders/CelShaded_Advanced_Manual.md)** - 詳細的參數說明和使用指南
- **[快速參考](Assets/Shaders/CelShaded_QuickReference.md)** - 常用參數速查表

---

## 🎓 學習資源

### 推薦教程
- [Unity Shader 入門精要](https://candycat1992.github.io/unity_shaders_book/)
- [賽璐璐渲染技術](https://www.youtube.com/watch?v=yhGjCzxJV3E)
- [Guilty Gear Xrd 技術分享](https://www.gdcvault.com/play/1022031/Guilty-Gear-Xrd-s-Art)

### 參考項目
- [Unity-Chan Toon Shader](https://github.com/unity3d-jp/UnityChanToonShaderVer2_Project)
- [MToon](https://github.com/Santarh/MToon)
- [lilToon](https://lilxyzw.github.io/lilToon/)

---

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

### 開發建議
1. Fork 本專案
2. 創建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

---

## 📄 授權

本專案採用 MIT 授權 - 詳見 [LICENSE](LICENSE) 文件

可自由用於:
- ✅ 個人專案
- ✅ 商業專案
- ✅ 修改和再分發
- ✅ 學習和教學

唯一要求: 保留原始版權聲明

---

## 🙏 致謝

感謝以下資源和社群:
- Unity Technologies
- Unity-Chan Project
- Guilty Gear 開發團隊
- Arc System Works
- 所有 NPR 渲染研究者和開發者

特別感謝開源社群的各種 Toon Shader 專案提供的靈感。

---

## 📞 聯繫方式

- **問題回報**: [GitHub Issues](https://github.com/walnut-almonds/UnityShaderPack/issues)
- **功能請求**: [GitHub Discussions](https://github.com/walnut-almonds/UnityShaderPack/discussions)

---

## 🗺️ 路線圖

### 計劃中的功能
- [ ] URP/HDRP 版本
- [ ] Shader Graph 版本
- [ ] 更多預設材質
- [ ] 視頻教程
- [ ] 光照探針支援優化
- [ ] GPU Instancing 支援
- [ ] 多光源支援改進

---

## ⭐ Star History

如果這個專案對你有幫助，請給我們一個 Star ⭐

[![Star History Chart](https://api.star-history.com/svg?repos=walnut-almonds/UnityShaderPack&type=Date)](https://star-history.com/#walnut-almonds/UnityShaderPack&Date)

---

## 📸 範例畫廊

*(在此處添加使用此 Shader 的截圖或作品)*

---

**製作**: Shader Advanced Team  
**版本**: 1.0.0  
**發布日期**: 2025-11-03  
**最後更新**: 2025-11-04

---

<p align="center">
  <b>🎨 讓你的 3D 作品更有風格！🎨</b>
</p>
