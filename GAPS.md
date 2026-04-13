> [!NOTE]
> Missing or deferred behavior must fail fast and be tracked explicitly. No placeholder behavior should mask absent parity work.

# Zig Gaps

## Current explicit gaps
- `zig-stakeholder.ai-governance-fallback`: AI-governance families still use grouped fallback renderers.
- `zig-stakeholder.security-blockchain-fallback`: security/blockchain families still use grouped fallback renderers.
- `zig-stakeholder.health-protocol-fallback`: health/protocol families still use grouped fallback renderers.
- `zig-stakeholder.overlay-quantum-fallback`: overlay/quantum families still use grouped fallback renderers.
- `zig-stakeholder.live-provider-pending`: experimental provider flags are parsed and fail fast; live-provider integration is not implemented.
- `zig-stakeholder.github-required-check-binding-pending`: exact required GitHub checks stay deferred until the repo has a remote and stable CI contexts.
- `zig-stakeholder.flake-lock-pending`: `flake.nix` is present, but `flake.lock` remains pending until `nix` is installed locally.
- `zig-stakeholder.host-native-zig-linker-blocked`: on this workstation, Homebrew Zig 0.15.2 fails the native Darwin link step even though Docker validation is green; treat Docker as the current release gate until the host toolchain issue is resolved.

## Guardrail
- This repo must not be pushed or published until the program-level guardrail of 10 new full rewrites with tests is met.
