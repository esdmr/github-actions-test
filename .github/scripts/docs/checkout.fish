source (status dirname)/utils.fish

begin
    group Checkout
    assert pushd master

    # Checkout to current branch
    groupcmd git worktree add --detach -b "$JOB_CURR_BRANCH" ../current \
        "origin/$JOB_CURR_BRANCH"
    or fail Could not setup a git worktree for the current branch.

    # Checkout to the documentation branch
    groupcmd git worktree add -b "$JOB_DOCS_BRANCH" ../docs \
        "origin/$JOB_DOCS_BRANCH"
    or fail Could not setup a git worktree for the documentation branch.

    assert popd
    endgroup
end
