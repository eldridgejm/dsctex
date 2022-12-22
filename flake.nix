{
  description = "LaTeX style and class files used in DSC courses @ UCSD.";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
      {
        devShell = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
            pkgs.mkShell {
              buildInputs = [
                pkgs.mkdocs

                # latex environment
                (
                  pkgs.texlive.combine {
                    inherit (pkgs.texlive)
                    scheme-full;
                  }
                )

                # python environment
                (
                  pkgs.python3.withPackages (ps: [
                      ps.mkdocs-material
                    ]
                  )
                )
              ];

              shellHook = ''
                # add latex sty and cls files to search path
                export TEXINPUTS=$(pwd)/src:
              '';
            }
        );

        defaultPackage = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
            pkgs.stdenv.mkDerivation rec {
              name = "dsctex";
              src = ./.;
              installPhase = ''
                mkdir -p $out
                cp src/* $out/
              '';
              pname = name;
              tlType = "run";
            }
          );
      };

}
