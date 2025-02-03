{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          templ
          nodejs
          jq
          air
          go
        ];

        shellHook = ''
          export GOPATH="$HOME/go"
          export PATH=$PATH:$GOPATH/bin
        '';
      };
    });
}
