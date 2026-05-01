{ ... }:
{
  flake.homeManagerModules.prismlauncher =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.prismlauncher.override {
          jdks = [
            pkgs.graalvmPackages.graalvm-ce
            pkgs.jdk17
            pkgs.jdk21
            pkgs.jdk8_headless
            pkgs.jre8
          ];
        })
      ];
    };
}
