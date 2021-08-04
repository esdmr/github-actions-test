source (status dirname)/utils.fish
# TODO: Build docs to build/docs
exit

begin
    group Install
    assert pnpm i
    endgroup
end

begin
    group Build
    assert pnpm run build
    endgroup
end

begin
    group Build documentation
    assert pnpm run build-docs
    group endgroup
end
