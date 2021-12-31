#!/usr/bin/env sh
cd /tmp

rm -rf nix-cargo-integration-test
mkdir nix-cargo-integration-test
cd nix-cargo-integration-test

nix --version

nix_flake="nix --experimental-features 'nix-command flakes'"

nix-shell --pure --packages \
    cargo \
    nixUnstable \
    curl \
    cacert \
    git \
    --command "
cargo init
cargo run

${nix_flake} --version
${nix_flake} run github:yusdacra/rust-nix-templater

git init
git config user.name name
git config user.email email@domain.tld
git add .
git commit --allow-empty-message --no-edit

${nix_flake} run
"
