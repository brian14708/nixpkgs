{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  pillow,
  rich,
  pytestCheckHook,
  pythonOlder,
  syrupy,
}:

buildPythonPackage rec {
  pname = "rich-pixels";
  version = "3.0.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "darrenburns";
    repo = "rich-pixels";
    tag = version;
    hash = "sha256-Sqs0DOyxJBfZmm/SVSTMSmaaeRlusiSp6VBnJjKYjgQ=";
  };

  pythonRelaxDeps = [ "pillow" ];

  build-system = [ hatchling ];

  dependencies = [
    pillow
    rich
  ];

  nativeCheckInputs = [
    pytestCheckHook
    syrupy
  ];

  pythonImportsCheck = [ "rich_pixels" ];

  meta = with lib; {
    description = "Rich-compatible library for writing pixel images and ASCII art to the terminal";
    homepage = "https://github.com/darrenburns/rich-pixels";
    changelog = "https://github.com/darrenburns/rich-pixels/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
