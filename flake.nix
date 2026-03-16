{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/92d295f588631b0db2da509f381b4fb1e74173c5";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        libPath =
          with pkgs;
          lib.makeLibraryPath [
            libGL
            libxkbcommon
            wayland
          ];
      in
      {
        devShell =
          with pkgs;
          mkShell {
            packages = [
              wasm-pack
              bacon
            ];
            buildInputs = [
              libiconv
              gcc
            ];
            RUST_SRC_PATH = rustPlatform.rustLibSrc;
            RUST_LOG = "debug";
            LD_LIBRARY_PATH = libPath;
          };
      }
    );
}
