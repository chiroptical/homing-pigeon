# These are used to override the libtorch-bin sources, hasktorch requires 1.9.0 currently
version:
builtins.getAttr version {
  "1.11.0" = {
    x86_64-darwin-cpu = {
      name = "libtorch-macos-1.11.0.zip";
      url = "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.11.0.zip";
      hash = "sha256-TOJ+iQpqazta46y4IzIbfEGMjz/fz+pRDV8fKqriB6Q=";
    };
    x86_64-linux-cpu = {
      name = "libtorch-cxx11-abi-shared-with-deps-1.11.0-cpu.zip";
      url = "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.11.0%2Bcpu.zip";
      hash = "sha256-zC3lyeQrZJAkwingIbbjTkLXngsEaVv6VCl3QbAjOMQ=";
    };
    x86_64-linux-cuda = {
      name = "libtorch-cxx11-abi-shared-with-deps-1.11.0-cu113.zip";
      url = "https://download.pytorch.org/libtorch/cu113/libtorch-cxx11-abi-shared-with-deps-1.11.0%2Bcu113.zip";
      hash = "sha256-dRu4F8k2SAbtghwrPJNyX0u3tsODCbXfi9EqUdf4xYc=";
    };
  };
}
