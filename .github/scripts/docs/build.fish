source (status dirname)/utils.fish
# TODO: Build docs to build/docs
exit

assert groupcmd pnpm i
assert groupcmd pnpm run build
assert groupcmd pnpm run build-docs
