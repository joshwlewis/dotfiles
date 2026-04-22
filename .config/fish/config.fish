if type -q mise
    mise activate fish | source
end

if status is-interactive
    if type -q fzf
        fzf --fish | source
    end

    if type -q starship
        starship init fish | source
    end
end
