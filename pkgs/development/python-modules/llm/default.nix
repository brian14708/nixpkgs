{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  click-default-group,
  condense-json,
  numpy,
  openai,
  pip,
  pluggy,
  puremagic,
  pydantic,
  python-ulid,
  pyyaml,
  sqlite-migrate,
  cogapp,
  pytest-asyncio,
  pytest-httpx,
  sqlite-utils,
}:
let
  llm = buildPythonPackage rec {
    pname = "llm";
    version = "0.25";
    pyproject = true;

    build-system = [ setuptools ];

    disabled = pythonOlder "3.8";

    src = fetchFromGitHub {
      owner = "simonw";
      repo = "llm";
      tag = version;
      hash = "sha256-iH1P0VdpwIItY1In7vlM0Sn44Db23TqFp8GZ79/GMJs=";
    };

    patches = [ ./001-disable-install-uninstall-commands.patch ];

    dependencies = [
      click-default-group
      condense-json
      numpy
      openai
      pip
      pluggy
      puremagic
      pydantic
      python-ulid
      pyyaml
      setuptools # for pkg_resources
      sqlite-migrate
      sqlite-utils
    ];

    nativeCheckInputs = [
      cogapp
      numpy
      pytest-asyncio
      pytest-httpx
      pytestCheckHook
    ];

    doCheck = true;

    pytestFlagsArray = [
      "-svv"
      "tests/"
    ];

    pythonImportsCheck = [ "llm" ];

    passthru = {
      inherit withPlugins;
    };

    meta = with lib; {
      homepage = "https://github.com/simonw/llm";
      description = "Access large language models from the command-line";
      changelog = "https://github.com/simonw/llm/releases/tag/${src.tag}";
      license = licenses.asl20;
      mainProgram = "llm";
      maintainers = with maintainers; [
        aldoborrero
        mccartykim
      ];
    };
  };

  withPlugins = throw ''
    llm.withPlugins was confusing to use and has been removed.
    Please migrate to using python3.withPackages(ps: [ ps.llm ]) instead.

    See https://nixos.org/manual/nixpkgs/stable/#python.withpackages-function for more usage examples.
  '';
in
llm
