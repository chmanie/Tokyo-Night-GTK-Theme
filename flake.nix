{
  description = "A flake for the Tokyo Night GTK Theme";

  # Define the inputs for your flake
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Use the `flake-utils` to support multiple systems
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # Get the package set for the specific system
        pkgs = import nixpkgs {
          inherit system;
        };

        # Define the custom GTK theme package
        tokyo-night-gtk-theme = pkgs.stdenvNoCC.mkDerivation {
          pname = "tokyo-night-gtk-theme";
          version = "unstable-2023-11-14"; # This should be updated to reflect the current date or version

          src = pkgs.fetchFromGitHub {
            owner = "chmanie";
            repo = "Tokyo-Night-GTK-Theme";
            rev = "e9790345a6231cd6001f1356d578883fac52233a";
            # The sha256 should be the hash of the commit you want to fetch
            # This hash must be updated to match the hash of the specific commit you are fetching
            sha256 = "sha256-Q9UnvmX+GpvqSmTwdjU4hsEsYhA887wPqs5pyqbIhmc=";
          };

          # Install phase
          installPhase = ''
            mkdir -p $out/share/themes/
            mkdir -p $out/share/icons/
            cp -r themes/Tokyonight-Dark-B-LB $out/share/themes/
            cp -r themes/Tokyonight-Dark-B $out/share/themes/
            cp -r themes/Tokyonight-Dark-BL-LB $out/share/themes/
            cp -r themes/Tokyonight-Dark-BL $out/share/themes/
            cp -r themes/Tokyonight-Storm-B-LB $out/share/themes/
            cp -r themes/Tokyonight-Storm-B $out/share/themes/
            cp -r themes/Tokyonight-Storm-BL-LB $out/share/themes/
            cp -r themes/Tokyonight-Storm-BL $out/share/themes/
            cp -r icons/Tokyonight-Dark-Cyan $out/share/icons/
            cp -r icons/Tokyonight-Dark $out/share/icons/
            cp -r icons/Tokyonight-Light $out/share/icons/
            cp -r icons/Tokyonight-Moon $out/share/icons/
          '';
        };
      in {
        # The outputs of the flake, such as packages and apps
        packages = {
          tokyo-night-gtk-theme = tokyo-night-gtk-theme;
        };
        defaultPackage = tokyo-night-gtk-theme;
      }
    );
}
