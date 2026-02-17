{
  description = "Blender from arbitrary upstream tarball";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      blenderUrl =
	"https://cdn.builder.blender.org/download/daily/blender-5.2.0-alpha+main.1280201420ea-linux.x86_64-release.tar.xz";
      blenderHash =
        "";

      blender = pkgs.stdenv.mkDerivation {
        pname = "blender-bin";
        version = "custom";

        src = pkgs.fetchurl {
          url = blenderUrl;
          hash = blenderHash;
        };

        nativeBuildInputs = [ pkgs.makeWrapper ];

        buildInputs = with pkgs; [
          wayland libdecor
          xorg.libX11 xorg.libXi xorg.libXxf86vm
          xorg.libXfixes xorg.libXrender
          libxkbcommon libGLU libglvnd
          numactl SDL2 libdrm ocl-icd
          stdenv.cc.cc.lib
          openal
          xorg.libSM xorg.libICE zlib
        ];

        unpackPhase = ''
          tar -xf $src
        '';

        installPhase = ''
          mkdir -p $out/libexec
          mv blender-* $out/libexec/blender

          mkdir -p $out/bin

          makeWrapper $out/libexec/blender/blender $out/bin/blender \
            --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:${pkgs.lib.makeLibraryPath buildInputs}
        '';

        meta.mainProgram = "blender";
      };

    in {
      packages.${system}.default = blender;
    };
}

