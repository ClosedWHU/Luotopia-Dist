# Luotopia-Dist

Luotopia（珞家）的包管理器分发元数据仓库，由 [ClosedWHU/Luotopia](https://github.com/ClosedWHU/Luotopia) 的 release workflow 在每个 Release 构建完成后自动渲染并推送——**本仓库内容全部由 CI 生成，请勿手改**（改动会在下次发布时被覆盖）。

## Scoop（Windows）

```powershell
scoop bucket add luotopia https://github.com/ClosedWHU/Luotopia-Dist
scoop install luotopia
scoop update luotopia   # 升级
```

清单在 `bucket/luotopia.json`，按架构自动选择 x64 / arm64 便携 zip。

## Nix（Linux）

```sh
nix profile install github:ClosedWHU/Luotopia-Dist
# 或临时运行
nix run github:ClosedWHU/Luotopia-Dist
```

`flake.nix` 提供 `x86_64-linux` / `aarch64-linux` 两个包（包装 Release 的 tar.gz，autoPatchelf 处理依赖）。

## winget/

每个 Release 自动生成的 winget 三件套清单归档（最新版本）。官方社区源（microsoft/winget-pkgs）合并之前，可以下载后本地验证：

```powershell
winget install --manifest .\winget
```

## Homebrew

brew tap 需要 `homebrew-` 前缀的仓库名才能用短命令，因此单独放在 [ClosedWHU/homebrew-luotopia](https://github.com/ClosedWHU/homebrew-luotopia)。

## 其它渠道

- **AUR**：[luotopia-bin](https://aur.archlinux.org/packages/luotopia-bin)（同样由 release workflow 自动推送）
- **GitHub Release**：APK / zip / MSIX / tar.gz / AppImage / deb / flatpak / DMG 直下，见 [Releases](https://github.com/ClosedWHU/Luotopia/releases)
