{
  description = "Luotopia (珞家) — 武汉大学一站式数字校园客户端";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      version = "1.3.0+19";
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      sources = {
        x86_64-linux = {
          url = "https://github.com/ClosedWHU/Luotopia/releases/download/v1.3.0+19/luotopia-1.3.0-19-linux-x64.tar.gz";
          sha256 = "sha256-YLLz/cJS6/jvE0AgNumf3uC1IOdedhkL5x7qvWSDc+E=";
        };
        aarch64-linux = {
          url = "https://github.com/ClosedWHU/Luotopia/releases/download/v1.3.0+19/luotopia-1.3.0-19-linux-arm64.tar.gz";
          sha256 = "sha256-kkGANyNQC3prqtyZfXCbJf5wcT+TqEbr7kj0Oi57pOA=";
        };
      };
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.stdenv.mkDerivation {
          pname = "luotopia";
          inherit version;
          src = pkgs.fetchurl { inherit (sources.${pkgs.system}) url sha256; };
          sourceRoot = "luotopia";
          nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper copyDesktopItems ];
          buildInputs = with pkgs; [
            gtk3
            webkitgtk_4_1
            libsecret
            libayatana-appindicator
            util-linux
            xz
            glib
            gdk-pixbuf
          ];
          dontConfigure = true;
          dontBuild = true;
          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "luotopia";
              desktopName = "Luotopia";
              comment = "Luotopia (珞家) — 武汉大学一站式数字校园客户端";
              exec = "luotopia %u";
              icon = "luotopia";
              startupWMClass = "luotopia";
              categories = [ "Education" "Utility" ];
              keywords = [ "WHU" "campus" ];
              mimeTypes = [ "x-scheme-handler/luotopia" ];
            })
          ];
          installPhase = ''
            runHook preInstall
            mkdir -p $out/opt $out/bin $out/share/icons/hicolor/256x256/apps
            cp -a . $out/opt/luotopia
            chmod 755 $out/opt/luotopia/luotopia
            makeWrapper $out/opt/luotopia/luotopia $out/bin/luotopia
            install -Dm644 data/flutter_assets/assets/icon/icon.png \
              $out/share/icons/hicolor/256x256/apps/luotopia.png
            runHook postInstall
          '';
        };
      });
    };
}
