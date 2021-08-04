source (status dirname)/utils.fish

begin
    group Checkout
    assert pushd master

    # Checkout to the documentation branch
    groupcmd git worktree add ../docs "$JOB_DOCS_BRANCH"
    or fail Could not setup a git worktree for the documentation branch.

    # Checkout to current branch
    if test "$JOB_CURR_BRANCH" = master
        echo Current branch is master, creating a symbolic link…
        # Git worktrees must be unique. If the current branch is master, we must
        # use a symbolic link instead. The current branch is assumed not to be
        # the documentation branch.
        groupcmd ln -vs (pwd) ../current
        or fail Could not create a symbolic link for the current branch.
    else
        groupcmd git worktree add ../current "$JOB_CURR_BRANCH"
        or fail Could not setup a git worktree for the current branch.
    end

    assert popd
    endgroup
end

begin
    group Sanity test
    assert groupcmd test -f source/pnpm-lock.yaml
    set -l pages_lockfiles master/.github/pages-template/**/pnpm-lock.yaml
    assert groupcmd test (count $pages_lockfiles) -gt 0

    for file in pages_lockfiles
        assert groupcmd test -f $file
    end

    endgroup
end
