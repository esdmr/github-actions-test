source (status dirname)/utils.fish

begin
    group Checkout
    assert pushd master

    # Checkout to current branch
    groupcmd git worktree add --detach ../current "$JOB_CURR_BRANCH"
    or fail Could not setup a git worktree for the current branch.

    # Checkout to the documentation branch
    groupcmd git worktree add ../docs "$JOB_DOCS_BRANCH"
    or fail Could not setup a git worktree for the documentation branch.

    assert popd
    endgroup
end

begin
    group Sanity test
    find . -not -name .git -or -name .git -prune
    assert groupcmd test -f source/pnpm-lock.yaml
    set -l pages_lockfiles master/.github/pages-template/**/pnpm-lock.yaml
    assert groupcmd test (count $pages_lockfiles) -gt 0

    for file in pages_lockfiles
        assert groupcmd test -f $file
    end

    endgroup
end
