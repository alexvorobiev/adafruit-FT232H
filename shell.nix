{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:
with pkgs;
mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = [
    (python3.withPackages (ps: with python3Packages; [
      ipython
      python-lsp-server
      pyftdi
      (python3.pkgs.callPackage ./adafruit-blinka {})
    ]))
    libusb1
    # usbip-linux
  ];
}
