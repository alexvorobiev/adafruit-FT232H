{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:
with pkgs;
let
  adafruit-circuitpython-typing = python3.pkgs.callPackage ./adafruit-circuitpython-typing {};
in
mkShell {
  BLINKA_FT232H=1;
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = [
    (python3.withPackages (ps: with python3Packages; [
      ipython
      python-lsp-server
      pyftdi
      (python3.pkgs.callPackage ./adafruit-blinka {  })
    ]))
    libusb1
    # usbip-linux
  ];
}
