source (status dirname)/utils.fish
# TODO: Build docs to build/docs
exit

assert pnpm i
assert pnpm run build
assert pnpm run build-docs
