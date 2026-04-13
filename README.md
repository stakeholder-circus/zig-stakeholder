> [!IMPORTANT]
> This repository is part of a Codex-assisted rewrite experiment. All changes are manually reviewed, a human remains in the loop, and missing behavior is tracked explicitly rather than hidden. The project exists for fun, research, language learning, AI agent workflow/planning, interop experiments, and code review testing.
# zig-stakeholder

Zig parity target under `stakeholder-circus`.

## Status
- Active local implementation tranche.
- Imported Rust history is preserved for attribution and auditability.
- Classic-six and modern-core are implemented locally with deterministic normalized JSON and explicit allocator wiring.
- Docker validation is green for build, test, list-values, representative family JSON smokes, deterministic same-seed output, and experimental-provider fail-fast.
- This repo remains local-only and is not for push until the program-wide 10-full-rewrites publication guardrail is met.

## Role
- Execution-minimalism baseline parity target.
- Purpose: Deterministic CLI output with explicit allocator use, explicit errors, and no hidden runtime magic.
- Program category: systems minimalism, interop

## Commands
- `zig fmt --check build.zig src/*.zig`
- `zig build`
- `zig build test`
- `docker build -t zig-stakeholder .`
- `docker run --rm zig-stakeholder --list-values`

## Documentation
- [AI disclosure](AI_DISCLOSURE.md)
- [Parity](PARITY.md)
- [Explicit gaps](GAPS.md)
- [Remotes](docs/remotes.md)
- [Provenance](docs/provenance.md)
- [Toolchain](docs/toolchain.md)
- [Traceability](docs/traceability/first-push-families.md)
