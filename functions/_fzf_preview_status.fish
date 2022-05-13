function _fzf_preview_status
    set -l path (string split ' ' $argv)[-1]
    if string match -r '^\?\?' $argv >/dev/null
        echo Untracked
        echo
        _fzf_preview_file $path
    else if string match -r '^A\s\s\S' $argv >/dev/null
        echo -e (set_color green)New file
        echo
        git diff --color=always -- /dev/null $path
    else
        if string match -r '\S\s\S' $argv >/dev/null
            echo -e (set_color red)Unstaged
            echo
            git diff --color=always -- $path
            echo
        end
        if string match -r '\S\s\s\S|\S\S\s\S' $argv >/dev/null
            echo -e (set_color green)Staged
            echo
            git diff --color=always --cached HEAD -- $path
        end
    end
end
