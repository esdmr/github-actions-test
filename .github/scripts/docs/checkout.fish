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
