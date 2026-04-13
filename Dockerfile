FROM debian:bookworm-slim AS build
ARG ZIG_VERSION=0.15.2
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl xz-utils && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
RUN arch="$(dpkg --print-architecture)" && \
    case "$arch" in \
      arm64) zig_arch="aarch64-linux" ;; \
      amd64) zig_arch="x86_64-linux" ;; \
      *) echo "unsupported architecture: $arch" >&2; exit 1 ;; \
    esac && \
    curl -fsSL "https://ziglang.org/download/${ZIG_VERSION}/zig-${zig_arch}-${ZIG_VERSION}.tar.xz" -o zig.tar.xz && \
    tar -xf zig.tar.xz && \
    mv "zig-${zig_arch}-${ZIG_VERSION}" /opt/zig
ENV PATH=/opt/zig:$PATH
WORKDIR /src
COPY . .
RUN zig fmt --check build.zig src/*.zig
RUN zig build test
RUN zig build -Doptimize=ReleaseSafe

FROM debian:bookworm-slim AS runtime
COPY --from=build /src/zig-out/bin/zig-stakeholder /usr/local/bin/zig-stakeholder
ENTRYPOINT ["/usr/local/bin/zig-stakeholder"]
