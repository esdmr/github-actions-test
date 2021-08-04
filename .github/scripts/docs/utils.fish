function group
    echo "::group::$argv"
end

function endgroup
    echo ::endgroup::
end

function groupcmd
    group Run: (string escape -- $argv)
    $argv
    set -l cmd_status $status
    endgroup
    return $cmd_status
end

function print-stack-trace
    echo # Empty line
    set_color -d

    status print-stack-trace |
        tail -n +3 |
        string replace -r ' with arguments .*$' ''

    set_color normal
    echo # Empty line
end

function set_color_of -a message
    echo -n (set_color $argv[2..])"$message"(set_color normal)
end

function set_color_like -a type -a message
    switch "$type"
        case fail FAIL
            set_color_of " $message " -or red
        case var VAR
            set_color_of "$message" brred
        case str STR
            set_color_of (string escape -- "$message") yellow
        case \*
            echo >&2 # Empty line
            echo (set_color_like fail FAIL) Invalid message type: \
                (set_color_like str "$type") >&2

            print-stack-trace >&2
            exit 1
    end
end

function fail
    set -l command_status $status
    echo # Empty line
    echo (set_color_like fail FAIL) $argv >&2
    print-stack-trace >&2

    if test $command_status -eq 0
        exit 1
    else
        exit $command_status
    end
end

function assert
    $argv
    or fail Failed to run command: \
        (string escape -- $argv | string join ' ' | fish_indent --ansi)
end

if not set -q GITHUB_ACTIONS
    fail This script assumes a CI environment not currently present.
end

if not set -q JOB_CURR_BRANCH
    group Find current branch

    set -gx JOB_CURR_BRANCH (string replace -ir '^refs/heads/' '' "$GITHUB_REF")
    or fail Variable (set_color_like var '$GITHUB_REF') is not properly setup. \
        This script assumes that it follows the pattern: \
        (set_color_like str 'refs/heads/**')

    echo Current branch is "$JOB_CURR_BRANCH."
    endgroup
end
