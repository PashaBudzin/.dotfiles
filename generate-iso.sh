#!/usr/bin/env bash

rm -rf ./result

nix run nixpkgs#nixos-generators -- --format iso --flake .#installerIso -o result
