# Toolchain contract

## Native commands
- `zig fmt --check build.zig src/*.zig`
- `zig build`
- `zig build test`

## Current host note
- On this workstation, Homebrew Zig 0.15.2 fails the native Darwin link step for `zig build` and `zig build test`.
- Docker is therefore the authoritative validation gate for this repo until the host-native linker issue is resolved.

## Docker commands
- `docker build -t zig-stakeholder .`
- `docker run --rm zig-stakeholder --list-values`
- `docker run --rm zig-stakeholder --dev-type backend --complexity medium --seed docker-code --focus-family code_analyzer --output-format json`
- `docker run --rm zig-stakeholder --dev-type dev-ops --complexity high --seed docker-delivery --focus-family delivery_preview_ops --output-format json`

## CI workflows
- `ci-native`
- `docker-smoke`
- `actionlint`
- `dependency-review`

## Current limitation
- `flake.lock` has not been generated locally because `nix` is not installed in the current environment.
