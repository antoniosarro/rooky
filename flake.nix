{
  description = "A Nix-flake-based Node.js development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  outputs = {
    self,
    nixpkgs,
  }: let
    allSystems = ["x86_64-linux"];

    forAllSystems = fn:
      nixpkgs.lib.genAttrs allSystems
      (system: fn {pkgs = import nixpkgs {inherit system;};});
  in {
    devShells = forAllSystems ({pkgs}: {
      default = pkgs.mkShell {
        shellHook = ''
          echo "🚀 Welcome to Go development environment"
           echo "Go version: $(go version)"
        '';
        packages = with pkgs; [
          # Go related
          go
          gopls
          go-tools
          golangci-lint

          # Build tools
          gcc
          gnumake
        ];
        env = {
          GOPATH = "${placeholder "out"}/go";
          CGO_ENABLED = "1";
        };
      };
    });
  };
}
