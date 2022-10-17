{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, adafruit-platformdetect
, adafruit-pureio
, pyftdi
, setuptools-scm
# , adafruit-circuitpython-typing
}:

buildPythonPackage rec {
  pname = "adafruit-blinka";
  version = "8.5.0";

  disabled = pythonOlder "3.7.0"; # requires python version >=3.7.0

  src = fetchPypi {
    pname = "Adafruit-Blinka";
    inherit version;
    sha256 = "1c551caa5962dc9475f0c131f6cfe700a53f5f2f7a017fd5967b40644d180ade";
  };

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "adafruit-circuitpython-typing" ""
    substituteInPlace setup.py \
      --replace "\"adafruit-circuitpython-typing\"," ""
  '';
  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # Adafruit-PlatformDetect (>=3.13.0)
  # Adafruit-PureIO (>=1.1.7)
  # pyftdi (>=0.40.0)
  propagatedBuildInputs = [
    adafruit-platformdetect
    adafruit-pureio
    pyftdi
    setuptools-scm
    # adafruit-circuitpython-typing
  ];

  meta = with lib; {
    description = "CircuitPython APIs for non-CircuitPython versions of Python such as CPython on Linux and MicroPython";
    homepage = https://github.com/adafruit/Adafruit_Blinka;
    license = licenses.mit;
    # maintainers = [ maintainers. ];
  };
}
