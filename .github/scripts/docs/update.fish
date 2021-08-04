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
    group Build
    assert env --chdir=current fish .github/scripts/docs/build.fish
    endgroup
end

begin
    group Add front-matter for every file
    assert pushd current/build/docs

    for filename in **.md
        sed -i "1i ---\\
parent: $JOB_CURR_BRANCH\\
---" $filename
        or fail Failed to add front-matter for file: (set_color_like str $filename)

        echo Modified $filename
    end

    assert popd
    endgroup
end

begin
    group Create index for branch

    set nav_order (
        if test "$JOB_CURR_BRANCH" = master
            echo 2
        else
            math 10 + (string match -r '^releases/(\d+)' "$JOB_CURR_BRANCH")[2]
        end
    )

    echo Page order is "$nav_order"

    echo "---
nav_order: $nav_order
title: $JOB_CURR_BRANCH
has_children: true
---
# $JOB_CURR_BRANCH

From commit [$JOB_COMMIT_ORIGINAL_ID]($JOB_COMMIT_ORIGINAL_URL)" >build/docs/index.md
    echo Wrote index.md
    endgroup
end

begin
    group Copy folders to the documentation branch

    groupcmd rm -vrf "docs/$JOB_CURR_BRANCH/"
    or fail Failed to remove the old directory from the documentation branch.

    groupcmd mkdir -vp "docs/$JOB_CURR_BRANCH/"
    or fail Failed to create a new directory in the documentation branch.

    groupcmd mv -vf current/build/docs/* "docs/$JOB_CURR_BRANCH"
    or fail Failed to move the documentation to the documentation branch

    endgroup
end

begin
    group Commit and push changes
    assert pushd docs
    groupcmd git add .
    or fail Failed to add all the changes to the documentation branch.

    groupcmd git commit \
        --author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
        --message "$JOB_COMMIT_MESSAGE"
    or fail Failed to commit the changes to the documentation branch.

    groupcmd git push origin "$JOB_DOCS_BRANCH"
    or fail Failed to push the changes to the remote.

    assert popd
    endgroup
end
