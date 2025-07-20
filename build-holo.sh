#!/bin/bash
set -euo pipefail

apt-get update
apt-get install -y \
		build-essential \
		cmake \
		libpcre2-dev \
		protobuf-compiler
git clone https://github.com/holo-routing/holo.git
git clone https://github.com/holo-routing/holo-cli.git

rustup toolchain install nightly

# Build holod and work around no libyang3 in Debian Bookworm.
cd holo
sed -i 's/^yang3.*/yang3 = { version = "0.17", features = ["bundled"] }/' Cargo.toml
cargo +nightly build --release

# Build holo-cli and update Rust edition.
cd ../holo-cli
sed -i 's/^edition.*/edition = "2024"/' Cargo.toml
cargo +nightly build --release
