{ lib, debug, wrapQtAppsHook }:

let inherit (lib) optionals; in

mkDerivation:

args:

let
  args_ = {

    nativeBuildInputs = (args.nativeBuildInputs or []) ++ optionals (!(args.dontWrapQtApps or false)) [ wrapQtAppsHook ];

  };
in

mkDerivation (args // args_)
