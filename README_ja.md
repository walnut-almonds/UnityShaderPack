# Unity Shader Pack# 🎨 CelShaded Advanced Shader



カスタムUnityシェーダー（Built-in Render Pipeline）のコレクションと、サンプルマテリアルを自動生成するエディタツールです。[中文](README_zh-TW.md) | [English](README.md) | [日本語](README_ja.md)



## 含まれるシェーダー---

- Sand（プロシージャルグレイン）

- Metal（PBR）**150以上のパラメータ**を持つ、フル機能で高度にカスタマイズ可能なセルシェーディング（Cel-Shaded/Toon）Unity Shaderです。様々なNPR（非写実的レンダリング）のニーズに対応します。

- Plastic

- Emissive![Version](https://img.shields.io/badge/version-1.0-blue)

- Glass（屈折、IOR）![Unity](https://img.shields.io/badge/Unity-2019.4%2B-green)

- Gemstone（IOR、分散）![License](https://img.shields.io/badge/license-MIT-orange)



## 使い方---

1. このフォルダー/パッケージをUnityプロジェクト（Built-inパイプライン）にインポートします。

2. Unity Editorで、`Tools > Create Example Materials`を使用して、`Assets/Materials`にサンプルマテリアルを自動生成します。## ✨ 主な機能

3. シーン内のオブジェクトにマテリアルを割り当てます。

### 🎯 コア機能

## 必要環境- ✅ **多段階シャドウ** - 1〜10段階の調整可能なシャドウ

- Unity 2019.4+（Built-in Render Pipeline）- ✅ **アウトラインレンダリング** - 幅、色、距離フェードをカスタマイズ可能

- ✅ **マルチテクスチャレイヤー** - 3つのメインテクスチャレイヤー、複数のブレンドモード対応

## ライセンス- ✅ **柔軟なライティング制御** - 明度、彩度、色相の完全な調整

MIT- ✅ **MatCapサポート** - 3つのMatCapレイヤーで環境反射を簡単に追加

- ✅ **ノーマルマッピング** - 3つのノーマルマップブレンドレイヤー
- ✅ **高度なスペキュラ** - 異方性スペキュラサポート
- ✅ **デュアルリムライト** - 独立して制御可能なエッジライティング

### 🌟 特殊効果
- ✨ **エミッションシステム** - 3つのエミッションレイヤー + マスク + スクロールアニメーション
- ✨ **グリッターエフェクト** - 動的な輝きパーティクル、カラーマスク対応
- ✨ **サブサーフェススキャタリング (SSS)** - 肌やワックス素材に最適
- ✨ **ディゾルブエフェクト** - エッジグローを伴うディゾルブアニメーション
- ✨ **ハーフトーン/クロスハッチ** - コミック印刷スタイル
- ✨ **フレネル効果** - ガラスやエネルギーフィールドに最適
- ✨ **頂点アニメーション** - 組み込みの波アニメーションサポート

### 🎨 スタイライゼーションオプション
- 🖌️ 色相シフト
- 🖌️ カラーグレーディング
- 🖌️ 彩度/脱色
- 🖌️ 複数のライティングモデル
- 🖌️ 視差マッピング
- 🖌️ アンビエントオクルージョン
- 🖌️ ディテールマップ
- 🖌️ ステンシルサポート

---

## 📦 パッケージ内容

```
Assets/
├── Shaders/
│   ├── CelShaded_Advanced.shader          # メインShaderファイル
│   ├── CelShaded_Advanced_Manual.md       # 完全マニュアル
│   └── CelShaded_QuickReference.md        # クイックリファレンスガイド
│
└── Editor/
    ├── CelShadedAdvancedGUI.cs            # カスタムマテリアルエディタ
    └── CelShadedPresetCreator.cs          # プリセットマテリアル作成ツール
```

---

## 🚀 クイックスタート

### 1. Shaderのインポート
`Assets`フォルダ全体をUnityプロジェクトにドラッグします。

### 2. マテリアルの作成
Projectウィンドウで:
- 右クリック → Create → Material
- Inspectorで、Shaderドロップダウンから`Custom/CelShaded_Advanced`を選択

### 3. プリセットの使用
ツールウィンドウを開く:
```
Unityメニュー → Tools → CelShaded Advanced → Create Material Presets
```
ボタンをクリックしてプリセットマテリアルを作成します。

### 4. モデルへの適用
マテリアルをシーン内の3Dモデルにドラッグします。

---

## 🎯 マテリアルプリセット

7つの一般的なスタイルプリセットが含まれています:

| プリセット名 | 使用例 | 特徴 |
|-------------|--------|------|
| **Classic Anime** | アニメキャラクター | ハードエッジシャドウ、黒いアウトライン |
| **Metallic** | メカ、武器 | メタリックMatCap、強いスペキュラ |
| **Glowing Energy** | エネルギーエフェクト | 多層エミッション、フレネル |
| **Soft Illustration** | イラストスタイル | ソフトシャドウ、高彩度 |
| **Comic Book** | コミックスタイル | ハーフトーン、クロスハッチ |
| **Gem/Crystal** | 宝石、クリスタル | 透明度、グリッター、強い屈折 |
| **Skin with SSS** | キャラクター肌 | サブサーフェススキャタリング、ソフトシャドウ |

---

## 📖 コアパラメータクイックリファレンス

### 基本外観
```shader
// シャドウ
_ShadowColor           // シャドウカラー
_ShadowSharpness       // シャープネス (0-1)
_ShadowSteps           // ステップ数 (1-10)

// アウトライン
_OutlineWidth          // 幅 (0-0.1)
_OutlineColor          // カラー

// スペキュラ
_SpecularStrength      // 強度 (0-2)
_SpecularSharpness     // シャープネス (0-1)

// リムライト
_RimPower              // パワー (0.1-8)
_RimStrength           // 強度 (0-2)
```

### 特殊効果
```shader
// エミッション
_EmissionColor         // HDRカラー
_EmissionStrength      // 強度 (0-10)

// ディゾルブ
_UseDissolve           // 有効化
_DissolveAmount        // 進行度 (0-1)

// SSS
_UseSSS                // 有効化
_SSSStrength           // 強度 (0-1)
```

---

## 💻 スクリプト制御例

### 動的エミッション
```csharp
Material mat = GetComponent<Renderer>().material;

// 呼吸灯効果
float pulse = Mathf.Sin(Time.time * 2) * 0.5f + 0.5f;
mat.SetFloat("_EmissionStrength", pulse * 3);
```

### ディゾルブアニメーション
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

### UVスクロール
```csharp
void Update()
{
    Vector2 offset = mat.GetVector("_MainUVOffset");
    offset.x += Time.deltaTime * 0.1f;
    mat.SetVector("_MainUVOffset", offset);
}
```

---

## 🎬 使用例

### ✅ 適している用途
- アニメスタイルのゲームキャラクター
- カートゥーンスタイルの環境オブジェクト
- セルシェーディングレンダリング
- スタイライズドエフェクト
- NPRレンダリング実験
- コミック/イラストスタイルプロジェクト
- VRChatなどのバーチャルソーシャルプラットフォーム

### ⚠️ 適していない用途
- フォトリアリスティックレンダリング（PBR Shaderを使用してください）
- 超ローエンドモバイルデバイス（機能が多すぎる）
- Deferred Rendering（主にForward用に設計）

---

## ⚙️ 技術仕様

| 項目 | 仕様 |
|------|------|
| **Shader Model** | 3.0+ |
| **レンダーパイプライン** | Built-in Render Pipeline |
| **Unityバージョン** | 2019.4 LTS以上 |
| **対応プラットフォーム** | Windows, Mac, Linux, iOS, Android, WebGL, Console |
| **VRサポート** | ✅ Single Pass, Multi Pass |
| **ライティングモード** | Forward Rendering (主) |
| **パラメータ数** | 150+ |
| **テクスチャスロット** | 約30 |

---

## 📊 パフォーマンス推奨事項

### 🟢 モバイル最適化
```
- メインテクスチャレイヤー1つを使用
- 2段階シャドウ
- MatCap、SSS、Dissolveなどを無効化
- 小さいテクスチャを使用 (512-1024)
```

### 🟡 PC/コンソール
```
- 2〜3テクスチャレイヤー
- 2〜3段階シャドウ
- 1〜2 MatCap
- 基本エフェクト（リムライト、スペキュラ）
```

### 🔴 ハイエンドPC
```
- すべての機能を有効化
- 高解像度テクスチャ (2048+)
- 複数エフェクトレイヤー
```

---

## 🐛 FAQ

<details>
<summary><b>Q: シャドウが表示されない？</b></summary>

**A**: 確認事項:
1. シーンにDirectional Lightがあるか？
2. `Shadow Strength`が0より大きいか？
3. モデルがシャドウを受け取る設定か？（Cast/Receive Shadows）
</details>

<details>
<summary><b>Q: 特定の角度でアウトラインが消える？</b></summary>

**A**: 
1. モデルの法線が正しいか確認
2. `Outline Z Offset`を調整
3. アウトライン幅が大きすぎないか確認
</details>

<details>
<summary><b>Q: 透明マテリアルのソート問題？</b></summary>

**A**: 
1. 正しいRender Queue (3000+)を設定
2. ZWriteを無効化
3. Alpha BlendではなくAlpha Test (Cutout)の使用を検討
</details>

<details>
<summary><b>Q: パフォーマンスが悪い？</b></summary>

**A**: 
1. Frame DebuggerでDraw Callsを確認
2. 不要な機能を無効化（SSS、Dissolve、Halftone）
3. テクスチャレイヤー数を減らす
4. テクスチャ解像度を下げる
5. 同じマテリアルのオブジェクトを結合
</details>

<details>
<summary><b>Q: 色がおかしい？</b></summary>

**A**: 
1. テクスチャインポート設定を確認（カラーテクスチャ = sRGB、データテクスチャ = Linear）
2. Color Spaceを確認（Linear推奨）
3. `Saturation`と`Color Grading`を調整
</details>

---

## 📚 ドキュメント

- **[完全マニュアル](Assets/Shaders/CelShaded_Advanced_Manual.md)** - 詳細なパラメータ説明と使用ガイド
- **[クイックリファレンス](Assets/Shaders/CelShaded_QuickReference.md)** - 一般的なパラメータ参照表

---

## 🎓 学習リソース

### 推奨チュートリアル
- [Unity Shader入門精要](https://candycat1992.github.io/unity_shaders_book/)
- [セルシェーディングレンダリング技術](https://www.youtube.com/watch?v=yhGjCzxJV3E)
- [Guilty Gear Xrd技術プレゼンテーション](https://www.gdcvault.com/play/1022031/Guilty-Gear-Xrd-s-Art)

### 参考プロジェクト
- [Unity-Chan Toon Shader](https://github.com/unity3d-jp/UnityChanToonShaderVer2_Project)
- [MToon](https://github.com/Santarh/MToon)
- [lilToon](https://lilxyzw.github.io/lilToon/)

---

## 🤝 貢献

IssueとPull Requestを歓迎します！

### 開発ガイドライン
1. このプロジェクトをFork
2. 機能ブランチを作成 (`git checkout -b feature/AmazingFeature`)
3. 変更をコミット (`git commit -m 'Add some AmazingFeature'`)
4. ブランチにPush (`git push origin feature/AmazingFeature`)
5. Pull Requestを開く

---

## 📄 ライセンス

このプロジェクトはMITライセンスの下でライセンスされています - [LICENSE](LICENSE)ファイルを参照

自由に使用できます:
- ✅ 個人プロジェクト
- ✅ 商用プロジェクト
- ✅ 改変と再配布
- ✅ 学習と教育

唯一の要件: 元の著作権表示を保持

---

## 🙏 謝辞

以下のリソースとコミュニティに感謝します:
- Unity Technologies
- Unity-Chanプロジェクト
- Guilty Gear開発チーム
- Arc System Works
- すべてのNPRレンダリング研究者と開発者

オープンソースコミュニティの様々なToon Shaderプロジェクトにインスピレーションを頂きました。

---

## 📞 お問い合わせ

- **問題報告**: [GitHub Issues](https://github.com/walnut-almonds/UnityShaderPack/issues)
- **機能リクエスト**: [GitHub Discussions](https://github.com/walnut-almonds/UnityShaderPack/discussions)

---

## 🗺️ ロードマップ

### 予定機能
- [ ] URP/HDRPバージョン
- [ ] Shader Graphバージョン
- [ ] より多くのマテリアルプリセット
- [ ] ビデオチュートリアル
- [ ] ライトプローブサポート最適化
- [ ] GPU Instancingサポート
- [ ] マルチライトサポート改善

---

## ⭐ Star History

このプロジェクトがお役に立ちましたら、Starをお願いします ⭐

[![Star History Chart](https://api.star-history.com/svg?repos=walnut-almonds/UnityShaderPack&type=Date)](https://star-history.com/#walnut-almonds/UnityShaderPack&Date)

---

## 📸 ギャラリー

*(このShaderを使用したスクリーンショットや作品をここに追加)*

---

**作成者**: Shader Advanced Team  
**バージョン**: 1.0.0  
**リリース日**: 2025-11-03  
**最終更新**: 2025-11-04

---

<p align="center">
  <b>🎨 あなたの3D作品をもっとスタイリッシュに！🎨</b>
</p>
