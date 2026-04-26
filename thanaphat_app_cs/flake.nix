{
  description = "Flutter development environment for Movie Discovery App";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, devshell, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default = devshell.legacyPackages.${system}.mkShell {
        name = "movie-discovery-app";
        
        packages = with pkgs; [
          flutter
        ];

        env = [
          { name = "FLUTTER_ALREADY_LOCKED"; value = "1"; }
          { name = "ANDROID_HOME"; value = "/home/james/Android/Sdk"; }
          { name = "CHROME_EXECUTABLE"; value = "brave"; } # หรือ google-chrome-stable
        ];

        # สร้างทางลัดให้ IDE
        bash.extra = ''
          ln -sfn ${pkgs.flutter} .flutter-sdk
          echo "🚀 Flutter SDK linked to .flutter-sdk"
          echo "💡 Tip: Set your IDE Flutter SDK path to: $(pwd)/.flutter-sdk"
        '';
      };
    };
}