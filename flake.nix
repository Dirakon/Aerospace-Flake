{
  description = "An i3-like tiling window manager for macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.aarch64-darwin.default =
      with import nixpkgs
        {
          system = "aarch64-darwin";
        };
      let version = "v0.14.2-Beta"; in
      stdenv.mkDerivation {
        name = "aerospace";
        version = version;
        src = fetchzip {
          url = "https://github.com/nikitabobko/AeroSpace/releases/download/${version}/AeroSpace-${version}.zip";
          hash = "sha256-v2D/IV9Va0zbGHEwSGt6jvDqQYqha290Lm6u+nZTS3A=";
        };

        unpackPhase = ''
          # Put .app file in a separate folder, so that home-manager properly registers it:
          # see https://github.com/nix-community/home-manager/blob/3d65009effd77cb0d6e7520b68b039836a7606cf/modules/targets/darwin/linkapps.nix
          mkdir -p $out/Applications/
          cp -r $src/AeroSpace.app $out/Applications/AeroSpace.app

          # Copy the rest of the files
          cp -r -u  $src/* $out/
        '';
      };

  };
}
